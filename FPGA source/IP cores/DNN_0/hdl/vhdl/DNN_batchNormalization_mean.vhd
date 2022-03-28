-- ==============================================================
-- File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2016.2
-- Copyright (C) 1986-2016 Xilinx, Inc. All Rights Reserved.
-- 
-- ==============================================================

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity DNN_batchNormalization_mean_rom is 
    generic(
             dwidth     : integer := 32; 
             awidth     : integer := 6; 
             mem_size    : integer := 39
    ); 
    port (
          addr0      : in std_logic_vector(awidth-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(dwidth-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of DNN_batchNormalization_mean_rom is 

signal addr0_tmp : std_logic_vector(awidth-1 downto 0); 
type mem_array is array (0 to mem_size-1) of std_logic_vector (dwidth-1 downto 0); 
signal mem : mem_array := (
    0 => "01000001011110001101110110010101", 
    1 => "11000001000001001110011110110101", 
    2 => "11000001001001100111100101010110", 
    3 => "11000000000110101000100100111010", 
    4 => "11000001000100100111011001101101", 
    5 => "11000000110010001100110111111101", 
    6 => "11000000110110110100001001111111", 
    7 => "11000000100011001011111101110110", 
    8 => "11000000101100001001110010011011", 
    9 => "11000000011000111001011100100010", 
    10 => "11000000101001001111001011011000", 
    11 => "11000000011110011101111010011010", 
    12 => "11000000101000101000110000000100", 
    13 => "00111100010001011111011001000101", 
    14 => "10111100111110010100010010111111", 
    15 => "00111011001110110111111111100010", 
    16 => "00111100111111011000101111011100", 
    17 => "10111100111001100011100010110100", 
    18 => "10111100110010000011010001010010", 
    19 => "10111100110111100111110100110000", 
    20 => "10111100100001110110110010011001", 
    21 => "00111100101111010001101000011000", 
    22 => "10111100011011010000011001100100", 
    23 => "10111100011000101110111111010010", 
    24 => "10111100011000010101100001110110", 
    25 => "10111100000111101011101010000111", 
    26 => "00111010100000011110000111100111", 
    27 => "10111011100000111111110100100110", 
    28 => "10111010001010011101001110111100", 
    29 => "10111010101101110100101111110101", 
    30 => "10111011101001100001000001111100", 
    31 => "00111011110000111111110010111010", 
    32 => "10111011011111011100100110111000", 
    33 => "00111011110001011100110111010001", 
    34 => "00111011011000000101000111100000", 
    35 => "10111100010011101100100110011010", 
    36 => "10111011110110110100110000000010", 
    37 => "10111100010110101011111001000110", 
    38 => "10111100010000111010111111011010" );


attribute EQUIVALENT_REGISTER_REMOVAL : string;
begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;

entity DNN_batchNormalization_mean is
    generic (
        DataWidth : INTEGER := 32;
        AddressRange : INTEGER := 39;
        AddressWidth : INTEGER := 6);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of DNN_batchNormalization_mean is
    component DNN_batchNormalization_mean_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    DNN_batchNormalization_mean_rom_U :  component DNN_batchNormalization_mean_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;

