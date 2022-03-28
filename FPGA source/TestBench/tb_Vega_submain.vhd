----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2021 14:46:28
-- Design Name: 
-- Module Name: tb_Vega_submain - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_Vega_submain is
--  Port ( );
end tb_Vega_submain;

architecture Behavioral of tb_Vega_submain is

    component Vega_submain
        port (
            g_fast_clk      : in std_logic;
            bclk            : in std_logic;
            wclk            : in std_logic;
            d_audio         : in std_logic;
            DNN_Done        : out std_logic;
            DNN_Result      : out std_logic
        );
    end component;
    
    -- Inputs:
    signal g_fast_clk           : std_logic := '0';
    signal bclk                 : std_logic := '0';
    signal wclk                 : std_logic := '0';
    signal d_audio              : std_logic := '0';
    
    -- Outputs:
    signal DNN_Done             : std_logic;
    signal DNN_Result           : std_logic;
    
    -- Others:
    signal gen_bits             : std_logic_vector(15 downto 0) := (others => '0');
    
    -- Timing constants:
    constant g_fast_clk_period  : time := 9.259 ns;
    constant bclk_period        : time := 1.953125 us;
    constant wclk_period        : time := 62.5 us;

begin

    g_fast_clk_proc: process begin
        g_fast_clk <= '0';
            wait for g_fast_clk_period / 2;
        g_fast_clk <= '1';
            wait for g_fast_clk_period / 2;    
    end process g_fast_clk_proc;

    bclk_proc: process begin
        bclk <= '0';
            wait for bclk_period / 2;
        bclk <= '1';
            wait for bclk_period / 2;
    end process bclk_proc;
    
    wclk_proc: process begin
        wclk <= '0';
            wait for wclk_period / 2;
        wclk <= '1';
            wait for wclk_period / 2;
    end process wclk_proc;
    
    gen_bits_proc: process(wclk, bclk) begin
        if falling_edge(wclk) then
            gen_bits                <= gen_bits + '1';
        end if;
        
        if falling_edge(bclk) then
            gen_bits(15 downto 1)   <= gen_bits(14 downto 0);
            gen_bits(0)             <= gen_bits(15);
        end if;
    end process gen_bits_proc;
    d_audio <= gen_bits(15);
    
    uut_main: Vega_submain
        port map (
            g_fast_clk  => g_fast_clk,
            bclk        => bclk,
            wclk        => wclk,
            d_audio     => d_audio,
            DNN_Done    => DNN_Done,
            DNN_Result  => DNN_Result
        );

end Behavioral;
