`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.06.2021 14:32:02
// Design Name: 
// Module Name: StandardScaler
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


module StandardScaler(
    input clk,
    input reset,
    
    input tvalid_mfcc_feat,
    input [31:0] mfcc_feat,
    
    output tvalid_transformed_sample,
    output [31:0] transformed_sample
    );
    
    reg tvalid_mfcc_feat_tmp = 1'b0;
    reg [31:0] mfcc_feat_tmp = 32'b0;
    
    reg tvalid_reg_mean_values  = 1'b0;
    reg [31:0] reg_mean_values  = 32'b0;
    reg tvalid_reg_std_values   = 1'b0;
    reg [31:0] reg_std_values   = 32'b0;
    wire [31:0] mean_values [38:0];
    wire [31:0] std_values [38:0];
    
    reg [5:0] ind_mean  = 0;
    reg [5:0] ind_std   = 0;
    
    wire tvalid_result_sub;
    wire [31:0] result_sub;
    
    assign mean_values[0] = 32'h416c58ab;
    assign mean_values[1] = 32'hc094df03;
    assign mean_values[2] = 32'hc0eace7a;
    assign mean_values[3] = 32'h4054ec17;
    assign mean_values[4] = 32'h4050f707;
    assign mean_values[5] = 32'h400f8052;
    assign mean_values[6] = 32'hbfd1b598;
    assign mean_values[7] = 32'hc006d73e;
    assign mean_values[8] = 32'hc034af40;
    assign mean_values[9] = 32'hbfd9de02;
    assign mean_values[10] = 32'hc066a00e;
    assign mean_values[11] = 32'hbe420382;
    assign mean_values[12] = 32'hc083f2aa;
    assign mean_values[13] = 32'hbb669a44;
    assign mean_values[14] = 32'h3aaf6b75;
    assign mean_values[15] = 32'h3a804401;
    assign mean_values[16] = 32'hbae86dc3;
    assign mean_values[17] = 32'h3c2e3dea;
    assign mean_values[18] = 32'h3c211fba;
    assign mean_values[19] = 32'h3c944801;
    assign mean_values[20] = 32'h3cb102d9;
    assign mean_values[21] = 32'h3c76a539;
    assign mean_values[22] = 32'hbc06fc17;
    assign mean_values[23] = 32'hbc46e230;
    assign mean_values[24] = 32'h3b097d66;
    assign mean_values[25] = 32'h3c9919fd;
    assign mean_values[26] = 32'hba825556;
    assign mean_values[27] = 32'h3a793160;
    assign mean_values[28] = 32'h3b02b271;
    assign mean_values[29] = 32'hbb0187e8;
    assign mean_values[30] = 32'h3a8c9622;
    assign mean_values[31] = 32'h39bb6e8e;
    assign mean_values[32] = 32'hbb0b2889;
    assign mean_values[33] = 32'h3afc847a;
    assign mean_values[34] = 32'hbb22fb96;
    assign mean_values[35] = 32'h3b8b9f98;
    assign mean_values[36] = 32'hbae77150;
    assign mean_values[37] = 32'hbb98c1a1;
    assign mean_values[38] = 32'hbb8a333f;
    
    assign std_values[0] = 32'h404ce50b;
    assign std_values[1] = 32'h4161c0c3;
    assign std_values[2] = 32'h414518e5;
    assign std_values[3] = 32'h414c4eaa;
    assign std_values[4] = 32'h4188a75b;
    assign std_values[5] = 32'h4174f0c4;
    assign std_values[6] = 32'h4181cc56;
    assign std_values[7] = 32'h416cf07f;
    assign std_values[8] = 32'h415976ab;
    assign std_values[9] = 32'h41541e0e;
    assign std_values[10] = 32'h4143eb78;
    assign std_values[11] = 32'h4138dab6;
    assign std_values[12] = 32'h4139e430;
    assign std_values[13] = 32'h3ebe6d8c;
    assign std_values[14] = 32'h4003009c;
    assign std_values[15] = 32'h400bedb8;
    assign std_values[16] = 32'h400f0519;
    assign std_values[17] = 32'h40299f41;
    assign std_values[18] = 32'h403973f9;
    assign std_values[19] = 32'h403c23d6;
    assign std_values[20] = 32'h403942dd;
    assign std_values[21] = 32'h403e9892;
    assign std_values[22] = 32'h403be091;
    assign std_values[23] = 32'h40359070;
    assign std_values[24] = 32'h4031f0bc;
    assign std_values[25] = 32'h40299cd5;
    assign std_values[26] = 32'h3e19305f;
    assign std_values[27] = 32'h3f4e1238;
    assign std_values[28] = 32'h3f6752fd;
    assign std_values[29] = 32'h3f6be59f;
    assign std_values[30] = 32'h3f8c898e;
    assign std_values[31] = 32'h3f9c5a99;
    assign std_values[32] = 32'h3fa1edfc;
    assign std_values[33] = 32'h3fa11388;
    assign std_values[34] = 32'h3fa61b46;
    assign std_values[35] = 32'h3fa4bd05;
    assign std_values[36] = 32'h3f9f6343;
    assign std_values[37] = 32'h3f9ce47b;
    assign std_values[38] = 32'h3f95ce17;
    
    always@ (posedge clk) begin
        if (reset) begin
            tvalid_reg_mean_values  <= 1'b0;
            tvalid_reg_std_values   <= 1'b0;
            reg_mean_values         <= 32'b0;
            reg_std_values          <= 32'b0;
            ind_mean                <= 0;
            ind_std                 <= 0;
        end
        else begin
            mfcc_feat_tmp           <= mfcc_feat;
            tvalid_mfcc_feat_tmp    <= tvalid_mfcc_feat;
        
            if (tvalid_mfcc_feat) begin
                tvalid_reg_mean_values  <= 1'b1;
                reg_mean_values         <= mean_values[ind_mean];
                ind_mean                <= ind_mean + 1;
            end
            else begin
                tvalid_reg_mean_values  <= 1'b0;
                reg_mean_values         <= 32'b0;
                ind_mean                <= 0;
            end
        
            if (tvalid_reg_mean_values) begin
                tvalid_reg_std_values   <= 1'b1;
                reg_std_values          <= std_values[ind_std];
                ind_std                 <= ind_std + 1;
            end
            else begin
                tvalid_reg_std_values   <= 1'b0;
                reg_std_values          <= 32'b0;
                ind_std                 <= 0;
            end
        end
    end
    
    floating_point_sub sub (
        .aclk(clk),
        .s_axis_a_tvalid(tvalid_mfcc_feat_tmp),
        .s_axis_a_tready(),
        .s_axis_a_tdata(mfcc_feat_tmp),
        .s_axis_b_tvalid(tvalid_reg_mean_values),
        .s_axis_b_tready(),
        .s_axis_b_tdata(reg_mean_values),
        .m_axis_result_tvalid(tvalid_result_sub),
        .m_axis_result_tdata(result_sub)
      );
      
    floating_point_div div (
        .aclk(clk),
        .s_axis_a_tvalid(tvalid_result_sub),
        .s_axis_a_tready(),
        .s_axis_a_tdata(result_sub),
        .s_axis_b_tvalid(tvalid_reg_std_values),
        .s_axis_b_tready(),
        .s_axis_b_tdata(reg_std_values),
        .m_axis_result_tvalid(tvalid_transformed_sample),
        .m_axis_result_tdata(transformed_sample)
    );    
    
endmodule
