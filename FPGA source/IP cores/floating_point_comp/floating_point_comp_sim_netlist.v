// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Tue Jun 08 14:44:36 2021
// Host        : B51-314-TS-W1 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Library_Projects_FPGA/Jav_VA_old/UDACHA_V_CODER_v3/prj/project_1.srcs/sources_1/ip/floating_point_comp/floating_point_comp_sim_netlist.v
// Design      : floating_point_comp
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "floating_point_comp,floating_point_v7_1_2,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "floating_point_v7_1_2,Vivado 2016.2" *) 
(* NotValidForBitStream *)
module floating_point_comp
   (aclk,
    s_axis_a_tvalid,
    s_axis_a_tready,
    s_axis_a_tdata,
    s_axis_b_tvalid,
    s_axis_b_tready,
    s_axis_b_tdata,
    m_axis_result_tvalid,
    m_axis_result_tdata);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk_intf CLK" *) input aclk;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_A TVALID" *) input s_axis_a_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_A TREADY" *) output s_axis_a_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_A TDATA" *) input [31:0]s_axis_a_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_B TVALID" *) input s_axis_b_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_B TREADY" *) output s_axis_b_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_B TDATA" *) input [31:0]s_axis_b_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT TVALID" *) output m_axis_result_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT TDATA" *) output [7:0]m_axis_result_tdata;

  wire aclk;
  wire [7:0]m_axis_result_tdata;
  wire m_axis_result_tvalid;
  wire [31:0]s_axis_a_tdata;
  wire s_axis_a_tready;
  wire s_axis_a_tvalid;
  wire [31:0]s_axis_b_tdata;
  wire s_axis_b_tready;
  wire s_axis_b_tvalid;
  wire NLW_U0_m_axis_result_tlast_UNCONNECTED;
  wire NLW_U0_s_axis_c_tready_UNCONNECTED;
  wire NLW_U0_s_axis_operation_tready_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_result_tuser_UNCONNECTED;

  (* C_ACCUM_INPUT_MSB = "32" *) 
  (* C_ACCUM_LSB = "-31" *) 
  (* C_ACCUM_MSB = "32" *) 
  (* C_A_FRACTION_WIDTH = "24" *) 
  (* C_A_TDATA_WIDTH = "32" *) 
  (* C_A_TUSER_WIDTH = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_BRAM_USAGE = "0" *) 
  (* C_B_FRACTION_WIDTH = "24" *) 
  (* C_B_TDATA_WIDTH = "32" *) 
  (* C_B_TUSER_WIDTH = "1" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_COMPARE_OPERATION = "4" *) 
  (* C_C_FRACTION_WIDTH = "24" *) 
  (* C_C_TDATA_WIDTH = "32" *) 
  (* C_C_TUSER_WIDTH = "1" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_FIXED_DATA_UNSIGNED = "0" *) 
  (* C_HAS_ABSOLUTE = "0" *) 
  (* C_HAS_ACCUMULATOR_A = "0" *) 
  (* C_HAS_ACCUMULATOR_S = "0" *) 
  (* C_HAS_ACCUM_INPUT_OVERFLOW = "0" *) 
  (* C_HAS_ACCUM_OVERFLOW = "0" *) 
  (* C_HAS_ACLKEN = "0" *) 
  (* C_HAS_ADD = "0" *) 
  (* C_HAS_ARESETN = "0" *) 
  (* C_HAS_A_TLAST = "0" *) 
  (* C_HAS_A_TUSER = "0" *) 
  (* C_HAS_B = "1" *) 
  (* C_HAS_B_TLAST = "0" *) 
  (* C_HAS_B_TUSER = "0" *) 
  (* C_HAS_C = "0" *) 
  (* C_HAS_COMPARE = "1" *) 
  (* C_HAS_C_TLAST = "0" *) 
  (* C_HAS_C_TUSER = "0" *) 
  (* C_HAS_DIVIDE = "0" *) 
  (* C_HAS_DIVIDE_BY_ZERO = "0" *) 
  (* C_HAS_EXPONENTIAL = "0" *) 
  (* C_HAS_FIX_TO_FLT = "0" *) 
  (* C_HAS_FLT_TO_FIX = "0" *) 
  (* C_HAS_FLT_TO_FLT = "0" *) 
  (* C_HAS_FMA = "0" *) 
  (* C_HAS_FMS = "0" *) 
  (* C_HAS_INVALID_OP = "0" *) 
  (* C_HAS_LOGARITHM = "0" *) 
  (* C_HAS_MULTIPLY = "0" *) 
  (* C_HAS_OPERATION = "0" *) 
  (* C_HAS_OPERATION_TLAST = "0" *) 
  (* C_HAS_OPERATION_TUSER = "0" *) 
  (* C_HAS_OVERFLOW = "0" *) 
  (* C_HAS_RECIP = "0" *) 
  (* C_HAS_RECIP_SQRT = "0" *) 
  (* C_HAS_RESULT_TLAST = "0" *) 
  (* C_HAS_RESULT_TUSER = "0" *) 
  (* C_HAS_SQRT = "0" *) 
  (* C_HAS_SUBTRACT = "0" *) 
  (* C_HAS_UNDERFLOW = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MULT_USAGE = "0" *) 
  (* C_OPERATION_TDATA_WIDTH = "8" *) 
  (* C_OPERATION_TUSER_WIDTH = "1" *) 
  (* C_OPTIMIZATION = "1" *) 
  (* C_RATE = "1" *) 
  (* C_RESULT_FRACTION_WIDTH = "0" *) 
  (* C_RESULT_TDATA_WIDTH = "8" *) 
  (* C_RESULT_TUSER_WIDTH = "1" *) 
  (* C_RESULT_WIDTH = "1" *) 
  (* C_THROTTLE_SCHEME = "4" *) 
  (* C_TLAST_RESOLUTION = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* KEEP_HIERARCHY = "true" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  floating_point_comp_floating_point_v7_1_2 U0
       (.aclk(aclk),
        .aclken(1'b1),
        .aresetn(1'b1),
        .m_axis_result_tdata(m_axis_result_tdata),
        .m_axis_result_tlast(NLW_U0_m_axis_result_tlast_UNCONNECTED),
        .m_axis_result_tready(1'b0),
        .m_axis_result_tuser(NLW_U0_m_axis_result_tuser_UNCONNECTED[0]),
        .m_axis_result_tvalid(m_axis_result_tvalid),
        .s_axis_a_tdata(s_axis_a_tdata),
        .s_axis_a_tlast(1'b0),
        .s_axis_a_tready(s_axis_a_tready),
        .s_axis_a_tuser(1'b0),
        .s_axis_a_tvalid(s_axis_a_tvalid),
        .s_axis_b_tdata(s_axis_b_tdata),
        .s_axis_b_tlast(1'b0),
        .s_axis_b_tready(s_axis_b_tready),
        .s_axis_b_tuser(1'b0),
        .s_axis_b_tvalid(s_axis_b_tvalid),
        .s_axis_c_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_c_tlast(1'b0),
        .s_axis_c_tready(NLW_U0_s_axis_c_tready_UNCONNECTED),
        .s_axis_c_tuser(1'b0),
        .s_axis_c_tvalid(1'b0),
        .s_axis_operation_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_operation_tlast(1'b0),
        .s_axis_operation_tready(NLW_U0_s_axis_operation_tready_UNCONNECTED),
        .s_axis_operation_tuser(1'b0),
        .s_axis_operation_tvalid(1'b0));
endmodule

(* C_ACCUM_INPUT_MSB = "32" *) (* C_ACCUM_LSB = "-31" *) (* C_ACCUM_MSB = "32" *) 
(* C_A_FRACTION_WIDTH = "24" *) (* C_A_TDATA_WIDTH = "32" *) (* C_A_TUSER_WIDTH = "1" *) 
(* C_A_WIDTH = "32" *) (* C_BRAM_USAGE = "0" *) (* C_B_FRACTION_WIDTH = "24" *) 
(* C_B_TDATA_WIDTH = "32" *) (* C_B_TUSER_WIDTH = "1" *) (* C_B_WIDTH = "32" *) 
(* C_COMPARE_OPERATION = "4" *) (* C_C_FRACTION_WIDTH = "24" *) (* C_C_TDATA_WIDTH = "32" *) 
(* C_C_TUSER_WIDTH = "1" *) (* C_C_WIDTH = "32" *) (* C_FIXED_DATA_UNSIGNED = "0" *) 
(* C_HAS_ABSOLUTE = "0" *) (* C_HAS_ACCUMULATOR_A = "0" *) (* C_HAS_ACCUMULATOR_S = "0" *) 
(* C_HAS_ACCUM_INPUT_OVERFLOW = "0" *) (* C_HAS_ACCUM_OVERFLOW = "0" *) (* C_HAS_ACLKEN = "0" *) 
(* C_HAS_ADD = "0" *) (* C_HAS_ARESETN = "0" *) (* C_HAS_A_TLAST = "0" *) 
(* C_HAS_A_TUSER = "0" *) (* C_HAS_B = "1" *) (* C_HAS_B_TLAST = "0" *) 
(* C_HAS_B_TUSER = "0" *) (* C_HAS_C = "0" *) (* C_HAS_COMPARE = "1" *) 
(* C_HAS_C_TLAST = "0" *) (* C_HAS_C_TUSER = "0" *) (* C_HAS_DIVIDE = "0" *) 
(* C_HAS_DIVIDE_BY_ZERO = "0" *) (* C_HAS_EXPONENTIAL = "0" *) (* C_HAS_FIX_TO_FLT = "0" *) 
(* C_HAS_FLT_TO_FIX = "0" *) (* C_HAS_FLT_TO_FLT = "0" *) (* C_HAS_FMA = "0" *) 
(* C_HAS_FMS = "0" *) (* C_HAS_INVALID_OP = "0" *) (* C_HAS_LOGARITHM = "0" *) 
(* C_HAS_MULTIPLY = "0" *) (* C_HAS_OPERATION = "0" *) (* C_HAS_OPERATION_TLAST = "0" *) 
(* C_HAS_OPERATION_TUSER = "0" *) (* C_HAS_OVERFLOW = "0" *) (* C_HAS_RECIP = "0" *) 
(* C_HAS_RECIP_SQRT = "0" *) (* C_HAS_RESULT_TLAST = "0" *) (* C_HAS_RESULT_TUSER = "0" *) 
(* C_HAS_SQRT = "0" *) (* C_HAS_SUBTRACT = "0" *) (* C_HAS_UNDERFLOW = "0" *) 
(* C_LATENCY = "1" *) (* C_MULT_USAGE = "0" *) (* C_OPERATION_TDATA_WIDTH = "8" *) 
(* C_OPERATION_TUSER_WIDTH = "1" *) (* C_OPTIMIZATION = "1" *) (* C_RATE = "1" *) 
(* C_RESULT_FRACTION_WIDTH = "0" *) (* C_RESULT_TDATA_WIDTH = "8" *) (* C_RESULT_TUSER_WIDTH = "1" *) 
(* C_RESULT_WIDTH = "1" *) (* C_THROTTLE_SCHEME = "4" *) (* C_TLAST_RESOLUTION = "0" *) 
(* C_XDEVICEFAMILY = "kintex7" *) (* ORIG_REF_NAME = "floating_point_v7_1_2" *) (* downgradeipidentifiedwarnings = "yes" *) 
module floating_point_comp_floating_point_v7_1_2
   (aclk,
    aclken,
    aresetn,
    s_axis_a_tvalid,
    s_axis_a_tready,
    s_axis_a_tdata,
    s_axis_a_tuser,
    s_axis_a_tlast,
    s_axis_b_tvalid,
    s_axis_b_tready,
    s_axis_b_tdata,
    s_axis_b_tuser,
    s_axis_b_tlast,
    s_axis_c_tvalid,
    s_axis_c_tready,
    s_axis_c_tdata,
    s_axis_c_tuser,
    s_axis_c_tlast,
    s_axis_operation_tvalid,
    s_axis_operation_tready,
    s_axis_operation_tdata,
    s_axis_operation_tuser,
    s_axis_operation_tlast,
    m_axis_result_tvalid,
    m_axis_result_tready,
    m_axis_result_tdata,
    m_axis_result_tuser,
    m_axis_result_tlast);
  input aclk;
  input aclken;
  input aresetn;
  input s_axis_a_tvalid;
  output s_axis_a_tready;
  input [31:0]s_axis_a_tdata;
  input [0:0]s_axis_a_tuser;
  input s_axis_a_tlast;
  input s_axis_b_tvalid;
  output s_axis_b_tready;
  input [31:0]s_axis_b_tdata;
  input [0:0]s_axis_b_tuser;
  input s_axis_b_tlast;
  input s_axis_c_tvalid;
  output s_axis_c_tready;
  input [31:0]s_axis_c_tdata;
  input [0:0]s_axis_c_tuser;
  input s_axis_c_tlast;
  input s_axis_operation_tvalid;
  output s_axis_operation_tready;
  input [7:0]s_axis_operation_tdata;
  input [0:0]s_axis_operation_tuser;
  input s_axis_operation_tlast;
  output m_axis_result_tvalid;
  input m_axis_result_tready;
  output [7:0]m_axis_result_tdata;
  output [0:0]m_axis_result_tuser;
  output m_axis_result_tlast;

  wire aclk;
  wire aclken;
  wire aresetn;
  wire [7:0]m_axis_result_tdata;
  wire m_axis_result_tlast;
  wire m_axis_result_tready;
  wire [0:0]m_axis_result_tuser;
  wire m_axis_result_tvalid;
  wire [31:0]s_axis_a_tdata;
  wire s_axis_a_tlast;
  wire s_axis_a_tready;
  wire [0:0]s_axis_a_tuser;
  wire s_axis_a_tvalid;
  wire [31:0]s_axis_b_tdata;
  wire s_axis_b_tlast;
  wire s_axis_b_tready;
  wire [0:0]s_axis_b_tuser;
  wire s_axis_b_tvalid;
  wire [31:0]s_axis_c_tdata;
  wire s_axis_c_tlast;
  wire s_axis_c_tready;
  wire [0:0]s_axis_c_tuser;
  wire s_axis_c_tvalid;
  wire [7:0]s_axis_operation_tdata;
  wire s_axis_operation_tlast;
  wire s_axis_operation_tready;
  wire [0:0]s_axis_operation_tuser;
  wire s_axis_operation_tvalid;

  (* C_ACCUM_INPUT_MSB = "32" *) 
  (* C_ACCUM_LSB = "-31" *) 
  (* C_ACCUM_MSB = "32" *) 
  (* C_A_FRACTION_WIDTH = "24" *) 
  (* C_A_TDATA_WIDTH = "32" *) 
  (* C_A_TUSER_WIDTH = "1" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_BRAM_USAGE = "0" *) 
  (* C_B_FRACTION_WIDTH = "24" *) 
  (* C_B_TDATA_WIDTH = "32" *) 
  (* C_B_TUSER_WIDTH = "1" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_COMPARE_OPERATION = "4" *) 
  (* C_C_FRACTION_WIDTH = "24" *) 
  (* C_C_TDATA_WIDTH = "32" *) 
  (* C_C_TUSER_WIDTH = "1" *) 
  (* C_C_WIDTH = "32" *) 
  (* C_FIXED_DATA_UNSIGNED = "0" *) 
  (* C_HAS_ABSOLUTE = "0" *) 
  (* C_HAS_ACCUMULATOR_A = "0" *) 
  (* C_HAS_ACCUMULATOR_S = "0" *) 
  (* C_HAS_ACCUM_INPUT_OVERFLOW = "0" *) 
  (* C_HAS_ACCUM_OVERFLOW = "0" *) 
  (* C_HAS_ACLKEN = "0" *) 
  (* C_HAS_ADD = "0" *) 
  (* C_HAS_ARESETN = "0" *) 
  (* C_HAS_A_TLAST = "0" *) 
  (* C_HAS_A_TUSER = "0" *) 
  (* C_HAS_B = "1" *) 
  (* C_HAS_B_TLAST = "0" *) 
  (* C_HAS_B_TUSER = "0" *) 
  (* C_HAS_C = "0" *) 
  (* C_HAS_COMPARE = "1" *) 
  (* C_HAS_C_TLAST = "0" *) 
  (* C_HAS_C_TUSER = "0" *) 
  (* C_HAS_DIVIDE = "0" *) 
  (* C_HAS_DIVIDE_BY_ZERO = "0" *) 
  (* C_HAS_EXPONENTIAL = "0" *) 
  (* C_HAS_FIX_TO_FLT = "0" *) 
  (* C_HAS_FLT_TO_FIX = "0" *) 
  (* C_HAS_FLT_TO_FLT = "0" *) 
  (* C_HAS_FMA = "0" *) 
  (* C_HAS_FMS = "0" *) 
  (* C_HAS_INVALID_OP = "0" *) 
  (* C_HAS_LOGARITHM = "0" *) 
  (* C_HAS_MULTIPLY = "0" *) 
  (* C_HAS_OPERATION = "0" *) 
  (* C_HAS_OPERATION_TLAST = "0" *) 
  (* C_HAS_OPERATION_TUSER = "0" *) 
  (* C_HAS_OVERFLOW = "0" *) 
  (* C_HAS_RECIP = "0" *) 
  (* C_HAS_RECIP_SQRT = "0" *) 
  (* C_HAS_RESULT_TLAST = "0" *) 
  (* C_HAS_RESULT_TUSER = "0" *) 
  (* C_HAS_SQRT = "0" *) 
  (* C_HAS_SUBTRACT = "0" *) 
  (* C_HAS_UNDERFLOW = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MULT_USAGE = "0" *) 
  (* C_OPERATION_TDATA_WIDTH = "8" *) 
  (* C_OPERATION_TUSER_WIDTH = "1" *) 
  (* C_OPTIMIZATION = "1" *) 
  (* C_RATE = "1" *) 
  (* C_RESULT_FRACTION_WIDTH = "0" *) 
  (* C_RESULT_TDATA_WIDTH = "8" *) 
  (* C_RESULT_TUSER_WIDTH = "1" *) 
  (* C_RESULT_WIDTH = "1" *) 
  (* C_THROTTLE_SCHEME = "4" *) 
  (* C_TLAST_RESOLUTION = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  floating_point_comp_floating_point_v7_1_2_viv i_synth
       (.aclk(aclk),
        .aclken(aclken),
        .aresetn(aresetn),
        .m_axis_result_tdata(m_axis_result_tdata),
        .m_axis_result_tlast(m_axis_result_tlast),
        .m_axis_result_tready(m_axis_result_tready),
        .m_axis_result_tuser(m_axis_result_tuser),
        .m_axis_result_tvalid(m_axis_result_tvalid),
        .s_axis_a_tdata(s_axis_a_tdata),
        .s_axis_a_tlast(s_axis_a_tlast),
        .s_axis_a_tready(s_axis_a_tready),
        .s_axis_a_tuser(s_axis_a_tuser),
        .s_axis_a_tvalid(s_axis_a_tvalid),
        .s_axis_b_tdata(s_axis_b_tdata),
        .s_axis_b_tlast(s_axis_b_tlast),
        .s_axis_b_tready(s_axis_b_tready),
        .s_axis_b_tuser(s_axis_b_tuser),
        .s_axis_b_tvalid(s_axis_b_tvalid),
        .s_axis_c_tdata(s_axis_c_tdata),
        .s_axis_c_tlast(s_axis_c_tlast),
        .s_axis_c_tready(s_axis_c_tready),
        .s_axis_c_tuser(s_axis_c_tuser),
        .s_axis_c_tvalid(s_axis_c_tvalid),
        .s_axis_operation_tdata(s_axis_operation_tdata),
        .s_axis_operation_tlast(s_axis_operation_tlast),
        .s_axis_operation_tready(s_axis_operation_tready),
        .s_axis_operation_tuser(s_axis_operation_tuser),
        .s_axis_operation_tvalid(s_axis_operation_tvalid));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
VbV3K+no6bnPIa+zTPjJm+Za4h+e+mAdgfsol9fh12i5ry1s/9jFxbKNRkpLXaPaKwPx6tUXx2dM
rz7eLZ9g0Q==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
kTHC1aaUWUk/RMP8ryE9Otenia3ejjUZ515o8MyC5LPe9Q9HU4j6bokGKsgb9UOn6jCH1yruRDSs
b5lYfhLsxwdG5/eDjBvnNCSnM0RpZJbFrI7JmsFggBcbNUey9IsoQpsnxotoGgl++yh2M6dZZxeh
M1HjDezNtQIQF/ZYUx8=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
snOGGdaAqd0xCCnl9qpy1A393jt9hiIkPmkASlieApKF1LOzirx0ZtNLBlVn/2B/+8mCYjHiacYR
yXR79FQlFUsb7jR6ke5jpzqLDYHrXjsSYlP6XweX9Iba7CTKn3lrruzWWFzPkW4aciBjkat8zMl+
9yQhqwSY0mgGYoE6xIU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
VQtZeHq0wwSVd11a6wGUrcsL8nkp++GpoEJBF7q/cJp1a5TPQvxpDAKpIvxahkyYavXQtD2H32nS
gwb37S5yvNwWpKhcI75qsKCgrHwPz0e58zT8OT1nTnN4wbF1FEBlXqVhaSTCc+ruoYfFgLOvq8Vv
3UIMxyu4DNPhA3cgj0i5I/Qu4n9bb5ARKmILDDDRdJH79iOGyfSi4jSRGCnPG4R2jh+afwgHnGWt
mNPbEs6smG2ApIULJcWURoCv+u4G6+NuD3qACnBJrJOsa24eMAMLstL4ATkGasikUUNzIj2pEJk9
8hRULYLSgD4dit5Jx+Lh3eUe3LnJ8JB9XVtoZw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
aCN2iFOrSMMrFBC1bx0+qYoAW1mWivPbraxjFsh9goPWGNSJROEmbdaUCrQw+sK5IYVwzj76ptqV
hsAbNcAaqw5xKu9/s0kIvO/tlRqx54JykJuHqpzdnuBilOYKpjmnbgm9GNfp/+2BtOw2C5F+WfKd
t/aWE78rilJxgDDpFvROYhHeArroRiPDpH4FEpMDsabE/eDN1VYxJ197aihMGaAb8fIZX+lksOX8
SFmUPSICS6CVQ6P8licCLIY/CEHAngVTpNVAiFE+py2fimPTacxjGEoMWvWoZ1i6T6AQTrYMMz+R
1X4TRxNWtAN+GlPoa5SiOGwGxNi7ipB7xDxwaw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qrTdR5jHfRKLAYgifBWWG6p4Z4xOoCaPlTZeSph/qlRBY+GOLFZqse0DC500mzihUvVh9uqSL0sf
QqIVIKXtc/vmkLTVkrTjVWF//xVSppNyDBiDklq4+hMBQ1FTa5kt+FmZnTAwglWAnFB9je3STA7g
1vEddZZb+4GvMNQLT8fmcEvlxiOCwHGS3w1CmsJDrgnj3mXpIWYgCYJussuOzZYHKflNfTUDZBPe
cnCqgDCFeSfQaV9rV08HR3U+NRSxKPM+ou7WhrHfBIPk4L59Sk5mI6TtkBzh+VX6GcvtZsnUqyUJ
yQju1UjuKFN4rX8QdS8sgdKQohC4pjYIVuoz0A==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
bcgTd7FjS7LNPCXVDLAlknXvZ95ZFOpeactDm4/j5tzg7dr8dWsBu4tdM9AKsNHEAHaNwDudtYXn
LtodiNn4uMbKnnwT2u4It7cbgnt8CUlKr2Ew17Qyf9N8UcX6G1QfFeJunUX6WZ3smih1SB2oppv8
odsBTlgvmd04AtRo2mSnZJqtQqkkUYBs5BpfT832pCh2t5o2lPF0n4n/f8+TwCKAH9v8czXFMDlJ
X5tlMlis/Wg09XZADOc+VuJCA6bfApMCD/AT/VycGz4fZBTDwJYGTfCSd9yqhDyQTuffykdBtBuC
p30pMfWgA1Y8qXf4Azsz3NAqIcQMvRRhqpZmWg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
fkaqneEB7yV/9zC5an5InPzAy+qMUL/Pz9PjH1+VZFr1UFwHsl4/4vbW9LBI4UCe74lz3yHIdGxK
XJ8YFih0rywMAXCWABwYQBCN4np1f2ZWxgHgNgYjv+d1ZsWG1E2of2kCLr35NWO7XMvdvjRv5kUj
679PUqvdt49SYj5zWFPT1u3ajOgaOUpuzgcQVKpmqgwCqmEuOy7BlRICUZObWDVpXZEMy7pHXxls
YtybTg8TWBtHRdffpWw9TLJEm1vF334e1IeIC5nT+/x3kffsCB+N8RBBwMMJIOs4AOewp9Jb0WTY
M41QWKMxyR5wFxArarhecXkIDLoJnE4Chv5b3Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64112)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
