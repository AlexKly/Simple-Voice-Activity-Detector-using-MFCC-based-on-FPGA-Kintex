`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2021 12:43:08
// Design Name: 
// Module Name: power_spectrum
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


module power_spectrum(
    input clk,
    input rst,
    input tvalid_hamm_stream,
    input [31:0] hamm_stream,

    output tready_powspectr,
    output [31:0] powspectr
    );
    
    reg [31:0] re_part;
    reg [31:0] im_part;
    reg tvalid_re_part = 1'b0;
    reg tvalid_im_part = 1'b0;
    
    wire [31:0] pow_re_part;
    wire [31:0] pow_im_part;
    wire tready_re_pow;
    wire tready_im_pow;
    
    wire [31:0] sum_pow;
    wire tready_sum_pow;
    
    wire [31:0] mag_spec;
    wire tready_mag_spec;
    
    wire [31:0] pow_mag_spec;
    wire tready_pow_mag_spec;
    
    wire tready_powspectr_out;
    wire [31:0] powspectr_out;
    
    // Counter 257 FFT samples:
    reg tready_powspectr_tmp    = 1'b0;
    reg [31:0] powspectr_tmp    = 32'h00000000;
    reg [8:0] cnt_NFFT257       = 0;
        
    // Config slave channel signals:
    wire [15:0] s_axis_config_tdata = 16'b0000000000000001;
    reg s_axis_config_tvalid = 1'b1;
    wire s_axis_config_tready;
    
    // Data slave channel signals:
    reg [63:0] s_axis_data_tdata;
    reg s_axis_data_tvalid;
    wire s_axis_data_tready;
    wire s_axis_data_tlast;
    
    // Data master channel signals:
    wire [63:0] m_axis_data_tdata;
    wire m_axis_data_tvalid;
    wire m_axis_data_tlast;
    
    // Event signals:
    wire event_frame_started;
    wire event_tlast_unexpected;
    wire event_tlast_missing;
    wire event_data_in_channel_halt;
    
    fft_block magnitude_spectrum (
        .aclk(clk),
        .s_axis_config_tdata(s_axis_config_tdata),
        .s_axis_config_tvalid(s_axis_config_tvalid),
        .s_axis_config_tready(s_axis_config_tready),
        .s_axis_data_tdata(s_axis_data_tdata),
        .s_axis_data_tvalid(s_axis_data_tvalid),
        .s_axis_data_tready(s_axis_data_tready),
        .s_axis_data_tlast(s_axis_data_tlast),
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_data_tlast(m_axis_data_tlast),
        .event_frame_started(event_frame_started),
        .event_tlast_unexpected(event_tlast_unexpected),
        .event_tlast_missing(event_tlast_missing),
        .event_data_in_channel_halt(event_data_in_channel_halt)
    );
    
    floating_point_mult power_im_part (
        .aclk(clk),
        .s_axis_a_tvalid(tvalid_im_part),
        .s_axis_a_tready(),
        .s_axis_a_tdata(im_part),
        .s_axis_b_tvalid(tvalid_im_part),
        .s_axis_b_tready(),
        .s_axis_b_tdata(im_part),
        .m_axis_result_tvalid(tready_im_pow),
        .m_axis_result_tdata(pow_im_part)
    );
   
    floating_point_mult power_re_part (
        .aclk(clk),
        .s_axis_a_tvalid(tvalid_re_part),
        .s_axis_a_tready(),
        .s_axis_a_tdata(re_part),
        .s_axis_b_tvalid(tvalid_re_part),
        .s_axis_b_tready(),
        .s_axis_b_tdata(re_part),
        .m_axis_result_tvalid(tready_re_pow),
        .m_axis_result_tdata(pow_re_part)
    );
    
    floating_point_add pow_adder (
        .aclk(clk),
        .s_axis_a_tvalid(tready_im_pow),
        .s_axis_a_tready(),
        .s_axis_a_tdata(pow_im_part),
        .s_axis_b_tvalid(tready_re_pow),
        .s_axis_b_tready(),
        .s_axis_b_tdata(pow_re_part),
        .m_axis_result_tvalid(tready_sum_pow),
        .m_axis_result_tdata(sum_pow)
    );
    
    floating_point_square_root out_mag_spec (
        .aclk(clk),
        .s_axis_a_tvalid(tready_sum_pow),
        .s_axis_a_tready(),
        .s_axis_a_tdata(sum_pow),
        .m_axis_result_tvalid(tready_mag_spec),
        .m_axis_result_tdata(mag_spec)
    );
    
    floating_point_mult m_pow_mag_spec (
        .aclk(clk),
        .s_axis_a_tvalid(tready_mag_spec),
        .s_axis_a_tready(),
        .s_axis_a_tdata(mag_spec),
        .s_axis_b_tvalid(tready_mag_spec),
        .s_axis_b_tready(),
        .s_axis_b_tdata(mag_spec),
        .m_axis_result_tvalid(tready_pow_mag_spec),
        .m_axis_result_tdata(pow_mag_spec)
    );
    
    floating_point_div out_pow_spec (
        .aclk(clk),
        .s_axis_a_tvalid(tready_pow_mag_spec),
        .s_axis_a_tready(),
        .s_axis_a_tdata(pow_mag_spec),
        .s_axis_b_tvalid(tready_pow_mag_spec),
        .s_axis_b_tready(),
        .s_axis_b_tdata(32'h44000000),  // NFFT = 512
        .m_axis_result_tvalid(tready_powspectr_out),
        .m_axis_result_tdata(powspectr_out)
    );
    
    // Сейчас модуль power_spectrum выдает 512 отсчетов
    // Необходимо поставить счетчик по разрешению tready_powspectr
    // И отсчитывать первые 257 отсчетов (0:256)
    // И по этим 257 отсчетов выставлять новый флаг tready_powspectr_257
    // В целом FFT работает достаточно точно, но надо еще проверить
    
    always@(posedge clk) begin
        s_axis_data_tvalid <= tvalid_hamm_stream;
        s_axis_data_tdata <= 32'h00000000;
        s_axis_data_tdata[31:0] <= hamm_stream;         
        
        
        im_part         <= m_axis_data_tdata[63:32];
        re_part         <= m_axis_data_tdata[31:0];
        tvalid_re_part  <= m_axis_data_tvalid;
        tvalid_im_part  <= m_axis_data_tvalid;
        
        if (tready_powspectr_out) begin
            if (cnt_NFFT257 < 257) begin
                cnt_NFFT257 <= cnt_NFFT257 + 1;
                
                tready_powspectr_tmp    <= 1'b1;
                powspectr_tmp           <= powspectr_out;
            end
            else begin
                tready_powspectr_tmp    <= 1'b0;
                powspectr_tmp           <= 32'b0;
            end
        end
        else begin
            cnt_NFFT257 <= 0;
            
            tready_powspectr_tmp    <= 1'b0;
            powspectr_tmp           <= 32'h00000000;
        end
    end
    
    assign tready_powspectr = tready_powspectr_tmp;
    assign powspectr        = powspectr_tmp;
    
endmodule
