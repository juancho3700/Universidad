----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2019 16:50:01
-- Design Name: 
-- Module Name: Pr6_2 - Behavioral
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

entity Pr6_2 is
    Port ( G : in STD_LOGIC;
           s : in STD_LOGIC_VECTOR (1 downto 0);
           d0, d1, d2, d3: in STD_LOGIC;
           Q : out STD_LOGIC);
end Pr6_2;

architecture Behavioral of Pr6_2 is

    signal selec: STD_LOGIC_VECTOR (2 downto 0);

begin

    selec <= G & s;

    process (selec, d0, d1, d2, d3)
    begin
        case selec is
            when "100" => Q <= d0;
            when "101" => Q <= d1;
            when "110" => Q <= d2;
            when "111" => Q <= d3;
            when others => Q <= '0';
        end case;

    end process;
end Behavioral;
