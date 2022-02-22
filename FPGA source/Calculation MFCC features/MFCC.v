`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 15:11:56
// Design Name: 
// Module Name: MFCC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MFCC(
    input g_clk,
    input bclk,
    
    input tvalid_float32,
    input [31:0] float32,
    
    output tready_mfcc_vector_features,
    output [31:0] mfcc_vector_features
    );
    
    // Pre-emphasis:
    wire tvalid_filtered_stream;
    wire [31:0] filtered_stream;
    
    // Framing stream:
    wire tvalid_framing_stream;
    wire [31:0] framing_stream;
    
    // Windowing:
    wire tready_hamm_stream;
    wire [31:0] hamm_stream;
    
    // FFT:
    wire tready_powspectr;
    wire [31:0] powspectr;
    
    // Total energy in each frame:
    wire tready_log_energy;
    wire [31:0] log_energy;
    
    // Get filterbanks
    wire [31:0] feat_filterbanks;
    wire tvalid_feat_filterbanks;
    reg [31:0] feat_filterbanks_none_zero;
    reg tvalid_feat_filterbanks_none_zero;
    
    // Log banks:
    wire tvalid_log_filterbanks;
    wire [31:0] log_filterbanks;
    
    // DCT 2:
    wire tvalid_dct2_sample;
    wire [31:0] dct2_sample;
    
    // DCT 2 coefficients:
    wire tvalid_dct2_feat;
    wire [31:0] dct2_feat;
    
    // Lifter:
    wire tvalid_mfcc_feat;
    wire [31:0] mfcc_feat;
    
    // Append energy to mfcc vector:
    wire tready_mfcc_appened_energy;
    wire [31:0] mfcc_appened_energy;
    
    // Form SVM for model's inputs:
    wire tvalid_SVM;
    wire [31:0] SVM;
    
    // Pre-emphasis:
    Pre_emphasis pre_filtering (
        .clk(bclk),
        .tvalid_input_stream(tvalid_float32),
        .input_stream(float32),
        .tvalid_filtered_stream(tvalid_filtered_stream),
        .filtered_stream(filtered_stream)
    );
    
    // Framing stream:
    get_frames framing (
        .clk_slow(bclk),
        .clk_fast(g_clk),
        .reset(1'b0),
        .en_audio_d(tvalid_filtered_stream),
        .audio_d(filtered_stream),
        .Stream_enable(tvalid_framing_stream),
        .Stream_out(framing_stream)
    );
    
    // Windowing:
    windowing hamming_window (
        .clk(g_clk),
        .rst(1'b0),
        .tvalid_stream(tvalid_framing_stream),
        .stream(framing_stream),
        .tready_hamm_stream(tready_hamm_stream),
        .hamm_stream(hamm_stream)
    );
    
    // FFT:
    power_spectrum fft_function (
        .clk(g_clk),
        .rst(1'b0),
        .tvalid_hamm_stream(tready_hamm_stream),
        .hamm_stream(hamm_stream),
        .tready_powspectr(tready_powspectr),
        .powspectr(powspectr)
    );
    
    // Total energy in each frame:
    energy energy_in_frame (
        .clk(g_clk),
        .reset(1'b0),
        .tvalid_powspectr(tready_powspectr),
        .powspectr(powspectr),
        .tready_log_energy(tready_log_energy),
        .log_energy(log_energy)
    );
    
    // Get filterbanks:
    filterbanks feat_banks (
        .clk(g_clk),
        .rst(1'b0),
        .powspectr(powspectr),
        .tvalid_powspectr(tready_powspectr),
        .feat_filterbanks(feat_filterbanks),
        .tvalid_feat_filterbanks(tvalid_feat_filterbanks)
    );
    
    // Check on zero for filterbanks:
    always@ (posedge g_clk) begin
        if (tvalid_feat_filterbanks) begin
            tvalid_feat_filterbanks_none_zero <= 1'b1;
            
            if (feat_filterbanks == 32'b0) begin
                feat_filterbanks_none_zero <= 32'h25800000; // If 0 then eps
            end
            else begin
                feat_filterbanks_none_zero <= feat_filterbanks;
            end
        end
        else begin
            tvalid_feat_filterbanks_none_zero   <= 1'b0;
            feat_filterbanks_none_zero          <= 32'h3f800000;
        end  
    end
    
    // Log banks:
    floating_point_log_non_blocking log_filterbanks_feat (
        .s_axis_a_tvalid(tvalid_feat_filterbanks_none_zero),
        .s_axis_a_tdata(feat_filterbanks_none_zero),
        .m_axis_result_tvalid(tvalid_log_filterbanks),
        .m_axis_result_tdata(log_filterbanks)
    );
    
    // DCT 2:
    dct_type2 dct_type2_pre (
        .clk(g_clk),
        .rst(1'b0),
        .tvalid_log_feat_filterbanks(tvalid_log_filterbanks),
        .log_feat_filterbanks(log_filterbanks),
        .tvalid_dct2_sample(tvalid_dct2_sample),
        .dct2_sample(dct2_sample)
    );
    
    // DCT 2 coefficients:
    coef_dct2 dct_type2_post (
        .clk(g_clk),
        .rst(1'b0),
        .tvalid_dct2_sample(tvalid_dct2_sample),
        .dct2_sample(dct2_sample),
        .tvalid_dct2_feat(tvalid_dct2_feat),
        .dct2_feat(dct2_feat)
    );
    
    // Lifter:
    lifter ceplifter (
        .clk(g_clk),
        .rst(1'b0),
        .tvalid_dct2_feat(tvalid_dct2_feat),
        .dct2_feat(dct2_feat),
        .tvalid_mfcc_feat(tvalid_mfcc_feat),
        .mfcc_feat(mfcc_feat)
    );
    
    // Append energy to mfcc vector:
    appendEnergy appendEnergy_to_mfcc (
        .clk(g_clk),
        .rst(1'b0),
        .tvalid_mfcc_feat(tvalid_mfcc_feat),
        .mfcc_feat(mfcc_feat),
        .tvalid_log_energy(tready_log_energy),
        .log_energy(log_energy),
        .tready_mfcc_appened_energy(tready_mfcc_appened_energy),
        .mfcc_appened_energy(mfcc_appened_energy)
    );
    
    // Form SVM for model's inputs:
    delta_feat form_SVM (
        .clk(g_clk),
        .reset(1'b0),
        .tvalid_mfcc_feat(tready_mfcc_appened_energy),
        .mfcc_feat(mfcc_appened_energy),
        .tvalid_SVM(tvalid_SVM),
        .SVM(SVM)
    );
    
    assign tready_mfcc_vector_features  = tvalid_SVM;
    assign mfcc_vector_features         = SVM;
    
endmodule
