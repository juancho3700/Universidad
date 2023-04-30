----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2019 16:19:16
-- Design Name: 
-- Module Name: Leds_7_Segs - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Leds_7_Segs is
    Port ( DIN : in STD_LOGIC_VECTOR (3 downto 0);
           dp_in : in STD_LOGIC;
           en : in STD_LOGIC;
           DP : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (6 downto 0));
end Leds_7_Segs;

architecture Leds_7_Segs of Leds_7_Segs is

    signal ent: std_logic_vector (4 downto 0);

begin

    ent <= en & DIN;

    with ent select S <=
         "0000001" when "10000",
         "1001111" when "10001",
         "0010010" when "10010",
         "0000110" when "10011",
         "1001100" when "10100",
         "0100100" when "10101",
         "0100000" when "10110",
         "0001111" when "10111",
         "0000000" when "11000",
         "0001100" when "11001",
         "0001000" when "11010",
         "1100000" when "11011",
         "0110001" when "11100",
         "1000010" when "11101",
         "0110000" when "11110",
         "0111000" when "11111",
         "1111111" when others;
    
    process (dp_in, en)
    begin
    
        if en = '0' then dp <= '1';
            elsif dp_in = '0' then dp <= '1';
            else dp <= '0';
        end if;
    
    end process;
end Leds_7_Segs;
