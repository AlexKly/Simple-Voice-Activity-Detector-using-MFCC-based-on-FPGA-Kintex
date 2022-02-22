----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2020 14:35:21
-- Design Name: 
-- Module Name: framing - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity get_frames is
    Port (
        clk_slow    : in std_logic;
        clk_fast    : in std_logic;
        reset       : in std_logic;
        en_audio_d  : in std_logic;
        audio_d     : in std_logic_vector(31 downto 0);
        
        Stream_enable   : out std_logic;
        Stream_out      : out std_logic_vector(31 downto 0) 
    );
end get_frames;

architecture Behavioral of get_frames is

    constant frame_length   : integer := 512;
    constant frame_step     : integer := 160;

    type reg_frame is array(0 to frame_length - 1) of std_logic_vector(31 downto 0);
    
    signal frame_in     : reg_frame;
    signal frame_out    : reg_frame;
    
    signal en_send              : std_logic := '0';
    signal cnt_frame            : std_logic_vector(9 downto 0) := (others => '0');
    signal cnt_frame_out        : std_logic_vector(9 downto 0) := (others => '0');
    signal cnt_step             : std_logic_vector(7 downto 0) := (others => '0');
    signal flag_first_enterance : std_logic := '0';
    signal Stream_enable_temp   : std_logic;

begin

    reg_input_proc: process(clk_slow) begin
        if rising_edge(clk_slow) then
            if reset = '0' then
                if en_audio_d = '1' then
                    
                    frame_in(0) <= audio_d;
                    en_send <= '0';
                    frame_in(1 to frame_length - 1) <= frame_in(0 to frame_length - 2);
                    
                    
                    if flag_first_enterance = '0' then
                        cnt_frame <= cnt_frame + '1';
                        if cnt_frame = std_logic_vector(to_unsigned(frame_length - 1, cnt_frame'length)) then
                            --frame_out <= frame_in;
                            en_send <= '1';
                            cnt_frame <= (others => '0');
                            flag_first_enterance <= '1';
                        end if;
                    else
                        cnt_step <= cnt_step + '1';
                        if cnt_step = std_logic_vector(to_unsigned(frame_step - 1, cnt_step'length)) then
                            en_send <= '1';
                            --frame_out <= frame_in;
                            cnt_step <= (others => '0');
                        end if;
                    end if;
                end if;
            else
                frame_in <= (others => (others => '0'));
            end if;
        end if;
    end process reg_input_proc;
    
    reg_output_proc: process(clk_fast) begin
        if rising_edge(clk_fast) then
            if flag_first_enterance = '1' then
                if en_send = '1' then
                    cnt_frame_out <= (others => '0');
                else
                    if cnt_frame_out < std_logic_vector(to_unsigned(frame_length, cnt_frame_out'length)) then
                        cnt_frame_out <= cnt_frame_out + '1';
                        Stream_enable_temp <= '1';
                    else
                        Stream_enable_temp <= '0';
                    end if;
                end if;   
            else
                cnt_frame_out <= (others => '0');
            end if;
            
            if cnt_frame_out < std_logic_vector(to_unsigned(frame_length - 1, cnt_frame_out'length)) and flag_first_enterance = '1' then
                if cnt_frame_out < "000000001" then   
                    frame_out <= frame_in;
                else
                    frame_out(1 to frame_length - 1) <= frame_out(0 to frame_length - 2);
                end if;
            end if;       
        end if;
    end process reg_output_proc;
    
    Stream_enable <= Stream_enable_temp;
    
    out_reg_proc: process(clk_fast) begin
        if rising_edge(clk_fast) then
            Stream_out <= frame_out(frame_length - 1);
        end if;
    end process out_reg_proc;

end Behavioral;
