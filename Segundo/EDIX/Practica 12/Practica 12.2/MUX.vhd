----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2019 16:27:46
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
    Port ( sel : in STD_LOGIC_VECTOR (1 downto 0);
           e1 : in STD_LOGIC_VECTOR (3 downto 0);
           e2 : in STD_LOGIC_VECTOR (3 downto 0);
           e3 : in STD_LOGIC_VECTOR (3 downto 0);
           e4 : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (3 downto 0));
end MUX;

architecture MUX of MUX is

begin

    process (sel)
    begin
    
        case sel is
            when "00" => S <= e1;
            when "01" => S <= e2;
            when "10" => S <= e3;
            when "11" => S <= e4;
            when others => S <= "0000";
        end case;
    
    end process;

end MUX;
