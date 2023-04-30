----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 14:49:34
-- Design Name: 
-- Module Name: Pr7_3 - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pr7_3 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           suma : out STD_LOGIC_VECTOR (4 downto 0));
end Pr7_3;

architecture Behavioral of Pr7_3 is

    signal sA, sB : std_logic_vector (4 downto 0) := "00000";

begin
    
    sA <= a(3) & a(3) & a(2) & a(1) & a(0);
    sB <= b(3) & b(3) & b(2) & b(1) & b(0);
    
    suma <= sA + sB;
    
end Behavioral;
