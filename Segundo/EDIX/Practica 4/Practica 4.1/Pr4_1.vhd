----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2019 17:40:23
-- Design Name: 
-- Module Name: Pr4_1 - Behavioral
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

entity Pr4_1 is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : in STD_LOGIC;
           d : in STD_LOGIC;
           Y : out STD_LOGIC);
end Pr4_1;

architecture RTL of Pr4_1 is
signal entradas: STD_LOGIC_VECTOR (3 downto 0);
begin

entradas <= a & b & c & d;

process (entradas)
begin

case entradas is
    when "0001" => Y <= '0';
    when "0011" => Y <= '0';
    when "0111" => Y <= '0';
    when "1000" => Y <= '0';
    when "1011" => Y <= '0';
    when "1100" => Y <= '0';
    when "1110" => Y <= '0';
    when others => Y <= '1';
end case;
end process;

end RTL;