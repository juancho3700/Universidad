----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.10.2019 11:19:32
-- Design Name: 
-- Module Name: Pr4_2_2 - Behavioral
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

entity Pr4_2_2 is
    Port ( a : in STD_LOGIC_VECTOR (1 downto 0);
           b : in STD_LOGIC_VECTOR (1 downto 0);
           S0 : out STD_LOGIC;
           S1 : out STD_LOGIC;
           S2 : out STD_LOGIC);
end Pr4_2_2;

architecture Behavioral of Pr4_2_2 is
    signal T: std_logic_vector (3 downto 0);
begin

    T <= a & b;

    S2 <= '1' when T = "0111" else
          '1' when T = "1010" else
          '1' when T = "1011" else
          '1' when T = "1101" else
          '1' when T = "1110" else
          '1' when T = "1111" else
          '0';
          
    process (T)
    begin
        
        if T = "0010" then S1 <= '1';
        elsif T = "0011" then S1 <= '1';
        elsif T = "0101" then S1 <= '1';
        elsif T = "0110" then S1 <= '1';
        elsif T = "1000" then S1 <= '1';
        elsif T = "1001" then S1 <= '1';
        elsif T = "1100" then S1 <= '1';
        elsif T = "1111" then S1 <= '1';
        else S1 <= '0';
        end if;
    end process;

    process (T)
    begin
    
        case T is
            when "0001" => S0 <= '1';
            when "0011" => S0 <= '1';
            when "0100" => S0 <= '1';
            when "0110" => S0 <= '1';
            when "1001" => S0 <= '1';
            when "1011" => S0 <= '1';
            when "1100" => S0 <= '1';
            when "1110" => S0 <= '1';
            when others => S0 <= '0';
        end case;
    end process;

end Behavioral;
