----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2019 18:52:38
-- Design Name: 
-- Module Name: Pr4_2 - Behavioral
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

entity Pr4_2 is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           R : out STD_LOGIC_VECTOR (2 downto 0));
end Pr4_2;

architecture RTL of Pr4_2 is

signal entradas : STD_LOGIC_VECTOR (3 downto 0);

begin
entradas <= A & B;

with entradas select R <=
    "000" when "0000",
    "001" when "0001",
    "010" when "0010",
    "011" when "0011",
    
    "001" when "0100",
    "010" when "0101",
    "011" when "0110",
    "100" when "0111",
    
    "010" when "1000",
    "011" when "1001",  
    "100" when "1010",
    "101" when "1011",
    
    "011" when "1100",
    "100" when "1101",
    "101" when "1110",
    "110" when "1111",
    "000" when others;

end RTL;