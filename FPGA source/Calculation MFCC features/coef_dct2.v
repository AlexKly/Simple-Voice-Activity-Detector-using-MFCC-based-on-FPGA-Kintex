`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2020 11:24:22
// Design Name: 
// Module Name: coef_dct2
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


module coef_dct2(
    input clk,
    input rst,
    
    input tvalid_dct2_sample,
    input [31:0] dct2_sample,
    
    output reg tvalid_dct2_feat,
    output reg [31:0] dct2_feat
    );
    
    reg tvalid_dct2_sample_temp;
    reg [31:0] dct2_sample_temp;
    
    wire [31:0] coef_dct2 [0:12];
    reg tvalid_reg_dct2_coef;
    reg [31:0] reg_dct2_coef;
    
    wire tvalid_dct2_feat_temp;
    wire [31:0] dct2_feat_temp;
    
    reg [3:0] ind = 0;
    
    assign coef_dct2[0] = 32'h3e48d2ab;
    assign coef_dct2[1] = 32'h3e8e00d5;
    assign coef_dct2[2] = 32'h3e8e00d5;
    assign coef_dct2[3] = 32'h3e8e00d5;
    assign coef_dct2[4] = 32'h3e8e00d5;
    assign coef_dct2[5] = 32'h3e8e00d5;
    assign coef_dct2[6] = 32'h3e8e00d5;
    assign coef_dct2[7] = 32'h3e8e00d5;
    assign coef_dct2[8] = 32'h3e8e00d5;
    assign coef_dct2[9] = 32'h3e8e00d5;
    assign coef_dct2[10] = 32'h3e8e00d5;
    assign coef_dct2[11] = 32'h3e8e00d5;
    assign coef_dct2[12] = 32'h3e8e00d5;
    
    floating_point_mult_non_blocking get_dct2_feat (
        .s_axis_a_tvalid(tvalid_dct2_sample_temp),
        .s_axis_a_tdata(dct2_sample_temp),
        .s_axis_b_tvalid(tvalid_reg_dct2_coef),
        .s_axis_b_tdata(reg_dct2_coef),
        .m_axis_result_tvalid(tvalid_dct2_feat_temp),
        .m_axis_result_tdata(dct2_feat_temp)
    );
    
    always@(posedge clk) begin
        
        tvalid_dct2_sample_temp <= tvalid_dct2_sample;
        tvalid_dct2_feat <= tvalid_dct2_feat_temp;
        dct2_feat <= dct2_feat_temp;
        
        if (tvalid_dct2_sample) begin
            dct2_sample_temp <= dct2_sample;
            reg_dct2_coef <= coef_dct2[ind];
            tvalid_reg_dct2_coef <= 1'b1;
            
            ind <= ind + 1;
        end
        else begin
            dct2_sample_temp <= 32'h00000000;
            tvalid_reg_dct2_coef <= 1'b0;
            
            ind <= 0;
        end
        
    end
    
endmodule
