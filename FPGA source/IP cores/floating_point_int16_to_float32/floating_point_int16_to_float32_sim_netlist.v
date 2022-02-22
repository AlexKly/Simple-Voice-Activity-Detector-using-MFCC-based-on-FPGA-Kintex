// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Mon Mar 15 15:08:10 2021
// Host        : DESKTOP-NK5VDT5 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/Library_Projects_FPGA/Jav_VA_old/UDACHA_V_CODER_v3/prj/project_1.srcs/sources_1/ip/floating_point_int16_to_float32/floating_point_int16_to_float32_sim_netlist.v
// Design      : floating_point_int16_to_float32
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "floating_point_int16_to_float32,floating_point_v7_1_2,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "floating_point_v7_1_2,Vivado 2016.2" *) 
(* NotValidForBitStream *)
module floating_point_int16_to_float32
   (s_axis_a_tvalid,
    s_axis_a_tdata,
    m_axis_result_tvalid,
    m_axis_result_tdata);
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_A TVALID" *) input s_axis_a_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 S_AXIS_A TDATA" *) input [15:0]s_axis_a_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT TVALID" *) output m_axis_result_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_RESULT TDATA" *) output [31:0]m_axis_result_tdata;

  wire [31:0]m_axis_result_tdata;
  wire m_axis_result_tvalid;
  wire [15:0]s_axis_a_tdata;
  wire s_axis_a_tvalid;
  wire NLW_U0_m_axis_result_tlast_UNCONNECTED;
  wire NLW_U0_s_axis_a_tready_UNCONNECTED;
  wire NLW_U0_s_axis_b_tready_UNCONNECTED;
  wire NLW_U0_s_axis_c_tready_UNCONNECTED;
  wire NLW_U0_s_axis_operation_tready_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_result_tuser_UNCONNECTED;

  (* C_ACCUM_INPUT_MSB = "32" *) 
  (* C_ACCUM_LSB = "-31" *) 
  (* C_ACCUM_MSB = "32" *) 
  (* C_A_FRACTION_WIDTH = "0" *) 
  (* C_A_TDATA_WIDTH = "16" *) 
  (* C_A_TUSER_WIDTH = "1" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_BRAM_USAGE = "0" *) 
  (* C_B_FRACTION_WIDTH = "0" *) 
  (* C_B_TDATA_WIDTH = "16" *) 
  (* C_B_TUSER_WIDTH = "1" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_COMPARE_OPERATION = "8" *) 
  (* C_C_FRACTION_WIDTH = "0" *) 
  (* C_C_TDATA_WIDTH = "16" *) 
  (* C_C_TUSER_WIDTH = "1" *) 
  (* C_C_WIDTH = "16" *) 
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
  (* C_HAS_B = "0" *) 
  (* C_HAS_B_TLAST = "0" *) 
  (* C_HAS_B_TUSER = "0" *) 
  (* C_HAS_C = "0" *) 
  (* C_HAS_COMPARE = "0" *) 
  (* C_HAS_C_TLAST = "0" *) 
  (* C_HAS_C_TUSER = "0" *) 
  (* C_HAS_DIVIDE = "0" *) 
  (* C_HAS_DIVIDE_BY_ZERO = "0" *) 
  (* C_HAS_EXPONENTIAL = "0" *) 
  (* C_HAS_FIX_TO_FLT = "1" *) 
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
  (* C_LATENCY = "0" *) 
  (* C_MULT_USAGE = "0" *) 
  (* C_OPERATION_TDATA_WIDTH = "8" *) 
  (* C_OPERATION_TUSER_WIDTH = "1" *) 
  (* C_OPTIMIZATION = "1" *) 
  (* C_RATE = "1" *) 
  (* C_RESULT_FRACTION_WIDTH = "24" *) 
  (* C_RESULT_TDATA_WIDTH = "32" *) 
  (* C_RESULT_TUSER_WIDTH = "1" *) 
  (* C_RESULT_WIDTH = "32" *) 
  (* C_THROTTLE_SCHEME = "3" *) 
  (* C_TLAST_RESOLUTION = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* KEEP_HIERARCHY = "true" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  floating_point_int16_to_float32_floating_point_v7_1_2 U0
       (.aclk(1'b0),
        .aclken(1'b1),
        .aresetn(1'b1),
        .m_axis_result_tdata(m_axis_result_tdata),
        .m_axis_result_tlast(NLW_U0_m_axis_result_tlast_UNCONNECTED),
        .m_axis_result_tready(1'b0),
        .m_axis_result_tuser(NLW_U0_m_axis_result_tuser_UNCONNECTED[0]),
        .m_axis_result_tvalid(m_axis_result_tvalid),
        .s_axis_a_tdata(s_axis_a_tdata),
        .s_axis_a_tlast(1'b0),
        .s_axis_a_tready(NLW_U0_s_axis_a_tready_UNCONNECTED),
        .s_axis_a_tuser(1'b0),
        .s_axis_a_tvalid(s_axis_a_tvalid),
        .s_axis_b_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_b_tlast(1'b0),
        .s_axis_b_tready(NLW_U0_s_axis_b_tready_UNCONNECTED),
        .s_axis_b_tuser(1'b0),
        .s_axis_b_tvalid(1'b0),
        .s_axis_c_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
(* C_A_FRACTION_WIDTH = "0" *) (* C_A_TDATA_WIDTH = "16" *) (* C_A_TUSER_WIDTH = "1" *) 
(* C_A_WIDTH = "16" *) (* C_BRAM_USAGE = "0" *) (* C_B_FRACTION_WIDTH = "0" *) 
(* C_B_TDATA_WIDTH = "16" *) (* C_B_TUSER_WIDTH = "1" *) (* C_B_WIDTH = "16" *) 
(* C_COMPARE_OPERATION = "8" *) (* C_C_FRACTION_WIDTH = "0" *) (* C_C_TDATA_WIDTH = "16" *) 
(* C_C_TUSER_WIDTH = "1" *) (* C_C_WIDTH = "16" *) (* C_FIXED_DATA_UNSIGNED = "0" *) 
(* C_HAS_ABSOLUTE = "0" *) (* C_HAS_ACCUMULATOR_A = "0" *) (* C_HAS_ACCUMULATOR_S = "0" *) 
(* C_HAS_ACCUM_INPUT_OVERFLOW = "0" *) (* C_HAS_ACCUM_OVERFLOW = "0" *) (* C_HAS_ACLKEN = "0" *) 
(* C_HAS_ADD = "0" *) (* C_HAS_ARESETN = "0" *) (* C_HAS_A_TLAST = "0" *) 
(* C_HAS_A_TUSER = "0" *) (* C_HAS_B = "0" *) (* C_HAS_B_TLAST = "0" *) 
(* C_HAS_B_TUSER = "0" *) (* C_HAS_C = "0" *) (* C_HAS_COMPARE = "0" *) 
(* C_HAS_C_TLAST = "0" *) (* C_HAS_C_TUSER = "0" *) (* C_HAS_DIVIDE = "0" *) 
(* C_HAS_DIVIDE_BY_ZERO = "0" *) (* C_HAS_EXPONENTIAL = "0" *) (* C_HAS_FIX_TO_FLT = "1" *) 
(* C_HAS_FLT_TO_FIX = "0" *) (* C_HAS_FLT_TO_FLT = "0" *) (* C_HAS_FMA = "0" *) 
(* C_HAS_FMS = "0" *) (* C_HAS_INVALID_OP = "0" *) (* C_HAS_LOGARITHM = "0" *) 
(* C_HAS_MULTIPLY = "0" *) (* C_HAS_OPERATION = "0" *) (* C_HAS_OPERATION_TLAST = "0" *) 
(* C_HAS_OPERATION_TUSER = "0" *) (* C_HAS_OVERFLOW = "0" *) (* C_HAS_RECIP = "0" *) 
(* C_HAS_RECIP_SQRT = "0" *) (* C_HAS_RESULT_TLAST = "0" *) (* C_HAS_RESULT_TUSER = "0" *) 
(* C_HAS_SQRT = "0" *) (* C_HAS_SUBTRACT = "0" *) (* C_HAS_UNDERFLOW = "0" *) 
(* C_LATENCY = "0" *) (* C_MULT_USAGE = "0" *) (* C_OPERATION_TDATA_WIDTH = "8" *) 
(* C_OPERATION_TUSER_WIDTH = "1" *) (* C_OPTIMIZATION = "1" *) (* C_RATE = "1" *) 
(* C_RESULT_FRACTION_WIDTH = "24" *) (* C_RESULT_TDATA_WIDTH = "32" *) (* C_RESULT_TUSER_WIDTH = "1" *) 
(* C_RESULT_WIDTH = "32" *) (* C_THROTTLE_SCHEME = "3" *) (* C_TLAST_RESOLUTION = "0" *) 
(* C_XDEVICEFAMILY = "kintex7" *) (* ORIG_REF_NAME = "floating_point_v7_1_2" *) (* downgradeipidentifiedwarnings = "yes" *) 
module floating_point_int16_to_float32_floating_point_v7_1_2
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
  input [15:0]s_axis_a_tdata;
  input [0:0]s_axis_a_tuser;
  input s_axis_a_tlast;
  input s_axis_b_tvalid;
  output s_axis_b_tready;
  input [15:0]s_axis_b_tdata;
  input [0:0]s_axis_b_tuser;
  input s_axis_b_tlast;
  input s_axis_c_tvalid;
  output s_axis_c_tready;
  input [15:0]s_axis_c_tdata;
  input [0:0]s_axis_c_tuser;
  input s_axis_c_tlast;
  input s_axis_operation_tvalid;
  output s_axis_operation_tready;
  input [7:0]s_axis_operation_tdata;
  input [0:0]s_axis_operation_tuser;
  input s_axis_operation_tlast;
  output m_axis_result_tvalid;
  input m_axis_result_tready;
  output [31:0]m_axis_result_tdata;
  output [0:0]m_axis_result_tuser;
  output m_axis_result_tlast;

  wire aclk;
  wire aclken;
  wire aresetn;
  wire [31:0]m_axis_result_tdata;
  wire m_axis_result_tlast;
  wire m_axis_result_tready;
  wire [0:0]m_axis_result_tuser;
  wire m_axis_result_tvalid;
  wire [15:0]s_axis_a_tdata;
  wire s_axis_a_tlast;
  wire s_axis_a_tready;
  wire [0:0]s_axis_a_tuser;
  wire s_axis_a_tvalid;
  wire [15:0]s_axis_b_tdata;
  wire s_axis_b_tlast;
  wire s_axis_b_tready;
  wire [0:0]s_axis_b_tuser;
  wire s_axis_b_tvalid;
  wire [15:0]s_axis_c_tdata;
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
  (* C_A_FRACTION_WIDTH = "0" *) 
  (* C_A_TDATA_WIDTH = "16" *) 
  (* C_A_TUSER_WIDTH = "1" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_BRAM_USAGE = "0" *) 
  (* C_B_FRACTION_WIDTH = "0" *) 
  (* C_B_TDATA_WIDTH = "16" *) 
  (* C_B_TUSER_WIDTH = "1" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_COMPARE_OPERATION = "8" *) 
  (* C_C_FRACTION_WIDTH = "0" *) 
  (* C_C_TDATA_WIDTH = "16" *) 
  (* C_C_TUSER_WIDTH = "1" *) 
  (* C_C_WIDTH = "16" *) 
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
  (* C_HAS_B = "0" *) 
  (* C_HAS_B_TLAST = "0" *) 
  (* C_HAS_B_TUSER = "0" *) 
  (* C_HAS_C = "0" *) 
  (* C_HAS_COMPARE = "0" *) 
  (* C_HAS_C_TLAST = "0" *) 
  (* C_HAS_C_TUSER = "0" *) 
  (* C_HAS_DIVIDE = "0" *) 
  (* C_HAS_DIVIDE_BY_ZERO = "0" *) 
  (* C_HAS_EXPONENTIAL = "0" *) 
  (* C_HAS_FIX_TO_FLT = "1" *) 
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
  (* C_LATENCY = "0" *) 
  (* C_MULT_USAGE = "0" *) 
  (* C_OPERATION_TDATA_WIDTH = "8" *) 
  (* C_OPERATION_TUSER_WIDTH = "1" *) 
  (* C_OPTIMIZATION = "1" *) 
  (* C_RATE = "1" *) 
  (* C_RESULT_FRACTION_WIDTH = "24" *) 
  (* C_RESULT_TDATA_WIDTH = "32" *) 
  (* C_RESULT_TUSER_WIDTH = "1" *) 
  (* C_RESULT_WIDTH = "32" *) 
  (* C_THROTTLE_SCHEME = "3" *) 
  (* C_TLAST_RESOLUTION = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  floating_point_int16_to_float32_floating_point_v7_1_2_viv i_synth
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
HH7KQhKO0/gZ5M63iSQ3bu1MAgwpUZL+vLQrMfPXqJevP/m+91O5VFVUShP8BQcFEhIFJFAe7SDN
VqoGgxMWAw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
HLPsZ69Y13w6O4bbp1zWyFrfTslmZ6cHTJg5lviDVMXb0pQakZY6Q59x6+weS+qFKmi+WWhBzDHV
C3gwRHI/0d8d994npwFi/xuAhZBjqRMuG3BQKawD9BbF/gmyY9GQ6DEibuctjD3y1kd+jTqQIZTn
barO1YnAtc+pjzBo/44=

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
JER+Cr8B+8I4db/iIiIs+58+Oa3e8gN5G0MXtGFMgGt80RHcv5gQHJCHZcZAP4Wv91fBYlV22Dz2
ybtaInV9/Vfey9z6J/MD/L0hLn9/+T2FwUeBz0ylr0MHolbd44Y6nlg/dAdFqBLrjJ9HWRdQaZp2
3LlymAncxXRC+D2/CwU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
JlQcV7DKxxdLh6HL3l13dcBBI1PkeAloESp6kPaPwgsvB/iuLhDxRsX0HswCxjDs1XtAKbQiH4Ml
zFX1TvuEmsn4qQhPH+byD/HT83OBCRt3SlPsnmUKzYd+3EuRo0uLjYYaueYcl0g2IUf+FV1Novaa
CLjjVT2kB6UM1UF3JWnQlQP/OnTS7irEkV+niLBft0DwwcUKbRh7BMI5W6+dMuEv+O5lwIcrFv/E
BQ6xsq7DF0eYlbTk4xAa3rF2ZuobIf6mpX+FPdK05vvaJqxDfblBk64HHLFbv9LArhwOCWHF5ylA
lFcetmiaSxnkoWPMO7/nyawfD0lkZqkjX/YJSg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qyqwM/oeEqDcOzCpzWdsoc14EWfx9Mz2EpdUui7HXjcZaNHnF6o7iF0cqrEN1oFTVPRJPNFakas9
r2aGbP9gEiuwFp9hUDg3SZFLRUUQdqyay9TzhstUf9lG0jAuRP4l0jMpf7iZFl73EbToKBH7A3ty
EfBHQEEorTp2sfA0B39A3jIuPXsUqS5sclfZ1Uybrh8XLaYUSmbKRA8mt9Ul1aAowDoXDTD01lW/
J2YohitAf6XHoo6O7Ejqm9mEalJfaBjG7A0+ALa2Y6L2Y/qGydNwpv9u/HjBh8fiHYf3Xo7mBlpK
FCBFwxu9E2v4VFimXHUnnVrkrIEuvUHgQaHhEg==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinx_2016_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
tvKDtzj/VrgVZwR8am/J4vNuhr4ehzmo+VpeylSigrKqPBSGHvUoSdbguwx7+FUR8Gy+lxXMFzXs
u67AWFbVPzIvpJxnCnaAk90TImRJ8bbij1tYdDOroiRms9E1mFcEafxOZZjKW4XoCzegLMa6UHdy
o8jAQFOxNzQ5FJf76MQSCy5DU8jmzW/5EXiGi3nkbVOtp5/9Dl2+6dPFbZWe16RaZeHKCKvzg3nf
OIGkg6IXNE0vz93f0Ugc3qQlXEI++MyLNFa6S5HQB/114LmqPOTDPCEP63pKZZbgyXkcA91twYXB
ZPBYjP++hrez9+YPFFqHm3ShIZTOM0C0DHNGkw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
JwJfM8jmkfCvBJDaqx2zr8pNbk7k+993X7CDsSWFotjiU8VJWTa/7Th7/vt7lmIX7/oGGuLiHbgH
v+SeAP/KtGUa8G7sMeec4h4R7mU1clQ4S4s/aETnk+XrMoW3xz24WNmpUBS6Usa2J6nlg5AnigJg
/R+lN+W78iPIDAj9BQ7OFUF8BYuv5sMpzlP+8ZNJkPtza/HHy6XW4QHhu4cCHGoaqBx9pw2k2nyb
iDFT4x9FUj7SOXf5cK+7U5rMpK4rh7nPgI5iL/oOunYxg41q0Kl98WDJa/Db/oYlFSaPeDvByVdD
+vrScZDnK6GHXWqXjy9iKWMyY5E58XPSVhb3Rw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP05_001", key_method="rsa"
`pragma protect encoding = (enctype="base64", line_length=76, bytes=256)
`pragma protect key_block
LJPvQZjoLS5VbReKjUbnoAAtYeAmWCSYC1PMThvEU+IMMnk0upCdDAD7dpM0K+RkdcY7uHTIFF0r
4M8+hKvtgLd9bYeCG2WiY9o6CbcVYLOM7mBKHeK+Mqlf/uXl7SMn8qkE/sOm7XDBZl8+bM74JWyV
jbdq/Ma+YCGIoWhNj9xCet/JJCMaVBM8VCdAFmar39bTAyi/Th9poeyswHEzlvvVX9C/xCQFKCei
q50Vflv8LS61+3q1M3R/CyRFjxr83JLocYw4DQwtneJuxbc70BjZ3cpzfvsI/iwxqRKfhI9P2U0+
kals9yY0ne4m+lI3A7BBT7SwPZFo3iRl3AF3DQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 46096)
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
