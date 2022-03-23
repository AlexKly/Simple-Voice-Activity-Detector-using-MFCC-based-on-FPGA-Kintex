// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Mon Mar 14 17:30:42 2022
// Host        : B51-314-TS-W1 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Library_Projects_FPGA/Jav_VA_old/UDACHA_V_CODER_v3/prj/project_1.srcs/sources_1/ip/DNN_0/DNN_0_stub.v
// Design      : DNN_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "DNN,Vivado 2016.2" *)
module DNN_0(mfcc_ce0, ap_clk, ap_rst, ap_start, ap_done, ap_idle, ap_ready, ap_return, mfcc_address0, mfcc_q0)
/* synthesis syn_black_box black_box_pad_pin="mfcc_ce0,ap_clk,ap_rst,ap_start,ap_done,ap_idle,ap_ready,ap_return[31:0],mfcc_address0[5:0],mfcc_q0[31:0]" */;
  output mfcc_ce0;
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  output [31:0]ap_return;
  output [5:0]mfcc_address0;
  input [31:0]mfcc_q0;
endmodule
