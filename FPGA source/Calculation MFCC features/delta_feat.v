`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2021 16:04:28
// Design Name: 
// Module Name: delta_feat
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


module delta_feat(
	input clk,
    input reset,

    input tvalid_mfcc_feat,
    input [31:0] mfcc_feat,

    output tvalid_SVM,
    output [31:0] SVM
    );
    
	localparam [31:0] SAMPLE_INIT = 32'b0;
    
    wire tvalid_d1_mfcc_feat;
    wire [31:0] d1_mfcc_feat;
    
    wire tvalid_d2_mfcc_feat;
    wire [31:0] d2_mfcc_feat;
    
    reg past_front_tvalid_mfcc_feat;
    wire rising_edge_tvalid_mfcc_feat   = !past_front_tvalid_mfcc_feat && tvalid_mfcc_feat;
    wire falling_edge_tvalid_mfcc_feat  = past_front_tvalid_mfcc_feat && !tvalid_mfcc_feat;
    
    reg past_front_tvalid_d1_mfcc_feat;
    wire rising_edge_tvalid_d1_mfcc_feat    = !past_front_tvalid_d1_mfcc_feat && tvalid_d1_mfcc_feat;
    wire falling_edge_tvalid_d1_mfcc_feat   = past_front_tvalid_d1_mfcc_feat && !tvalid_d1_mfcc_feat;
    
    reg past_front_tvalid_d2_mfcc_feat;
    wire falling_edge_tvalid_d2_mfcc_feat = past_front_tvalid_d2_mfcc_feat && !tvalid_d2_mfcc_feat;
    
    reg [31:0] reg_mfcc_feat [4:0][12:0];
    reg [31:0] reg_d1_mfcc_feat [2:0][12:0];
    reg [31:0] reg_SVM [38:0];
    
    reg [2:0] initial_pause     = 0;
    reg [5:0] cnt_SVM_samples   = 0;
    
    reg first_system_reset  = 1'b1;
    reg start_transmit_SVM  = 1'b0;
    
    reg tvalid_SVM_tmp = 1'b0;
    reg [31:0] reg_SVM_tmp;
    
    always@ (posedge clk) begin
        past_front_tvalid_mfcc_feat     <= tvalid_mfcc_feat;
        past_front_tvalid_d1_mfcc_feat  <= tvalid_d1_mfcc_feat;
        past_front_tvalid_d2_mfcc_feat  <= tvalid_d2_mfcc_feat;
        
        reg_SVM_tmp <= reg_SVM[38];
    
        if (reset || first_system_reset) begin
            reg_mfcc_feat[0][0]     <= SAMPLE_INIT;
            reg_mfcc_feat[0][1]     <= SAMPLE_INIT;
            reg_mfcc_feat[0][2]     <= SAMPLE_INIT;
            reg_mfcc_feat[0][3]     <= SAMPLE_INIT;
            reg_mfcc_feat[0][4]     <= SAMPLE_INIT;
            reg_mfcc_feat[0][5]     <= SAMPLE_INIT;
            reg_mfcc_feat[0][6]     <= SAMPLE_INIT;
            reg_mfcc_feat[0][7]     <= SAMPLE_INIT;
            reg_mfcc_feat[0][8]     <= SAMPLE_INIT;
            reg_mfcc_feat[0][9]     <= SAMPLE_INIT;
            reg_mfcc_feat[0][10]    <= SAMPLE_INIT;
            reg_mfcc_feat[0][11]    <= SAMPLE_INIT;
            reg_mfcc_feat[0][12]    <= SAMPLE_INIT;
        
            reg_mfcc_feat[1][0]     <= SAMPLE_INIT;
            reg_mfcc_feat[1][1]     <= SAMPLE_INIT;
            reg_mfcc_feat[1][2]     <= SAMPLE_INIT;
            reg_mfcc_feat[1][3]     <= SAMPLE_INIT;
            reg_mfcc_feat[1][4]     <= SAMPLE_INIT;
            reg_mfcc_feat[1][5]     <= SAMPLE_INIT;
            reg_mfcc_feat[1][6]     <= SAMPLE_INIT;
            reg_mfcc_feat[1][7]     <= SAMPLE_INIT;
            reg_mfcc_feat[1][8]     <= SAMPLE_INIT;
            reg_mfcc_feat[1][9]     <= SAMPLE_INIT;
            reg_mfcc_feat[1][10]    <= SAMPLE_INIT;
            reg_mfcc_feat[1][11]    <= SAMPLE_INIT;
            reg_mfcc_feat[1][12]    <= SAMPLE_INIT;
            
            reg_mfcc_feat[2][0]     <= SAMPLE_INIT;
            reg_mfcc_feat[2][1]     <= SAMPLE_INIT;
            reg_mfcc_feat[2][2]     <= SAMPLE_INIT;
            reg_mfcc_feat[2][3]     <= SAMPLE_INIT;
            reg_mfcc_feat[2][4]     <= SAMPLE_INIT;
            reg_mfcc_feat[2][5]     <= SAMPLE_INIT;
            reg_mfcc_feat[2][6]     <= SAMPLE_INIT;
            reg_mfcc_feat[2][7]     <= SAMPLE_INIT;
            reg_mfcc_feat[2][8]     <= SAMPLE_INIT;
            reg_mfcc_feat[2][9]     <= SAMPLE_INIT;
            reg_mfcc_feat[2][10]    <= SAMPLE_INIT;
            reg_mfcc_feat[2][11]    <= SAMPLE_INIT;
            reg_mfcc_feat[2][12]    <= SAMPLE_INIT;
            
            reg_mfcc_feat[3][0]     <= SAMPLE_INIT;
            reg_mfcc_feat[3][1]     <= SAMPLE_INIT;
            reg_mfcc_feat[3][2]     <= SAMPLE_INIT;
            reg_mfcc_feat[3][3]     <= SAMPLE_INIT;
            reg_mfcc_feat[3][4]     <= SAMPLE_INIT;
            reg_mfcc_feat[3][5]     <= SAMPLE_INIT;
            reg_mfcc_feat[3][6]     <= SAMPLE_INIT;
            reg_mfcc_feat[3][7]     <= SAMPLE_INIT;
            reg_mfcc_feat[3][8]     <= SAMPLE_INIT;
            reg_mfcc_feat[3][9]     <= SAMPLE_INIT;
            reg_mfcc_feat[3][10]    <= SAMPLE_INIT;
            reg_mfcc_feat[3][11]    <= SAMPLE_INIT;
            reg_mfcc_feat[3][12]    <= SAMPLE_INIT;
            
            reg_mfcc_feat[4][0]     <= SAMPLE_INIT;
            reg_mfcc_feat[4][1]     <= SAMPLE_INIT;
            reg_mfcc_feat[4][2]     <= SAMPLE_INIT;
            reg_mfcc_feat[4][3]     <= SAMPLE_INIT;
            reg_mfcc_feat[4][4]     <= SAMPLE_INIT;
            reg_mfcc_feat[4][5]     <= SAMPLE_INIT;
            reg_mfcc_feat[4][6]     <= SAMPLE_INIT;
            reg_mfcc_feat[4][7]     <= SAMPLE_INIT;
            reg_mfcc_feat[4][8]     <= SAMPLE_INIT;
            reg_mfcc_feat[4][9]     <= SAMPLE_INIT;
            reg_mfcc_feat[4][10]    <= SAMPLE_INIT;
            reg_mfcc_feat[4][11]    <= SAMPLE_INIT;
            reg_mfcc_feat[4][12]    <= SAMPLE_INIT;
            
            reg_d1_mfcc_feat[0][0]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][1]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][2]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][3]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][4]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][5]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][6]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][7]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][8]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][9]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][10] <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][11] <= SAMPLE_INIT;
            reg_d1_mfcc_feat[0][12] <= SAMPLE_INIT;
            
            reg_d1_mfcc_feat[1][0]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][1]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][2]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][3]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][4]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][5]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][6]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][7]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][8]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][9]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][10] <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][11] <= SAMPLE_INIT;
            reg_d1_mfcc_feat[1][12] <= SAMPLE_INIT;
            
            reg_d1_mfcc_feat[2][0]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][1]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][2]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][3]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][4]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][5]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][6]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][7]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][8]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][9]  <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][10] <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][11] <= SAMPLE_INIT;
            reg_d1_mfcc_feat[2][12] <= SAMPLE_INIT;
            
            reg_SVM[38] <= SAMPLE_INIT;
            reg_SVM[37] <= SAMPLE_INIT;
            reg_SVM[36] <= SAMPLE_INIT;
            reg_SVM[35] <= SAMPLE_INIT;
            reg_SVM[34] <= SAMPLE_INIT;
            reg_SVM[33] <= SAMPLE_INIT;
            reg_SVM[32] <= SAMPLE_INIT;
            reg_SVM[31] <= SAMPLE_INIT;
            reg_SVM[30] <= SAMPLE_INIT;
            reg_SVM[29] <= SAMPLE_INIT;
            reg_SVM[28] <= SAMPLE_INIT;
            reg_SVM[27] <= SAMPLE_INIT;
            reg_SVM[26] <= SAMPLE_INIT;
            reg_SVM[25] <= SAMPLE_INIT;
            reg_SVM[24] <= SAMPLE_INIT;
            reg_SVM[23] <= SAMPLE_INIT;
            reg_SVM[22] <= SAMPLE_INIT;
            reg_SVM[21] <= SAMPLE_INIT;
            reg_SVM[20] <= SAMPLE_INIT;
            reg_SVM[19] <= SAMPLE_INIT;
            reg_SVM[18] <= SAMPLE_INIT;
            reg_SVM[17] <= SAMPLE_INIT;
            reg_SVM[16] <= SAMPLE_INIT;
            reg_SVM[15] <= SAMPLE_INIT;
            reg_SVM[14] <= SAMPLE_INIT;
            reg_SVM[13] <= SAMPLE_INIT;
            reg_SVM[12] <= SAMPLE_INIT;
            reg_SVM[11] <= SAMPLE_INIT;
            reg_SVM[10] <= SAMPLE_INIT;
            reg_SVM[9]  <= SAMPLE_INIT;
            reg_SVM[8]  <= SAMPLE_INIT;
            reg_SVM[7]  <= SAMPLE_INIT;
            reg_SVM[6]  <= SAMPLE_INIT;
            reg_SVM[5]  <= SAMPLE_INIT;
            reg_SVM[4]  <= SAMPLE_INIT;
            reg_SVM[3]  <= SAMPLE_INIT;
            reg_SVM[2]  <= SAMPLE_INIT;
            reg_SVM[1]  <= SAMPLE_INIT;
            reg_SVM[0]  <= SAMPLE_INIT;
            
            initial_pause       <= 0;
            first_system_reset  <= 1'b0;
        end
        else begin
            if (tvalid_mfcc_feat) begin
                reg_mfcc_feat[0][0]     <= mfcc_feat;
                reg_mfcc_feat[0][1]     <= reg_mfcc_feat[0][0];
                reg_mfcc_feat[0][2]     <= reg_mfcc_feat[0][1];
                reg_mfcc_feat[0][3]     <= reg_mfcc_feat[0][2];
                reg_mfcc_feat[0][4]     <= reg_mfcc_feat[0][3];
                reg_mfcc_feat[0][5]     <= reg_mfcc_feat[0][4];
                reg_mfcc_feat[0][6]     <= reg_mfcc_feat[0][5];
                reg_mfcc_feat[0][7]     <= reg_mfcc_feat[0][6];
                reg_mfcc_feat[0][8]     <= reg_mfcc_feat[0][7];
                reg_mfcc_feat[0][9]     <= reg_mfcc_feat[0][8];
                reg_mfcc_feat[0][10]    <= reg_mfcc_feat[0][9];
                reg_mfcc_feat[0][11]    <= reg_mfcc_feat[0][10];
                reg_mfcc_feat[0][12]    <= reg_mfcc_feat[0][11];
            end
            
            if (tvalid_d1_mfcc_feat) begin
                reg_d1_mfcc_feat[0][0]  <= d1_mfcc_feat;
                reg_d1_mfcc_feat[0][1]  <= reg_d1_mfcc_feat[0][0];
                reg_d1_mfcc_feat[0][2]  <= reg_d1_mfcc_feat[0][1];
                reg_d1_mfcc_feat[0][3]  <= reg_d1_mfcc_feat[0][2];
                reg_d1_mfcc_feat[0][4]  <= reg_d1_mfcc_feat[0][3];
                reg_d1_mfcc_feat[0][5]  <= reg_d1_mfcc_feat[0][4];
                reg_d1_mfcc_feat[0][6]  <= reg_d1_mfcc_feat[0][5];
                reg_d1_mfcc_feat[0][7]  <= reg_d1_mfcc_feat[0][6];
                reg_d1_mfcc_feat[0][8]  <= reg_d1_mfcc_feat[0][7];
                reg_d1_mfcc_feat[0][9]  <= reg_d1_mfcc_feat[0][8];
                reg_d1_mfcc_feat[0][10] <= reg_d1_mfcc_feat[0][9];
                reg_d1_mfcc_feat[0][11] <= reg_d1_mfcc_feat[0][10];
                reg_d1_mfcc_feat[0][12] <= reg_d1_mfcc_feat[0][11];
            end
            
            if (rising_edge_tvalid_mfcc_feat) begin
                reg_mfcc_feat[1][0]     <= reg_mfcc_feat[0][0];
                reg_mfcc_feat[1][1]     <= reg_mfcc_feat[0][1];
                reg_mfcc_feat[1][2]     <= reg_mfcc_feat[0][2];
                reg_mfcc_feat[1][3]     <= reg_mfcc_feat[0][3];
                reg_mfcc_feat[1][4]     <= reg_mfcc_feat[0][4];
                reg_mfcc_feat[1][5]     <= reg_mfcc_feat[0][5];
                reg_mfcc_feat[1][6]     <= reg_mfcc_feat[0][6];
                reg_mfcc_feat[1][7]     <= reg_mfcc_feat[0][7];
                reg_mfcc_feat[1][8]     <= reg_mfcc_feat[0][8];
                reg_mfcc_feat[1][9]     <= reg_mfcc_feat[0][9];
                reg_mfcc_feat[1][10]    <= reg_mfcc_feat[0][10];
                reg_mfcc_feat[1][11]    <= reg_mfcc_feat[0][11];
                reg_mfcc_feat[1][12]    <= reg_mfcc_feat[0][12];
                
                reg_mfcc_feat[2][0]     <= reg_mfcc_feat[1][0];
                reg_mfcc_feat[2][1]     <= reg_mfcc_feat[1][1];
                reg_mfcc_feat[2][2]     <= reg_mfcc_feat[1][2];
                reg_mfcc_feat[2][3]     <= reg_mfcc_feat[1][3];
                reg_mfcc_feat[2][4]     <= reg_mfcc_feat[1][4];
                reg_mfcc_feat[2][5]     <= reg_mfcc_feat[1][5];
                reg_mfcc_feat[2][6]     <= reg_mfcc_feat[1][6];
                reg_mfcc_feat[2][7]     <= reg_mfcc_feat[1][7];
                reg_mfcc_feat[2][8]     <= reg_mfcc_feat[1][8];
                reg_mfcc_feat[2][9]     <= reg_mfcc_feat[1][9];
                reg_mfcc_feat[2][10]    <= reg_mfcc_feat[1][10];
                reg_mfcc_feat[2][11]    <= reg_mfcc_feat[1][11];
                reg_mfcc_feat[2][12]    <= reg_mfcc_feat[1][12];
                
                reg_mfcc_feat[3][0]     <= reg_mfcc_feat[2][0];
                reg_mfcc_feat[3][1]     <= reg_mfcc_feat[2][1];
                reg_mfcc_feat[3][2]     <= reg_mfcc_feat[2][2];
                reg_mfcc_feat[3][3]     <= reg_mfcc_feat[2][3];
                reg_mfcc_feat[3][4]     <= reg_mfcc_feat[2][4];
                reg_mfcc_feat[3][5]     <= reg_mfcc_feat[2][5];
                reg_mfcc_feat[3][6]     <= reg_mfcc_feat[2][6];
                reg_mfcc_feat[3][7]     <= reg_mfcc_feat[2][7];
                reg_mfcc_feat[3][8]     <= reg_mfcc_feat[2][8];
                reg_mfcc_feat[3][9]     <= reg_mfcc_feat[2][9];
                reg_mfcc_feat[3][10]    <= reg_mfcc_feat[2][10];
                reg_mfcc_feat[3][11]    <= reg_mfcc_feat[2][11];
                reg_mfcc_feat[3][12]    <= reg_mfcc_feat[2][12];
                
                reg_mfcc_feat[4][0]     <= reg_mfcc_feat[3][0];
                reg_mfcc_feat[4][1]     <= reg_mfcc_feat[3][1];
                reg_mfcc_feat[4][2]     <= reg_mfcc_feat[3][2];
                reg_mfcc_feat[4][3]     <= reg_mfcc_feat[3][3];
                reg_mfcc_feat[4][4]     <= reg_mfcc_feat[3][4];
                reg_mfcc_feat[4][5]     <= reg_mfcc_feat[3][5];
                reg_mfcc_feat[4][6]     <= reg_mfcc_feat[3][6];
                reg_mfcc_feat[4][7]     <= reg_mfcc_feat[3][7];
                reg_mfcc_feat[4][8]     <= reg_mfcc_feat[3][8];
                reg_mfcc_feat[4][9]     <= reg_mfcc_feat[3][9];
                reg_mfcc_feat[4][10]    <= reg_mfcc_feat[3][10];
                reg_mfcc_feat[4][11]    <= reg_mfcc_feat[3][11];
                reg_mfcc_feat[4][12]    <= reg_mfcc_feat[3][12];
                
                if (initial_pause < 5) begin
                    initial_pause <= initial_pause + 1;
                end
            end
            
            if (rising_edge_tvalid_d1_mfcc_feat) begin
                reg_d1_mfcc_feat[1][0]  <= reg_d1_mfcc_feat[0][0];
                reg_d1_mfcc_feat[1][1]  <= reg_d1_mfcc_feat[0][1];
                reg_d1_mfcc_feat[1][2]  <= reg_d1_mfcc_feat[0][2];
                reg_d1_mfcc_feat[1][3]  <= reg_d1_mfcc_feat[0][3];
                reg_d1_mfcc_feat[1][4]  <= reg_d1_mfcc_feat[0][4];
                reg_d1_mfcc_feat[1][5]  <= reg_d1_mfcc_feat[0][5];
                reg_d1_mfcc_feat[1][6]  <= reg_d1_mfcc_feat[0][6];
                reg_d1_mfcc_feat[1][7]  <= reg_d1_mfcc_feat[0][7];
                reg_d1_mfcc_feat[1][8]  <= reg_d1_mfcc_feat[0][8];
                reg_d1_mfcc_feat[1][9]  <= reg_d1_mfcc_feat[0][9];
                reg_d1_mfcc_feat[1][10] <= reg_d1_mfcc_feat[0][10];
                reg_d1_mfcc_feat[1][11] <= reg_d1_mfcc_feat[0][11];
                reg_d1_mfcc_feat[1][12] <= reg_d1_mfcc_feat[0][12];
                
                reg_d1_mfcc_feat[2][0]  <= reg_d1_mfcc_feat[1][0];
                reg_d1_mfcc_feat[2][1]  <= reg_d1_mfcc_feat[1][1];
                reg_d1_mfcc_feat[2][2]  <= reg_d1_mfcc_feat[1][2];
                reg_d1_mfcc_feat[2][3]  <= reg_d1_mfcc_feat[1][3];
                reg_d1_mfcc_feat[2][4]  <= reg_d1_mfcc_feat[1][4];
                reg_d1_mfcc_feat[2][5]  <= reg_d1_mfcc_feat[1][5];
                reg_d1_mfcc_feat[2][6]  <= reg_d1_mfcc_feat[1][6];
                reg_d1_mfcc_feat[2][7]  <= reg_d1_mfcc_feat[1][7];
                reg_d1_mfcc_feat[2][8]  <= reg_d1_mfcc_feat[1][8];
                reg_d1_mfcc_feat[2][9]  <= reg_d1_mfcc_feat[1][9];
                reg_d1_mfcc_feat[2][10] <= reg_d1_mfcc_feat[1][10];
                reg_d1_mfcc_feat[2][11] <= reg_d1_mfcc_feat[1][11];
                reg_d1_mfcc_feat[2][12] <= reg_d1_mfcc_feat[1][12];
            end
            
            if (falling_edge_tvalid_mfcc_feat) begin
                if (initial_pause == 5) begin
                    reg_SVM[38] <= reg_mfcc_feat[4][12];
                    reg_SVM[37] <= reg_mfcc_feat[4][11];
                    reg_SVM[36] <= reg_mfcc_feat[4][10];
                    reg_SVM[35] <= reg_mfcc_feat[4][9];
                    reg_SVM[34] <= reg_mfcc_feat[4][8];
                    reg_SVM[33] <= reg_mfcc_feat[4][7];
                    reg_SVM[32] <= reg_mfcc_feat[4][6];
                    reg_SVM[31] <= reg_mfcc_feat[4][5];
                    reg_SVM[30] <= reg_mfcc_feat[4][4];
                    reg_SVM[29] <= reg_mfcc_feat[4][3];
                    reg_SVM[28] <= reg_mfcc_feat[4][2];
                    reg_SVM[27] <= reg_mfcc_feat[4][1];
                    reg_SVM[26] <= reg_mfcc_feat[4][0];
                end
            end
            
            if (falling_edge_tvalid_d1_mfcc_feat) begin
                if (initial_pause == 5) begin
                    reg_SVM[25] <= reg_d1_mfcc_feat[2][12];
                    reg_SVM[24] <= reg_d1_mfcc_feat[2][11];
                    reg_SVM[23] <= reg_d1_mfcc_feat[2][10];
                    reg_SVM[22] <= reg_d1_mfcc_feat[2][9];
                    reg_SVM[21] <= reg_d1_mfcc_feat[2][8];
                    reg_SVM[20] <= reg_d1_mfcc_feat[2][7];
                    reg_SVM[19] <= reg_d1_mfcc_feat[2][6];
                    reg_SVM[18] <= reg_d1_mfcc_feat[2][5];
                    reg_SVM[17] <= reg_d1_mfcc_feat[2][4];
                    reg_SVM[16] <= reg_d1_mfcc_feat[2][3];
                    reg_SVM[15] <= reg_d1_mfcc_feat[2][2];
                    reg_SVM[14] <= reg_d1_mfcc_feat[2][1];
                    reg_SVM[13] <= reg_d1_mfcc_feat[2][0];
                end
            end
            
            if (tvalid_d2_mfcc_feat) begin
                if (initial_pause == 5) begin
                    reg_SVM[0]  <= d2_mfcc_feat;
                    reg_SVM[1]  <= reg_SVM[0];
                    reg_SVM[2]  <= reg_SVM[1];
                    reg_SVM[3]  <= reg_SVM[2];
                    reg_SVM[4]  <= reg_SVM[3];
                    reg_SVM[5]  <= reg_SVM[4];
                    reg_SVM[6]  <= reg_SVM[5];
                    reg_SVM[7]  <= reg_SVM[6];
                    reg_SVM[8]  <= reg_SVM[7];
                    reg_SVM[9]  <= reg_SVM[8];
                    reg_SVM[10] <= reg_SVM[9];
                    reg_SVM[11] <= reg_SVM[10];
                    reg_SVM[12] <= reg_SVM[11];
                end
            end
            
            if (falling_edge_tvalid_d2_mfcc_feat) begin
                if (initial_pause == 5) begin
                    start_transmit_SVM <= 1'b1;
                end
            end
            
            if (start_transmit_SVM) begin
                cnt_SVM_samples <= cnt_SVM_samples + 1;
                
                if (cnt_SVM_samples < 39) begin
                    tvalid_SVM_tmp <= 1'b1;
                    
                    reg_SVM[38] <= reg_SVM[37];
                    reg_SVM[37] <= reg_SVM[36];
                    reg_SVM[36] <= reg_SVM[35];
                    reg_SVM[35] <= reg_SVM[34];
                    reg_SVM[34] <= reg_SVM[33];
                    reg_SVM[33] <= reg_SVM[32];
                    reg_SVM[32] <= reg_SVM[31];
                    reg_SVM[31] <= reg_SVM[30];
                    reg_SVM[30] <= reg_SVM[29];
                    reg_SVM[29] <= reg_SVM[28];
                    reg_SVM[28] <= reg_SVM[27];
                    reg_SVM[27] <= reg_SVM[26];
                    reg_SVM[26] <= reg_SVM[25];
                    reg_SVM[25] <= reg_SVM[24];
                    reg_SVM[24] <= reg_SVM[23];
                    reg_SVM[23] <= reg_SVM[22];
                    reg_SVM[22] <= reg_SVM[21];
                    reg_SVM[21] <= reg_SVM[20];
                    reg_SVM[20] <= reg_SVM[19];
                    reg_SVM[19] <= reg_SVM[18];
                    reg_SVM[18] <= reg_SVM[17];
                    reg_SVM[17] <= reg_SVM[16];
                    reg_SVM[16] <= reg_SVM[15];
                    reg_SVM[15] <= reg_SVM[14];
                    reg_SVM[14] <= reg_SVM[13];
                    reg_SVM[13] <= reg_SVM[12];
                    reg_SVM[12] <= reg_SVM[11];
                    reg_SVM[11] <= reg_SVM[10];
                    reg_SVM[10] <= reg_SVM[9];
                    reg_SVM[9]  <= reg_SVM[8];
                    reg_SVM[8]  <= reg_SVM[7];
                    reg_SVM[7]  <= reg_SVM[6];
                    reg_SVM[6]  <= reg_SVM[5];
                    reg_SVM[5]  <= reg_SVM[4];
                    reg_SVM[4]  <= reg_SVM[3];
                    reg_SVM[3]  <= reg_SVM[2];
                    reg_SVM[2]  <= reg_SVM[1];
                    reg_SVM[1]  <= reg_SVM[0];
                end
                else begin
                    tvalid_SVM_tmp      <= 1'b0;
                    start_transmit_SVM  <= 1'b0;
                    cnt_SVM_samples     <= 0;
                end
            end
        end
    end
    
    delta calc_d1_mfcc (
        .clk(clk),
        .reset(reset),
    
        .tvalid_mfcc(tvalid_mfcc_feat),
        .mfcc(mfcc_feat),
    
        .tvalid_d1_mfcc(tvalid_d1_mfcc_feat),
        .d1_mfcc(d1_mfcc_feat)
    );

    delta calc_d2_mfcc (
        .clk(clk),
        .reset(reset),
    
        .tvalid_mfcc(tvalid_d1_mfcc_feat),
        .mfcc(d1_mfcc_feat),
    
        .tvalid_d1_mfcc(tvalid_d2_mfcc_feat),
        .d1_mfcc(d2_mfcc_feat)
    );
    
    assign tvalid_SVM   = tvalid_SVM_tmp;
    assign SVM          = reg_SVM_tmp;

endmodule
