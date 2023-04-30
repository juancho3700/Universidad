----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2019 10:49:01
-- Design Name: 
-- Module Name: Pr5_1 - Behavioral
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

entity Pr5_1 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           f1 : out STD_LOGIC;
           f2 : out STD_LOGIC;
           f3 : out STD_LOGIC);
end Pr5_1;

architecture RTL of Pr5_1 is
begin

--    f1 <= '1' when a = "0010" else
--    '1' when a = "0100" else
--    '1' when a = "0110" else
--    '1' when a = "1000" else
--    '0';
    
    f1 <= (not a(0)) and ((a(1) and a(3)) or a(2) or a(3));
    
    process (a)
    begin
    
        if a = "0001" then f2 <= '1';
            elsif a = "0010" then f2 <= '1';
            elsif a = "0011" then f2 <= '1';
            elsif a = "0100" then f2 <= '1';
            else f2 <= '0';
        end if;
        
    end process;

    process (a)
    begin
    
        case a is 
            when "0100" => f3 <= '1';
            when "1000" => f3 <= '1';
            when others => f3 <= '0';
        end case;
        
    end process;
end RTL;
