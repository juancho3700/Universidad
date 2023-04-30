----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2019 17:24:11
-- Design Name: 
-- Module Name: MUX - MUX
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

entity MUX is
    Port ( p_and : in STD_LOGIC_VECTOR (7 downto 0);
           c_a2 : in STD_LOGIC_VECTOR (7 downto 0);
           resta : in STD_LOGIC_VECTOR (7 downto 0);
           prod : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end MUX;

architecture MUX of MUX is

begin

    Y <= p_and when sel = "00" else
         c_a2 when sel = "01" else
         resta when sel = "10" else
         prod when sel = "11" else
         "00000000";

end MUX;
