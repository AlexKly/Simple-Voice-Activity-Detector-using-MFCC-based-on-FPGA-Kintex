`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2021 09:11:27
// Design Name: 
// Module Name: LinearSVC
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


module LinearSVC(
    input clk,
    input reset,
    
    input tvalid_scaled_feat,
    input [31:0] scaled_feat,
    
    output tvalid_prediction,
    output prediction
    );
    
    localparam [31:0] ZERO_CONST = 32'b0;
    
    reg tvalid_scaled_feat_tmp  = 1'b0;
    reg [31:0] scaled_feat_tmp  = 32'b0;
    
    wire [31:0] weights_SVM [38:0];
    wire [31:0] intercepts_SVM = 32'hbebc331f;
    
    reg tvalid_reg_weights_SVM  = 1'b0;
    reg [31:0] reg_weights_SVM  = 32'b0;
    
    wire tvalid_result_mult;
    wire [31:0] result_mult;
    wire [31:0] result_mult_wc = tvalid_result_mult ? result_mult : 32'b0;
    
    wire tvalid_result_sum;
    wire [31:0] result_sum;
    wire [31:0] delayed_result_sum = tvalid_result_mult ? result_sum : 32'b0;
    
    reg tvalid_result_op_dot = 1'b0;
    reg [31:0] result_op_dot = 32'b0;
    
    wire tvalid_result_SVM;
    wire [31:0] result_SVM;
    
    reg [1:0] en_latch      = 2'b0;
    reg [5:0] ind_weights   = 0;
    
    assign weights_SVM[0] = 32'h3ea541d1;
    assign weights_SVM[1] = 32'h3ecfea77;
    assign weights_SVM[2] = 32'h3eb99ed7;
    assign weights_SVM[3] = 32'h3e5aee33;
    assign weights_SVM[4] = 32'hbeca602a;
    assign weights_SVM[5] = 32'hbe959f4c;
    assign weights_SVM[6] = 32'hbeb3e3d7;
    assign weights_SVM[7] = 32'hbde0c091;
    assign weights_SVM[8] = 32'hbd270863;
    assign weights_SVM[9] = 32'h3de3f01f;
    assign weights_SVM[10] = 32'h3cb7f8cc;
    assign weights_SVM[11] = 32'hbc2340ad;
    assign weights_SVM[12] = 32'hbe579f55;
    assign weights_SVM[13] = 32'h3b2de62f;
    assign weights_SVM[14] = 32'hbbceda5f;
    assign weights_SVM[15] = 32'hbc06c6a2;
    assign weights_SVM[16] = 32'hbb67799b;
    assign weights_SVM[17] = 32'h3b8c63a9;
    assign weights_SVM[18] = 32'h39d84feb;
    assign weights_SVM[19] = 32'h3b5cda94;
    assign weights_SVM[20] = 32'h3af15e05;
    assign weights_SVM[21] = 32'hbbc4cb43;
    assign weights_SVM[22] = 32'hb8f83bde;
    assign weights_SVM[23] = 32'h3bc90cfb;
    assign weights_SVM[24] = 32'hbbb69c23;
    assign weights_SVM[25] = 32'h3b847b25;
    assign weights_SVM[26] = 32'h3dd921d4;
    assign weights_SVM[27] = 32'h3e28fa01;
    assign weights_SVM[28] = 32'h3e0b9701;
    assign weights_SVM[29] = 32'h3dc9249f;
    assign weights_SVM[30] = 32'hbe0d69e8;
    assign weights_SVM[31] = 32'hbe03f85d;
    assign weights_SVM[32] = 32'hbe0fd0bb;
    assign weights_SVM[33] = 32'hbd3f1b68;
    assign weights_SVM[34] = 32'hbcdc6442;
    assign weights_SVM[35] = 32'h3d45dda1;
    assign weights_SVM[36] = 32'h3bd1a1db;
    assign weights_SVM[37] = 32'hbb6f834a;
    assign weights_SVM[38] = 32'hbde28bc3;
    
    always@ (posedge clk) begin
        if (reset) begin
            tvalid_reg_weights_SVM  <= 1'b0;
            reg_weights_SVM         <= 32'b0;
            ind_weights             <= 0;
            en_latch                <= 1'b0;
            tvalid_result_op_dot    <= 1'b0;
            result_op_dot           <= 32'b0;
        end
        else begin
            tvalid_scaled_feat_tmp  <= tvalid_scaled_feat;
            scaled_feat_tmp         <= scaled_feat;
            
            if (tvalid_scaled_feat) begin
                tvalid_reg_weights_SVM  <= 1'b1;
                reg_weights_SVM         <= weights_SVM[ind_weights];
                ind_weights             <= ind_weights + 1;
            end
            else begin
                tvalid_reg_weights_SVM  <= 1'b0;
                reg_weights_SVM         <= 32'b0;
                ind_weights             <= 0;
            end   
            
            if (ind_weights == 39) begin
                en_latch[0] <= 1'b1;
            end
            else begin
                en_latch[0] <= 1'b0;
            end
            
            en_latch[1] <= en_latch[0];
            
            if (en_latch[1]) begin
                tvalid_result_op_dot    <= 1'b1;
                result_op_dot           <= result_sum;
            end
            else begin
                tvalid_result_op_dot    <= 1'b0;
                result_op_dot           <= 32'b0;
            end
        end
    end
    
    floating_point_mult mult (
        .aclk(clk),
        .s_axis_a_tvalid(tvalid_scaled_feat_tmp),
        .s_axis_a_tready(),
        .s_axis_a_tdata(scaled_feat_tmp),
        .s_axis_b_tvalid(tvalid_reg_weights_SVM),
        .s_axis_b_tready(),
        .s_axis_b_tdata(reg_weights_SVM),
        .m_axis_result_tvalid(tvalid_result_mult),
        .m_axis_result_tdata(result_mult)
    );
    
    floating_point_add add_1 (
        .aclk(clk),
        .s_axis_a_tvalid(1'b1),
        .s_axis_a_tready(),
        .s_axis_a_tdata(result_mult_wc),
        .s_axis_b_tvalid(1'b1),
        .s_axis_b_tready(),
        .s_axis_b_tdata(delayed_result_sum),
        .m_axis_result_tvalid(tvalid_result_sum),
        .m_axis_result_tdata(result_sum)
    );
    
    floating_point_add add_2 (
        .aclk(clk),
        .s_axis_a_tvalid(tvalid_result_op_dot),
        .s_axis_a_tready(),
        .s_axis_a_tdata(result_op_dot),
        .s_axis_b_tvalid(tvalid_result_op_dot),
        .s_axis_b_tready(),
        .s_axis_b_tdata(intercepts_SVM),
        .m_axis_result_tvalid(tvalid_result_SVM),
        .m_axis_result_tdata(result_SVM)
    );
    
    floating_point_comp comp (
        .aclk(clk),
        .s_axis_a_tvalid(tvalid_result_SVM),
        .s_axis_a_tready(),
        .s_axis_a_tdata(result_SVM),
        .s_axis_b_tvalid(tvalid_result_SVM),
        .s_axis_b_tready(),
        .s_axis_b_tdata(ZERO_CONST),
        .m_axis_result_tvalid(tvalid_prediction),
        .m_axis_result_tdata(prediction)
    );     
    
endmodule
