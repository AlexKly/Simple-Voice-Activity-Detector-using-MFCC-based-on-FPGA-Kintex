`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2020 13:36:51
// Design Name: 
// Module Name: energy
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


module energy(
    input clk,
    input reset,
    
    input tvalid_powspectr,
    input [31:0] powspectr,
    
    output tready_log_energy,
    output [31:0] log_energy
    );
    
	localparam [9:0] FRAME_LENGTH   = 512;
	localparam [31:0] LOG_INIT      = 32'h3f800000;
    localparam [31:0] FLOAT_EPS     = 32'h25800000;
    
    localparam [1:0] WAIT_FRAME     = 0;
    localparam [1:0] CALC_ENERGY    = 1;
    localparam [1:0] CALC_LOG       = 2;
    localparam [1:0] RESET_LOGIC    = 3;
    
    reg [1:0] frame_energy_fsm_st = RESET_LOGIC;
    
    reg [9:0] cnt_samples = 0;
      
    // Control adder:
    reg reset_adder = 1'b0;    // Active high
    
    // Result sum:
    wire tvalid_result_sum;
    wire [31:0] result_sum;
    
    reg  [31:0] energy_frame_tmp = 32'b0;
    
    // Result log:
    wire tvalid_result_log;
    wire [31:0] result_log;
    
    // Inputs to adder:
    reg tvalid_op_add           = 1'b0;
    reg [31:0] first_param      = 32'b0;
    wire [31:0] second_param    = !reset_adder ? result_sum : 32'b0;
    
    // Inputs to log:
    reg tvalid_log_input = 1'b1;
    reg [31:0] log_input = LOG_INIT;
    
    // Blocking:
    floating_point_add adder_frame_energy (
        .aclk(clk), // input aclk
        .s_axis_a_tvalid(tvalid_op_add), // input s_axis_a_tvalid
        .s_axis_a_tready(), // output s_axis_a_tready
        .s_axis_a_tdata(first_param), // input [31 : 0] s_axis_a_tdata
        .s_axis_b_tvalid(tvalid_op_add), // input s_axis_b_tvalid
        .s_axis_b_tready(), // output s_axis_b_tready
        .s_axis_b_tdata(second_param), // input [31 : 0] s_axis_b_tdata
        .m_axis_result_tvalid(tvalid_result_sum), // output m_axis_result_tvalid
        .m_axis_result_tdata(result_sum) // output [31 : 0] m_axis_result_tdata
    );
    
    // Blocking:
    floating_point_log log_frame_energy (
        .aclk(clk), // input aclk
        .s_axis_a_tvalid(tvalid_log_input), // input s_axis_a_tvalid
        .s_axis_a_tready(), // output s_axis_a_tready
        .s_axis_a_tdata(log_input), // input [31 : 0] s_axis_a_tdata
        .m_axis_result_tvalid(tvalid_result_log), // output m_axis_result_tvalid
        .m_axis_result_tdata(result_log) // output [31 : 0] m_axis_result_tdata
    );
    
    always@ (posedge clk) begin
        case (frame_energy_fsm_st)
            WAIT_FRAME: begin
                reset_adder <= 1'b0;
            
                if (tvalid_powspectr && !reset) begin
                    tvalid_op_add   <= tvalid_powspectr;
                    first_param     <= powspectr;
                    
                    frame_energy_fsm_st <= CALC_ENERGY;
                end
                else begin
                    tvalid_op_add   <= 1'b0;
                    first_param     <= 32'b0;
                end
            end
            
            CALC_ENERGY: begin
                if (reset) begin
                    frame_energy_fsm_st <= RESET_LOGIC;
                end
                else begin
                    cnt_samples <= cnt_samples + 1;
                    if (cnt_samples == FRAME_LENGTH) begin
                        cnt_samples <= 0;
                    
                        tvalid_op_add   <= 1'b0;
                        first_param     <= 32'b0;
                    
                        if (result_sum == 32'b0) begin
                            energy_frame_tmp <= FLOAT_EPS;
                        end
                        else begin
                            energy_frame_tmp <= result_sum;
                        end
                    
                        frame_energy_fsm_st <= CALC_LOG;
                    end
                    else begin
                        tvalid_op_add   <= tvalid_powspectr;
                        first_param     <= powspectr;
                    end
                end
            end
            
            CALC_LOG: begin
                // Enable to Log():
                tvalid_log_input    <= 1'b1;
                log_input           <= energy_frame_tmp;
                
                frame_energy_fsm_st <= RESET_LOGIC;
            end
            
            RESET_LOGIC: begin
                // Need try to reset LOG (WTF with NAN value?????)
                cnt_samples     <= 0;
                reset_adder     <= 1'b1;
                tvalid_op_add   <= 1'b1;
                
                tvalid_log_input    <= 1'b0;
                log_input           <= LOG_INIT;
                
                energy_frame_tmp <= FLOAT_EPS;
                
                frame_energy_fsm_st <= WAIT_FRAME;
            end
        endcase
    end
    
    assign tready_log_energy    = tvalid_result_log;
    assign log_energy           = result_log;

endmodule
