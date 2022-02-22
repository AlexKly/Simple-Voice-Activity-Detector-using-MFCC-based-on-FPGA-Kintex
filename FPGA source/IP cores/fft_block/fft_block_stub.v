// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Thu Mar 18 14:13:13 2021
// Host        : DESKTOP-NK5VDT5 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/Library_Projects_FPGA/Jav_VA_old/UDACHA_V_CODER_v3/prj/project_1.srcs/sources_1/ip/fft_block/fft_block_stub.v
// Design      : fft_block
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xfft_v9_0_10,Vivado 2016.2" *)
module fft_block(aclk, s_axis_config_tdata, s_axis_config_tvalid, s_axis_config_tready, s_axis_data_tdata, s_axis_data_tvalid, s_axis_data_tready, s_axis_data_tlast, m_axis_data_tdata, m_axis_data_tvalid, m_axis_data_tlast, event_frame_started, event_tlast_unexpected, event_tlast_missing, event_data_in_channel_halt)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_config_tdata[15:0],s_axis_config_tvalid,s_axis_config_tready,s_axis_data_tdata[63:0],s_axis_data_tvalid,s_axis_data_tready,s_axis_data_tlast,m_axis_data_tdata[63:0],m_axis_data_tvalid,m_axis_data_tlast,event_frame_started,event_tlast_unexpected,event_tlast_missing,event_data_in_channel_halt" */;
  input aclk;
  input [15:0]s_axis_config_tdata;
  input s_axis_config_tvalid;
  output s_axis_config_tready;
  input [63:0]s_axis_data_tdata;
  input s_axis_data_tvalid;
  output s_axis_data_tready;
  input s_axis_data_tlast;
  output [63:0]m_axis_data_tdata;
  output m_axis_data_tvalid;
  output m_axis_data_tlast;
  output event_frame_started;
  output event_tlast_unexpected;
  output event_tlast_missing;
  output event_data_in_channel_halt;
endmodule
