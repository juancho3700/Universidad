----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.09.2019 16:08:25
-- Design Name: 
-- Module Name: Pr2_2 - Behavioral
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

entity Pr2_2 is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           c : in STD_LOGIC;
           d : in STD_LOGIC;
           y : out STD_LOGIC);
end Pr2_2;

architecture RTL of Pr2_2 is
    
    signal P: STD_LOGIC;
    signal Q: STD_LOGIC;
    signal R: STD_LOGIC;
    signal S: STD_LOGIC;

begin
    P <= a and b and c;
    Q <= a and b and d;
    R <= a and c and d;
    S <= b and c and d;
    y <= P or Q or R or S;
end RTL;