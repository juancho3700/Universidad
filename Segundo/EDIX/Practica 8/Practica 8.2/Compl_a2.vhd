----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2019 17:24:11
-- Design Name: 
-- Module Name: Compl_a2 - Compl_a2
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
use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Compl_a2 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           c_a2 : out STD_LOGIC_VECTOR (3 downto 0));
end Compl_a2;

architecture Compl_a2 of Compl_a2 is

begin

    c_a2 <= a when a(3) = '0' else
            (not a) + "0001" when a(3) = '1' else
            "0000";

end Compl_a2;
