`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 13:27:17
// Design Name: 
// Module Name: Vega_submain
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


module Vega_submain(
    input g_fast_clk,
    // I2S audio interface:
    input bclk,
    input wclk,
    input d_audio,
    
    output DNN_Done,
    output DNN_Result
    );
    
    // I2S interface capture:
    wire tvalid_sample16;
    wire [15:0] sample16;
    
    // Convertion Integer16 to Float32:
    wire tvalid_sample32;
    wire [31:0] sample32;
    
    // Features for VAD:
    wire tready_mfcc_vector_features;
    wire [31:0] mfcc_vector_features;
    
    // Dense Neural Net:
    wire dnn_0_ce0;
    wire dnn_0_done;
    wire dnn_0_idle;
    wire dnn_0_ready;
    wire [31:0] dnn_0_return;
    wire [5:0] dnn_0_address0;
    
    reg dnn_output_done;
    reg dnn_output;
    
    // I2S interface capture:
    capture_audio_sample I2S_interface_capture (
        .bclk(bclk),
        .wclk(wclk),
        .d_audio(d_audio),
        .tvalid_sample16(tvalid_sample16),
        .sample16(sample16)
    );
    
    // Convertion Integer16 to Float32:
    floating_point_int16_to_float32 Int16_to_Float32 (
        .s_axis_a_tvalid(tvalid_sample16),
        .s_axis_a_tdata(sample16),
        .m_axis_result_tvalid(tvalid_sample32),
        .m_axis_result_tdata(sample32)
    );
  
    // Features for VAD:
    MFCC get_features (
        .g_clk(g_fast_clk),
        .bclk(bclk),
        .tvalid_float32(tvalid_sample32),
        .float32(sample32),
        .tready_mfcc_vector_features(tready_mfcc_vector_features),
        .mfcc_vector_features(mfcc_vector_features)
    );
    
    /*
    pipeline make_pipeline (
        .clk(g_fast_clk),
        .rst(1'b0),
        .tvalid_mfcc_feat(tready_mfcc_vector_features),
        .mfcc_feat(mfcc_vector_features),
        .tvalid_prediction(tvalid_prediction),
        .prediction(prediction)
    );
    */
    
    // Dense Neural Net:
    DNN_0 DenseNetwork (
        .mfcc_ce0(dnn_0_ce0),
        .ap_clk(g_fast_clk),
        .ap_rst(1'b0),
        .ap_start(tready_mfcc_vector_features),
        .ap_done(dnn_0_done),
        .ap_idle(dnn_0_idle),
        .ap_ready(dnn_0_ready),
        .ap_return(dnn_0_return),
        .mfcc_address0(dnn_0_address0),
        .mfcc_q0(mfcc_vector_features)
    );
    
    // Debuger:
    ila_Vega_subModule LogicAnalyzer (
        .clk(g_fast_clk),
        .probe0(bclk),
        .probe1(wclk),
        .probe2(d_audio),
        .probe3(tvalid_sample16),
        .probe4(sample16)
    );
    
    always@ (posedge g_fast_clk) begin
        if (dnn_0_done) begin
            dnn_output_done <= 1'b1;
            if (dnn_0_return == 32'h3f800000) begin 
                dnn_output <= 1'b1;
            end
            else begin
                dnn_output <= 1'b0;
            end
        end
        else begin
            dnn_output_done <= 1'b0;
        end
    end
    
    assign DNN_Done    = dnn_output_done;
    assign DNN_Result  = dnn_output;
   
endmodule
