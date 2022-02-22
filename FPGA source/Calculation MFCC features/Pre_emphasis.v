`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 15:15:03
// Design Name: 
// Module Name: Pre_emphasis
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


module Pre_emphasis(
    input clk,
    
    input tvalid_input_stream,
    input [31:0] input_stream,
    
    output tvalid_filtered_stream,
    output [31:0] filtered_stream
    );
    
    localparam [31:0] alpha_const   = 32'hbf733333;   // y(t) = x(t) - ax(t-1)
    
    // y(t) = x(t) - ax(t-1):
    
    // x(t-1):
    reg tvalid_delayed_sample = 1'b0;
    reg [31:0] delayed_sample = 32'b0;
    
    // ax(t-1):
    wire tvalid_res_mult;
    wire [31:0] res_mult;
     
    // x(t-1)
    always@ (posedge clk) begin
        tvalid_delayed_sample   <= tvalid_input_stream;
        delayed_sample          <= input_stream;
    end
    
    // ax(t-1):
    floating_point_mult multiplier (
        .aclk(clk),
        .s_axis_a_tvalid(tvalid_delayed_sample),
        .s_axis_a_tready(),
        .s_axis_a_tdata(delayed_sample),
        .s_axis_b_tvalid(tvalid_delayed_sample),
        .s_axis_b_tready(),
        .s_axis_b_tdata(alpha_const),
        .m_axis_result_tvalid(tvalid_res_mult),
        .m_axis_result_tdata(res_mult)
    );
    
    // x(t) - ax(t-1):
    floating_point_add adder (
        .aclk(clk),
        .s_axis_a_tvalid(tvalid_input_stream),
        .s_axis_a_tready(),
        .s_axis_a_tdata(input_stream),
        .s_axis_b_tvalid(tvalid_res_mult),
        .s_axis_b_tready(),
        .s_axis_b_tdata(res_mult),
        .m_axis_result_tvalid(tvalid_filtered_stream),
        .m_axis_result_tdata(filtered_stream)
    );
 
endmodule
