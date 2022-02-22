`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.12.2020 09:32:45
// Design Name: 
// Module Name: appendEnergy
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


module appendEnergy(
    input clk,
    input rst,
    
    input tvalid_mfcc_feat,
    input [31:0] mfcc_feat,
    
    input tvalid_log_energy,
    input [31:0] log_energy,
    
    output reg tready_mfcc_appened_energy,
    output reg [31:0] mfcc_appened_energy
    );
    
    localparam IDLE = 0;
    localparam WAIT_MFCC_FEAT = 1;
    localparam WAIT_LOG_ENERGY = 2;
    localparam DONE = 3;
    
    reg [1:0] st_main = IDLE;
    
    reg [31:0] mfcc_feat_reg [0:12];
    reg [3:0] ind = 0;
    reg [7:0] wait_reset = 0;
    
    reg flag_log_energy = 1'b0;
    
    reg flag_end_state = 1'b0;
    
    reg past_front;
    
    always@ (posedge clk) begin
    
        if (wait_reset < 255) begin
            wait_reset <= wait_reset + 1;
        end
    
        if (rst) begin
            st_main <= IDLE;
        end
        else begin
            st_main <= st_main;
        end
    
        case (st_main)
            IDLE: begin
                if (wait_reset == 255) begin
                    st_main <= WAIT_MFCC_FEAT;
                end
                
                mfcc_feat_reg[0] <= 32'h00000000;
                mfcc_feat_reg[1] <= 32'h00000000;
                mfcc_feat_reg[2] <= 32'h00000000;
                mfcc_feat_reg[3] <= 32'h00000000;
                mfcc_feat_reg[4] <= 32'h00000000;
                mfcc_feat_reg[5] <= 32'h00000000;
                mfcc_feat_reg[6] <= 32'h00000000;
                mfcc_feat_reg[7] <= 32'h00000000;
                mfcc_feat_reg[8] <= 32'h00000000;
                mfcc_feat_reg[9] <= 32'h00000000;
                mfcc_feat_reg[10] <= 32'h00000000;
                mfcc_feat_reg[11] <= 32'h00000000;
                mfcc_feat_reg[12] <= 32'h00000000;
                
                tready_mfcc_appened_energy <= 1'b0;
                mfcc_appened_energy <= 32'h00000000;
                
                ind <= 0;
            end
            
            WAIT_MFCC_FEAT: begin
                if (tvalid_mfcc_feat) begin
                    mfcc_feat_reg[ind] <= mfcc_feat;
                    ind <= ind + 1;
                end
                
                if (ind == 13) begin
                    st_main <= WAIT_LOG_ENERGY;
                    ind = 0;
                end
            end
            
            WAIT_LOG_ENERGY: begin
                if (flag_log_energy) begin
                    mfcc_feat_reg[0] <= log_energy;
                    flag_end_state <= 1'b1;
                end
                
                if (flag_end_state) begin
                    st_main <= DONE;
                    flag_end_state <= 1'b0;
                end
            end
                            
            DONE: begin
                if (ind < 13) begin
                    tready_mfcc_appened_energy <= 1'b1;
                    mfcc_appened_energy <= mfcc_feat_reg[ind];
                
                    ind <= ind + 1;
                end
                else begin
                    st_main <= WAIT_MFCC_FEAT;
                    
                    tready_mfcc_appened_energy <= 1'b0;
                    mfcc_appened_energy <= 32'h00000000;
                    
                    ind <= 0;
                end
            end
        endcase
    end
    
    always@ (posedge clk) begin
        past_front <= tvalid_log_energy;
        if (tvalid_log_energy & !past_front) begin
            flag_log_energy <= 1'b1;
        end
        else begin
            flag_log_energy <= 1'b0;
        end
    end
    
endmodule
