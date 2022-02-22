// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Wed May 26 12:43:50 2021
// Host        : B51-314-TS-W1 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Library_Projects_FPGA/Jav_VA_old/UDACHA_V_CODER_v3/prj/project_1.srcs/sources_1/ip/ila_Vega_subModule/ila_Vega_subModule_stub.v
// Design      : ila_Vega_subModule
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "ila,Vivado 2016.2" *)
module ila_Vega_subModule(clk, probe0, probe1, probe2, probe3, probe4)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[0:0],probe1[0:0],probe2[0:0],probe3[0:0],probe4[15:0]" */;
  input clk;
  input [0:0]probe0;
  input [0:0]probe1;
  input [0:0]probe2;
  input [0:0]probe3;
  input [15:0]probe4;
endmodule
