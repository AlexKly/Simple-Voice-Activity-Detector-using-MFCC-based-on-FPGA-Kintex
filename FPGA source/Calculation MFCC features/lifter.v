`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2020 13:12:10
// Design Name: 
// Module Name: lifter
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


module lifter(
    input clk,
    input rst,
    
    input tvalid_dct2_feat,
    input [31:0] dct2_feat,
    
    output reg tvalid_mfcc_feat,
    output reg [31:0] mfcc_feat
    );
    
    reg tvalid_dct2_feat_temp;
    reg [31:0] dct2_feat_temp;
    
    wire [31:0] lift [0:12];
    reg tvalid_reg_lift;
    reg [31:0] reg_lift;
    
    wire tvalid_mfcc_feat_temp;
    wire [31:0] mfcc_feat_temp;
    
    reg [3:0] ind = 0;
    
    assign lift[0] = 32'h3f800000;
    assign lift[1] = 32'h4024308d;
    assign lift[2] = 32'h40832b7c;
    assign lift[3] = 32'h40b239e1;
    assign lift[4] = 32'h40de4e3a;
    assign lift[5] = 32'h41034168;
    assign lift[6] = 32'h4115030e;
    assign lift[7] = 32'h41240f85;
    assign lift[8] = 32'h41301861;
    assign lift[9] = 32'h4138deea;
    assign lift[10] = 32'h413e3565;
    assign lift[11] = 32'h41400000;
    assign lift[12] = 32'h413e3565;
    
    floating_point_mult_non_blocking m1_lift_cepstra (
        .s_axis_a_tvalid(tvalid_dct2_feat_temp),
        .s_axis_a_tdata(dct2_feat_temp),
        .s_axis_b_tvalid(tvalid_reg_lift),
        .s_axis_b_tdata(reg_lift),
        .m_axis_result_tvalid(tvalid_mfcc_feat_temp),
        .m_axis_result_tdata(mfcc_feat_temp)
    );
    
    always@(posedge clk) begin
        
        tvalid_dct2_feat_temp <= tvalid_dct2_feat;
        tvalid_mfcc_feat <= tvalid_mfcc_feat_temp;
        mfcc_feat <= mfcc_feat_temp;
        
        if (tvalid_dct2_feat) begin
            dct2_feat_temp <= dct2_feat;
            reg_lift <= lift[ind];
            tvalid_reg_lift <= 1'b1;
            
            ind <= ind + 1;
        end
        else begin
            dct2_feat_temp <= 32'h00000000;
            tvalid_reg_lift <= 1'b0;
            
            ind <= 0;
        end
        
    end
    
endmodule
