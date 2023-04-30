----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2019 16:27:46
-- Design Name: 
-- Module Name: 
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

entity Dec_1_a_4 is
    Port ( G : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0));
end Dec_1_a_4;

architecture Dec_1_a_4 of Dec_1_a_4 is

begin

    q(0) <= not ((not d(0)) and (not d(1)) and G);
    q(1) <= not (d(0) and (not d(1)) and G);
    q(2) <= not ((not d(0)) and d(1) and G);
    q(3) <= not (d(0) and d(1) and G);

end Dec_1_a_4;
