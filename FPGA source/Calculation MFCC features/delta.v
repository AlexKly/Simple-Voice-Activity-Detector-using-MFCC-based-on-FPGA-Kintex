`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2021 15:53:17
// Design Name: 
// Module Name: delta
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


module delta(
	input clk,
    input reset,

    input tvalid_mfcc,
    input [31:0] mfcc,

    output tvalid_d1_mfcc,
    output [31:0] d1_mfcc
    );
    
	localparam [31:0] INIT_SAMPLE  = 32'b0;
    localparam [31:0] CONST_2      = 32'h40000000;
    localparam [31:0] CONST_10     = 32'h41200000;        
     
    localparam [2:0] INIT                   = 0;
    localparam [2:0] WAIT_FIRST_FRAME       = 1;
    localparam [2:0] WAIT_SECOND_FRAME      = 2;
    localparam [2:0] WAIT_THIRD_FRAME       = 3;
    localparam [2:0] LAST_TRANSACTION       = 4;
    localparam [2:0] PREPARATION_FOR_CALC   = 5;
    localparam [2:0] WAIT_FRAME             = 6;
    localparam [2:0] CALC_DELTA             = 7;

    reg [2:0] delta_fsm_st = INIT;
    
    reg [31:0] vec_mfcc [12:0];
    reg [31:0] block_mem [4:0][12:0];
    reg [31:0] mem_for_calc [4:0][12:0];
    
    reg past_front_tvalid_mfcc;
    wire falling_edge_tvalid_mfcc = past_front_tvalid_mfcc && !tvalid_mfcc;
    
    reg [3:0] cnt_shift_coefficients    = 0;
    reg en_calc_delta                   = 1'b0;
    
    // Floating point:
    wire tvalid_result_first_sub;
    wire [31:0] result_first_sub;
    wire tvalid_result_second_sub;
    wire [31:0] result_second_sub;
    wire tvalid_result_mult;
    wire [31:0] result_mult;
    wire tvalid_result_add;
    wire [31:0] result_add;
    wire tvalid_result_div;
    wire [31:0] result_div;
    
    reg delayed_tvalid_result_first_sub = 1'b0;
    reg [31:0] delayed_result_first_sub = 1'b0;
    
    always@ (posedge clk) begin
        past_front_tvalid_mfcc <= tvalid_mfcc;
        
        delayed_tvalid_result_first_sub <= tvalid_result_first_sub;
        delayed_result_first_sub        <= result_first_sub;
    
        // Input register:
        if (tvalid_mfcc) begin
            vec_mfcc[12]    <= mfcc;
            vec_mfcc[11]    <= vec_mfcc[12];
            vec_mfcc[10]    <= vec_mfcc[11];
            vec_mfcc[9]     <= vec_mfcc[10];
            vec_mfcc[8]     <= vec_mfcc[9];
            vec_mfcc[7]     <= vec_mfcc[8];
            vec_mfcc[6]     <= vec_mfcc[7];
            vec_mfcc[5]     <= vec_mfcc[6];
            vec_mfcc[4]     <= vec_mfcc[5];
            vec_mfcc[3]     <= vec_mfcc[4];
            vec_mfcc[2]     <= vec_mfcc[3];
            vec_mfcc[1]     <= vec_mfcc[2];
            vec_mfcc[0]     <= vec_mfcc[1];
        end
        
        case(delta_fsm_st)
            INIT: begin
                // Reset fourth page ram:
                block_mem[4][12]    <= INIT_SAMPLE;
                block_mem[4][11]    <= INIT_SAMPLE;
                block_mem[4][10]    <= INIT_SAMPLE;
                block_mem[4][9]     <= INIT_SAMPLE;
                block_mem[4][8]     <= INIT_SAMPLE;
                block_mem[4][7]     <= INIT_SAMPLE;
                block_mem[4][6]     <= INIT_SAMPLE;
                block_mem[4][5]     <= INIT_SAMPLE;
                block_mem[4][4]     <= INIT_SAMPLE;
                block_mem[4][3]     <= INIT_SAMPLE;
                block_mem[4][2]     <= INIT_SAMPLE;
                block_mem[4][1]     <= INIT_SAMPLE;
                block_mem[4][0]     <= INIT_SAMPLE;
                
                mem_for_calc[4][12] <= INIT_SAMPLE;
                mem_for_calc[4][11] <= INIT_SAMPLE;
                mem_for_calc[4][10] <= INIT_SAMPLE;
                mem_for_calc[4][9]  <= INIT_SAMPLE;
                mem_for_calc[4][8]  <= INIT_SAMPLE;
                mem_for_calc[4][7]  <= INIT_SAMPLE;
                mem_for_calc[4][6]  <= INIT_SAMPLE;
                mem_for_calc[4][5]  <= INIT_SAMPLE;
                mem_for_calc[4][4]  <= INIT_SAMPLE;
                mem_for_calc[4][3]  <= INIT_SAMPLE;
                mem_for_calc[4][2]  <= INIT_SAMPLE;
                mem_for_calc[4][1]  <= INIT_SAMPLE;
                mem_for_calc[4][0]  <= INIT_SAMPLE;
                
                // Reset third page ram:
                block_mem[3][12]    <= INIT_SAMPLE;
                block_mem[3][11]    <= INIT_SAMPLE;
                block_mem[3][10]    <= INIT_SAMPLE;
                block_mem[3][9]     <= INIT_SAMPLE;
                block_mem[3][8]     <= INIT_SAMPLE;
                block_mem[3][7]     <= INIT_SAMPLE;
                block_mem[3][6]     <= INIT_SAMPLE;
                block_mem[3][5]     <= INIT_SAMPLE;
                block_mem[3][4]     <= INIT_SAMPLE;
                block_mem[3][3]     <= INIT_SAMPLE;
                block_mem[3][2]     <= INIT_SAMPLE;
                block_mem[3][1]     <= INIT_SAMPLE;
                block_mem[3][0]     <= INIT_SAMPLE;
                
                mem_for_calc[3][12] <= INIT_SAMPLE;
                mem_for_calc[3][11] <= INIT_SAMPLE;
                mem_for_calc[3][10] <= INIT_SAMPLE;
                mem_for_calc[3][9]  <= INIT_SAMPLE;
                mem_for_calc[3][8]  <= INIT_SAMPLE;
                mem_for_calc[3][7]  <= INIT_SAMPLE;
                mem_for_calc[3][6]  <= INIT_SAMPLE;
                mem_for_calc[3][5]  <= INIT_SAMPLE;
                mem_for_calc[3][4]  <= INIT_SAMPLE;
                mem_for_calc[3][3]  <= INIT_SAMPLE;
                mem_for_calc[3][2]  <= INIT_SAMPLE;
                mem_for_calc[3][1]  <= INIT_SAMPLE;
                mem_for_calc[3][0]  <= INIT_SAMPLE;
                
                // Reset second page ram:
                block_mem[2][12]    <= INIT_SAMPLE;
                block_mem[2][11]    <= INIT_SAMPLE;
                block_mem[2][10]    <= INIT_SAMPLE;
                block_mem[2][9]     <= INIT_SAMPLE;
                block_mem[2][8]     <= INIT_SAMPLE;
                block_mem[2][7]     <= INIT_SAMPLE;
                block_mem[2][6]     <= INIT_SAMPLE;
                block_mem[2][5]     <= INIT_SAMPLE;
                block_mem[2][4]     <= INIT_SAMPLE;
                block_mem[2][3]     <= INIT_SAMPLE;
                block_mem[2][2]     <= INIT_SAMPLE;
                block_mem[2][1]     <= INIT_SAMPLE;
                block_mem[2][0]     <= INIT_SAMPLE;
                
                mem_for_calc[2][12] <= INIT_SAMPLE;
                mem_for_calc[2][11] <= INIT_SAMPLE;
                mem_for_calc[2][10] <= INIT_SAMPLE;
                mem_for_calc[2][9]  <= INIT_SAMPLE;
                mem_for_calc[2][8]  <= INIT_SAMPLE;
                mem_for_calc[2][7]  <= INIT_SAMPLE;
                mem_for_calc[2][6]  <= INIT_SAMPLE;
                mem_for_calc[2][5]  <= INIT_SAMPLE;
                mem_for_calc[2][4]  <= INIT_SAMPLE;
                mem_for_calc[2][3]  <= INIT_SAMPLE;
                mem_for_calc[2][2]  <= INIT_SAMPLE;
                mem_for_calc[2][1]  <= INIT_SAMPLE;
                mem_for_calc[2][0]  <= INIT_SAMPLE;
            
                // Reset first page ram:
                block_mem[1][12]    <= INIT_SAMPLE;
                block_mem[1][11]    <= INIT_SAMPLE;
                block_mem[1][10]    <= INIT_SAMPLE;
                block_mem[1][9]     <= INIT_SAMPLE;
                block_mem[1][8]     <= INIT_SAMPLE;
                block_mem[1][7]     <= INIT_SAMPLE;
                block_mem[1][6]     <= INIT_SAMPLE;
                block_mem[1][5]     <= INIT_SAMPLE;
                block_mem[1][4]     <= INIT_SAMPLE;
                block_mem[1][3]     <= INIT_SAMPLE;
                block_mem[1][2]     <= INIT_SAMPLE;
                block_mem[1][1]     <= INIT_SAMPLE;
                block_mem[1][0]     <= INIT_SAMPLE;
                
                mem_for_calc[1][12] <= INIT_SAMPLE;
                mem_for_calc[1][11] <= INIT_SAMPLE;
                mem_for_calc[1][10] <= INIT_SAMPLE;
                mem_for_calc[1][9]  <= INIT_SAMPLE;
                mem_for_calc[1][8]  <= INIT_SAMPLE;
                mem_for_calc[1][7]  <= INIT_SAMPLE;
                mem_for_calc[1][6]  <= INIT_SAMPLE;
                mem_for_calc[1][5]  <= INIT_SAMPLE;
                mem_for_calc[1][4]  <= INIT_SAMPLE;
                mem_for_calc[1][3]  <= INIT_SAMPLE;
                mem_for_calc[1][2]  <= INIT_SAMPLE;
                mem_for_calc[1][1]  <= INIT_SAMPLE;
                mem_for_calc[1][0]  <= INIT_SAMPLE;
                
                // Reset zero page ram:
                block_mem[0][12]    <= INIT_SAMPLE;
                block_mem[0][11]    <= INIT_SAMPLE;
                block_mem[0][10]    <= INIT_SAMPLE;
                block_mem[0][9]     <= INIT_SAMPLE;
                block_mem[0][8]     <= INIT_SAMPLE;
                block_mem[0][7]     <= INIT_SAMPLE;
                block_mem[0][6]     <= INIT_SAMPLE;
                block_mem[0][5]     <= INIT_SAMPLE;
                block_mem[0][4]     <= INIT_SAMPLE;
                block_mem[0][3]     <= INIT_SAMPLE;
                block_mem[0][2]     <= INIT_SAMPLE;
                block_mem[0][1]     <= INIT_SAMPLE;
                block_mem[0][0]     <= INIT_SAMPLE;
                
                mem_for_calc[0][12] <= INIT_SAMPLE;
                mem_for_calc[0][11] <= INIT_SAMPLE;
                mem_for_calc[0][10] <= INIT_SAMPLE;
                mem_for_calc[0][9]  <= INIT_SAMPLE;
                mem_for_calc[0][8]  <= INIT_SAMPLE;
                mem_for_calc[0][7]  <= INIT_SAMPLE;
                mem_for_calc[0][6]  <= INIT_SAMPLE;
                mem_for_calc[0][5]  <= INIT_SAMPLE;
                mem_for_calc[0][4]  <= INIT_SAMPLE;
                mem_for_calc[0][3]  <= INIT_SAMPLE;
                mem_for_calc[0][2]  <= INIT_SAMPLE;
                mem_for_calc[0][1]  <= INIT_SAMPLE;
                mem_for_calc[0][0]  <= INIT_SAMPLE;
                
                delta_fsm_st <= WAIT_FIRST_FRAME;
            end
            
            WAIT_FIRST_FRAME: begin
                if (falling_edge_tvalid_mfcc) begin
                    block_mem[0][12]    <= vec_mfcc[12];
                    block_mem[0][11]    <= vec_mfcc[11];
                    block_mem[0][10]    <= vec_mfcc[10];
                    block_mem[0][9]     <= vec_mfcc[9];
                    block_mem[0][8]     <= vec_mfcc[8];
                    block_mem[0][7]     <= vec_mfcc[7];
                    block_mem[0][6]     <= vec_mfcc[6];
                    block_mem[0][5]     <= vec_mfcc[5];
                    block_mem[0][4]     <= vec_mfcc[4];
                    block_mem[0][3]     <= vec_mfcc[3];
                    block_mem[0][2]     <= vec_mfcc[2];
                    block_mem[0][1]     <= vec_mfcc[1];
                    block_mem[0][0]     <= vec_mfcc[0];
                    
                    delta_fsm_st <= WAIT_SECOND_FRAME;
                end
            end
            
            WAIT_SECOND_FRAME: begin
                if (falling_edge_tvalid_mfcc) begin
                    block_mem[0][12]    <= vec_mfcc[12];
                    block_mem[0][11]    <= vec_mfcc[11];
                    block_mem[0][10]    <= vec_mfcc[10];
                    block_mem[0][9]     <= vec_mfcc[9];
                    block_mem[0][8]     <= vec_mfcc[8];
                    block_mem[0][7]     <= vec_mfcc[7];
                    block_mem[0][6]     <= vec_mfcc[6];
                    block_mem[0][5]     <= vec_mfcc[5];
                    block_mem[0][4]     <= vec_mfcc[4];
                    block_mem[0][3]     <= vec_mfcc[3];
                    block_mem[0][2]     <= vec_mfcc[2];
                    block_mem[0][1]     <= vec_mfcc[1];
                    block_mem[0][0]     <= vec_mfcc[0];
                    
                    block_mem[1][12]    <= block_mem[0][12];
                    block_mem[1][11]    <= block_mem[0][11];
                    block_mem[1][10]    <= block_mem[0][10];
                    block_mem[1][9]     <= block_mem[0][9];
                    block_mem[1][8]     <= block_mem[0][8];
                    block_mem[1][7]     <= block_mem[0][7];
                    block_mem[1][6]     <= block_mem[0][6];
                    block_mem[1][5]     <= block_mem[0][5];
                    block_mem[1][4]     <= block_mem[0][4];
                    block_mem[1][3]     <= block_mem[0][3];
                    block_mem[1][2]     <= block_mem[0][2];
                    block_mem[1][1]     <= block_mem[0][1];
                    block_mem[1][0]     <= block_mem[0][0];
                    
                    delta_fsm_st <= WAIT_THIRD_FRAME;
                end
            end
            
            WAIT_THIRD_FRAME: begin
                if (falling_edge_tvalid_mfcc) begin
                    block_mem[0][12]    <= vec_mfcc[12];
                    block_mem[0][11]    <= vec_mfcc[11];
                    block_mem[0][10]    <= vec_mfcc[10];
                    block_mem[0][9]     <= vec_mfcc[9];
                    block_mem[0][8]     <= vec_mfcc[8];
                    block_mem[0][7]     <= vec_mfcc[7];
                    block_mem[0][6]     <= vec_mfcc[6];
                    block_mem[0][5]     <= vec_mfcc[5];
                    block_mem[0][4]     <= vec_mfcc[4];
                    block_mem[0][3]     <= vec_mfcc[3];
                    block_mem[0][2]     <= vec_mfcc[2];
                    block_mem[0][1]     <= vec_mfcc[1];
                    block_mem[0][0]     <= vec_mfcc[0];
                    
                    block_mem[1][12]    <= block_mem[0][12];
                    block_mem[1][11]    <= block_mem[0][11];
                    block_mem[1][10]    <= block_mem[0][10];
                    block_mem[1][9]     <= block_mem[0][9];
                    block_mem[1][8]     <= block_mem[0][8];
                    block_mem[1][7]     <= block_mem[0][7];
                    block_mem[1][6]     <= block_mem[0][6];
                    block_mem[1][5]     <= block_mem[0][5];
                    block_mem[1][4]     <= block_mem[0][4];
                    block_mem[1][3]     <= block_mem[0][3];
                    block_mem[1][2]     <= block_mem[0][2];
                    block_mem[1][1]     <= block_mem[0][1];
                    block_mem[1][0]     <= block_mem[0][0];
                    
                    block_mem[2][12]    <= block_mem[1][12];
                    block_mem[2][11]    <= block_mem[1][11];
                    block_mem[2][10]    <= block_mem[1][10];
                    block_mem[2][9]     <= block_mem[1][9];
                    block_mem[2][8]     <= block_mem[1][8];
                    block_mem[2][7]     <= block_mem[1][7];
                    block_mem[2][6]     <= block_mem[1][6];
                    block_mem[2][5]     <= block_mem[1][5];
                    block_mem[2][4]     <= block_mem[1][4];
                    block_mem[2][3]     <= block_mem[1][3];
                    block_mem[2][2]     <= block_mem[1][2];
                    block_mem[2][1]     <= block_mem[1][1];
                    block_mem[2][0]     <= block_mem[1][0];
                    
                    delta_fsm_st <= LAST_TRANSACTION;
                end
            end
            
            LAST_TRANSACTION: begin
                block_mem[3][12]    <= block_mem[2][12];
                block_mem[3][11]    <= block_mem[2][11];
                block_mem[3][10]    <= block_mem[2][10];
                block_mem[3][9]     <= block_mem[2][9];
                block_mem[3][8]     <= block_mem[2][8];
                block_mem[3][7]     <= block_mem[2][7];
                block_mem[3][6]     <= block_mem[2][6];
                block_mem[3][5]     <= block_mem[2][5];
                block_mem[3][4]     <= block_mem[2][4];
                block_mem[3][3]     <= block_mem[2][3];
                block_mem[3][2]     <= block_mem[2][2];
                block_mem[3][1]     <= block_mem[2][1];
                block_mem[3][0]     <= block_mem[2][0];
                
                block_mem[4][12]    <= block_mem[2][12];
                block_mem[4][11]    <= block_mem[2][11];
                block_mem[4][10]    <= block_mem[2][10];
                block_mem[4][9]     <= block_mem[2][9];
                block_mem[4][8]     <= block_mem[2][8];
                block_mem[4][7]     <= block_mem[2][7];
                block_mem[4][6]     <= block_mem[2][6];
                block_mem[4][5]     <= block_mem[2][5];
                block_mem[4][4]     <= block_mem[2][4];
                block_mem[4][3]     <= block_mem[2][3];
                block_mem[4][2]     <= block_mem[2][2];
                block_mem[4][1]     <= block_mem[2][1];
                block_mem[4][0]     <= block_mem[2][0];
                
                delta_fsm_st <= PREPARATION_FOR_CALC;
            end
            
            PREPARATION_FOR_CALC: begin
                mem_for_calc[0][12] <= block_mem[0][12];
                mem_for_calc[0][11] <= block_mem[0][11];
                mem_for_calc[0][10] <= block_mem[0][10];
                mem_for_calc[0][9]  <= block_mem[0][9];
                mem_for_calc[0][8]  <= block_mem[0][8];
                mem_for_calc[0][7]  <= block_mem[0][7];
                mem_for_calc[0][6]  <= block_mem[0][6];
                mem_for_calc[0][5]  <= block_mem[0][5];
                mem_for_calc[0][4]  <= block_mem[0][4];
                mem_for_calc[0][3]  <= block_mem[0][3];
                mem_for_calc[0][2]  <= block_mem[0][2];
                mem_for_calc[0][1]  <= block_mem[0][1];
                mem_for_calc[0][0]  <= block_mem[0][0];
                
                mem_for_calc[1][12] <= block_mem[1][12];
                mem_for_calc[1][11] <= block_mem[1][11];
                mem_for_calc[1][10] <= block_mem[1][10];
                mem_for_calc[1][9]  <= block_mem[1][9];
                mem_for_calc[1][8]  <= block_mem[1][8];
                mem_for_calc[1][7]  <= block_mem[1][7];
                mem_for_calc[1][6]  <= block_mem[1][6];
                mem_for_calc[1][5]  <= block_mem[1][5];
                mem_for_calc[1][4]  <= block_mem[1][4];
                mem_for_calc[1][3]  <= block_mem[1][3];
                mem_for_calc[1][2]  <= block_mem[1][2];
                mem_for_calc[1][1]  <= block_mem[1][1];
                mem_for_calc[1][0]  <= block_mem[1][0];
                
                mem_for_calc[2][12] <= block_mem[2][12];
                mem_for_calc[2][11] <= block_mem[2][11];
                mem_for_calc[2][10] <= block_mem[2][10];
                mem_for_calc[2][9]  <= block_mem[2][9];
                mem_for_calc[2][8]  <= block_mem[2][8];
                mem_for_calc[2][7]  <= block_mem[2][7];
                mem_for_calc[2][6]  <= block_mem[2][6];
                mem_for_calc[2][5]  <= block_mem[2][5];
                mem_for_calc[2][4]  <= block_mem[2][4];
                mem_for_calc[2][3]  <= block_mem[2][3];
                mem_for_calc[2][2]  <= block_mem[2][2];
                mem_for_calc[2][1]  <= block_mem[2][1];
                mem_for_calc[2][0]  <= block_mem[2][0];
                
                mem_for_calc[3][12] <= block_mem[3][12];
                mem_for_calc[3][11] <= block_mem[3][11];
                mem_for_calc[3][10] <= block_mem[3][10];
                mem_for_calc[3][9]  <= block_mem[3][9];
                mem_for_calc[3][8]  <= block_mem[3][8];
                mem_for_calc[3][7]  <= block_mem[3][7];
                mem_for_calc[3][6]  <= block_mem[3][6];
                mem_for_calc[3][5]  <= block_mem[3][5];
                mem_for_calc[3][4]  <= block_mem[3][4];
                mem_for_calc[3][3]  <= block_mem[3][3];
                mem_for_calc[3][2]  <= block_mem[3][2];
                mem_for_calc[3][1]  <= block_mem[3][1];
                mem_for_calc[3][0]  <= block_mem[3][0];
                
                mem_for_calc[4][12] <= block_mem[4][12];
                mem_for_calc[4][11] <= block_mem[4][11];
                mem_for_calc[4][10] <= block_mem[4][10];
                mem_for_calc[4][9]  <= block_mem[4][9];
                mem_for_calc[4][8]  <= block_mem[4][8];
                mem_for_calc[4][7]  <= block_mem[4][7];
                mem_for_calc[4][6]  <= block_mem[4][6];
                mem_for_calc[4][5]  <= block_mem[4][5];
                mem_for_calc[4][4]  <= block_mem[4][4];
                mem_for_calc[4][3]  <= block_mem[4][3];
                mem_for_calc[4][2]  <= block_mem[4][2];
                mem_for_calc[4][1]  <= block_mem[4][1];
                mem_for_calc[4][0]  <= block_mem[4][0];
                
                en_calc_delta <= 1'b1;
                
                delta_fsm_st <= CALC_DELTA;
            end
            
            WAIT_FRAME: begin
                if (falling_edge_tvalid_mfcc) begin
                    block_mem[0][12]    <= vec_mfcc[12];
                    block_mem[0][11]    <= vec_mfcc[11];
                    block_mem[0][10]    <= vec_mfcc[10];
                    block_mem[0][9]     <= vec_mfcc[9];
                    block_mem[0][8]     <= vec_mfcc[8];
                    block_mem[0][7]     <= vec_mfcc[7];
                    block_mem[0][6]     <= vec_mfcc[6];
                    block_mem[0][5]     <= vec_mfcc[5];
                    block_mem[0][4]     <= vec_mfcc[4];
                    block_mem[0][3]     <= vec_mfcc[3];
                    block_mem[0][2]     <= vec_mfcc[2];
                    block_mem[0][1]     <= vec_mfcc[1];
                    block_mem[0][0]     <= vec_mfcc[0];
                    
                    block_mem[1][12]    <= block_mem[0][12];
                    block_mem[1][11]    <= block_mem[0][11];
                    block_mem[1][10]    <= block_mem[0][10];
                    block_mem[1][9]     <= block_mem[0][9];
                    block_mem[1][8]     <= block_mem[0][8];
                    block_mem[1][7]     <= block_mem[0][7];
                    block_mem[1][6]     <= block_mem[0][6];
                    block_mem[1][5]     <= block_mem[0][5];
                    block_mem[1][4]     <= block_mem[0][4];
                    block_mem[1][3]     <= block_mem[0][3];
                    block_mem[1][2]     <= block_mem[0][2];
                    block_mem[1][1]     <= block_mem[0][1];
                    block_mem[1][0]     <= block_mem[0][0];
                    
                    block_mem[2][12]    <= block_mem[1][12];
                    block_mem[2][11]    <= block_mem[1][11];
                    block_mem[2][10]    <= block_mem[1][10];
                    block_mem[2][9]     <= block_mem[1][9];
                    block_mem[2][8]     <= block_mem[1][8];
                    block_mem[2][7]     <= block_mem[1][7];
                    block_mem[2][6]     <= block_mem[1][6];
                    block_mem[2][5]     <= block_mem[1][5];
                    block_mem[2][4]     <= block_mem[1][4];
                    block_mem[2][3]     <= block_mem[1][3];
                    block_mem[2][2]     <= block_mem[1][2];
                    block_mem[2][1]     <= block_mem[1][1];
                    block_mem[2][0]     <= block_mem[1][0];
                    
                    block_mem[3][12]    <= block_mem[2][12];
                    block_mem[3][11]    <= block_mem[2][11];
                    block_mem[3][10]    <= block_mem[2][10];
                    block_mem[3][9]     <= block_mem[2][9];
                    block_mem[3][8]     <= block_mem[2][8];
                    block_mem[3][7]     <= block_mem[2][7];
                    block_mem[3][6]     <= block_mem[2][6];
                    block_mem[3][5]     <= block_mem[2][5];
                    block_mem[3][4]     <= block_mem[2][4];
                    block_mem[3][3]     <= block_mem[2][3];
                    block_mem[3][2]     <= block_mem[2][2];
                    block_mem[3][1]     <= block_mem[2][1];
                    block_mem[3][0]     <= block_mem[2][0];
                    
                    block_mem[4][12]    <= block_mem[3][12];
                    block_mem[4][11]    <= block_mem[3][11];
                    block_mem[4][10]    <= block_mem[3][10];
                    block_mem[4][9]     <= block_mem[3][9];
                    block_mem[4][8]     <= block_mem[3][8];
                    block_mem[4][7]     <= block_mem[3][7];
                    block_mem[4][6]     <= block_mem[3][6];
                    block_mem[4][5]     <= block_mem[3][5];
                    block_mem[4][4]     <= block_mem[3][4];
                    block_mem[4][3]     <= block_mem[3][3];
                    block_mem[4][2]     <= block_mem[3][2];
                    block_mem[4][1]     <= block_mem[3][1];
                    block_mem[4][0]     <= block_mem[3][0];
                    
                    delta_fsm_st <= PREPARATION_FOR_CALC;
                end
            end
            
            CALC_DELTA: begin
                cnt_shift_coefficients <= cnt_shift_coefficients + 1;
                if (cnt_shift_coefficients < 12) begin
                    // Shift coefficients from RAM:
                    mem_for_calc[4][11] <= mem_for_calc[4][12];
                    mem_for_calc[4][10] <= mem_for_calc[4][11];
                    mem_for_calc[4][9]  <= mem_for_calc[4][10];
                    mem_for_calc[4][8]  <= mem_for_calc[4][9];
                    mem_for_calc[4][7]  <= mem_for_calc[4][8];
                    mem_for_calc[4][6]  <= mem_for_calc[4][7];
                    mem_for_calc[4][5]  <= mem_for_calc[4][6];
                    mem_for_calc[4][4]  <= mem_for_calc[4][5];
                    mem_for_calc[4][3]  <= mem_for_calc[4][4];
                    mem_for_calc[4][2]  <= mem_for_calc[4][3];
                    mem_for_calc[4][1]  <= mem_for_calc[4][2];
                    mem_for_calc[4][0]  <= mem_for_calc[4][1];
                    
                    mem_for_calc[3][11] <= mem_for_calc[3][12];
                    mem_for_calc[3][10] <= mem_for_calc[3][11];
                    mem_for_calc[3][9]  <= mem_for_calc[3][10];
                    mem_for_calc[3][8]  <= mem_for_calc[3][9];
                    mem_for_calc[3][7]  <= mem_for_calc[3][8];
                    mem_for_calc[3][6]  <= mem_for_calc[3][7];
                    mem_for_calc[3][5]  <= mem_for_calc[3][6];
                    mem_for_calc[3][4]  <= mem_for_calc[3][5];
                    mem_for_calc[3][3]  <= mem_for_calc[3][4];
                    mem_for_calc[3][2]  <= mem_for_calc[3][3];
                    mem_for_calc[3][1]  <= mem_for_calc[3][2];
                    mem_for_calc[3][0]  <= mem_for_calc[3][1];
                    
                    mem_for_calc[2][11] <= mem_for_calc[2][12];
                    mem_for_calc[2][10] <= mem_for_calc[2][11];
                    mem_for_calc[2][9]  <= mem_for_calc[2][10];
                    mem_for_calc[2][8]  <= mem_for_calc[2][9];
                    mem_for_calc[2][7]  <= mem_for_calc[2][8];
                    mem_for_calc[2][6]  <= mem_for_calc[2][7];
                    mem_for_calc[2][5]  <= mem_for_calc[2][6];
                    mem_for_calc[2][4]  <= mem_for_calc[2][5];
                    mem_for_calc[2][3]  <= mem_for_calc[2][4];
                    mem_for_calc[2][2]  <= mem_for_calc[2][3];
                    mem_for_calc[2][1]  <= mem_for_calc[2][2];
                    mem_for_calc[2][0]  <= mem_for_calc[2][1];
                    
                    mem_for_calc[1][11] <= mem_for_calc[1][12];
                    mem_for_calc[1][10] <= mem_for_calc[1][11];
                    mem_for_calc[1][9]  <= mem_for_calc[1][10];
                    mem_for_calc[1][8]  <= mem_for_calc[1][9];
                    mem_for_calc[1][7]  <= mem_for_calc[1][8];
                    mem_for_calc[1][6]  <= mem_for_calc[1][7];
                    mem_for_calc[1][5]  <= mem_for_calc[1][6];
                    mem_for_calc[1][4]  <= mem_for_calc[1][5];
                    mem_for_calc[1][3]  <= mem_for_calc[1][4];
                    mem_for_calc[1][2]  <= mem_for_calc[1][3];
                    mem_for_calc[1][1]  <= mem_for_calc[1][2];
                    mem_for_calc[1][0]  <= mem_for_calc[1][1];
                    
                    mem_for_calc[0][11] <= mem_for_calc[0][12];
                    mem_for_calc[0][10] <= mem_for_calc[0][11];
                    mem_for_calc[0][9]  <= mem_for_calc[0][10];
                    mem_for_calc[0][8]  <= mem_for_calc[0][9];
                    mem_for_calc[0][7]  <= mem_for_calc[0][8];
                    mem_for_calc[0][6]  <= mem_for_calc[0][7];
                    mem_for_calc[0][5]  <= mem_for_calc[0][6];
                    mem_for_calc[0][4]  <= mem_for_calc[0][5];
                    mem_for_calc[0][3]  <= mem_for_calc[0][4];
                    mem_for_calc[0][2]  <= mem_for_calc[0][3];
                    mem_for_calc[0][1]  <= mem_for_calc[0][2];
                    mem_for_calc[0][0]  <= mem_for_calc[0][1];
                end
                else begin
                    cnt_shift_coefficients  <= 0;
                    en_calc_delta           <= 1'b0;
                
                    delta_fsm_st <= WAIT_FRAME;
                end
            end
        endcase
    end
    
    floating_point_sub first_sub (
        .aclk(clk),                                     // input aclk
        .s_axis_a_tvalid(en_calc_delta),                // input s_axis_a_tvalid
        .s_axis_a_tready(),                             // output s_axis_a_tready
        .s_axis_a_tdata(mem_for_calc[1][0]),            // input [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(en_calc_delta),                // input s_axis_b_tvalid
        .s_axis_b_tready(),                             // output s_axis_b_tready
        .s_axis_b_tdata(mem_for_calc[3][0]),            // input [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(tvalid_result_first_sub), // output m_axis_result_tvalid
        .m_axis_result_tdata(result_first_sub)          // output [31 : 0] m_axis_result_tdata
    );
    
    floating_point_sub second_sub (
        .aclk(clk),                                         // input aclk
        .s_axis_a_tvalid(en_calc_delta),                    // input s_axis_a_tvalid
        .s_axis_a_tready(),                                 // output s_axis_a_tready
        .s_axis_a_tdata(mem_for_calc[0][0]),                // input [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(en_calc_delta),                    // input s_axis_b_tvalid
        .s_axis_b_tready(),                                 // output s_axis_b_tready
        .s_axis_b_tdata(mem_for_calc[4][0]),                // input [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(tvalid_result_second_sub),    // output m_axis_result_tvalid
        .m_axis_result_tdata(result_second_sub)             // output [31 : 0] m_axis_result_tdata
    );
    
    floating_point_mult mult (
        .aclk(clk),                                 // input aclk
        .s_axis_a_tvalid(tvalid_result_second_sub), // input s_axis_a_tvalid
        .s_axis_a_tready(),                         // output s_axis_a_tready
        .s_axis_a_tdata(result_second_sub),         // input [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(tvalid_result_second_sub), // input s_axis_b_tvalid
        .s_axis_b_tready(),                         // output s_axis_b_tready
        .s_axis_b_tdata(CONST_2),                   // input [31 : 0] s_axis_b_tdata (float = 2.0)
        .m_axis_result_tvalid(tvalid_result_mult),  // output m_axis_result_tvalid
        .m_axis_result_tdata(result_mult)           // output [31 : 0] m_axis_result_tdata
    );
    
    floating_point_add add (
        .aclk(clk),                                         // input aclk
        .s_axis_a_tvalid(delayed_tvalid_result_first_sub),  // input s_axis_a_tvalid
        .s_axis_a_tready(),                                 // output s_axis_a_tready
        .s_axis_a_tdata(delayed_result_first_sub),          // input [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(tvalid_result_mult),               // input s_axis_b_tvalid
        .s_axis_b_tready(),                                 // output s_axis_b_tready
        .s_axis_b_tdata(result_mult),                       // input [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(tvalid_result_add),           // output m_axis_result_tvalid
        .m_axis_result_tdata(result_add)                    // output [31 : 0] m_axis_result_tdata
    );
    
    floating_point_div div (
        .aclk(clk),                                 // input aclk
        .s_axis_a_tvalid(tvalid_result_add),        // input s_axis_a_tvalid
        .s_axis_a_tready(),                         // output s_axis_a_tready
        .s_axis_a_tdata(result_add),                // input [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(tvalid_result_add),        // input s_axis_b_tvalid
        .s_axis_b_tready(),                         // output s_axis_b_tready
        .s_axis_b_tdata(CONST_10),                  // input [31 : 0] s_axis_b_tdata (float = 10.0)
        .m_axis_result_tvalid(tvalid_result_div),   // output m_axis_result_tvalid
        .m_axis_result_tdata(result_div)            // output [31 : 0] m_axis_result_tdata
    );
    
    assign tvalid_d1_mfcc   = tvalid_result_div;
    assign d1_mfcc          = result_div;

endmodule
