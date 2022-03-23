-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
-- Date        : Mon Mar 14 17:30:42 2022
-- Host        : B51-314-TS-W1 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               d:/Library_Projects_FPGA/Jav_VA_old/UDACHA_V_CODER_v3/prj/project_1.srcs/sources_1/ip/DNN_0/DNN_0_stub.vhdl
-- Design      : DNN_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DNN_0 is
  Port ( 
    mfcc_ce0 : out STD_LOGIC;
    ap_clk : in STD_LOGIC;
    ap_rst : in STD_LOGIC;
    ap_start : in STD_LOGIC;
    ap_done : out STD_LOGIC;
    ap_idle : out STD_LOGIC;
    ap_ready : out STD_LOGIC;
    ap_return : out STD_LOGIC_VECTOR ( 31 downto 0 );
    mfcc_address0 : out STD_LOGIC_VECTOR ( 5 downto 0 );
    mfcc_q0 : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end DNN_0;

architecture stub of DNN_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "mfcc_ce0,ap_clk,ap_rst,ap_start,ap_done,ap_idle,ap_ready,ap_return[31:0],mfcc_address0[5:0],mfcc_q0[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "DNN,Vivado 2016.2";
begin
end;
