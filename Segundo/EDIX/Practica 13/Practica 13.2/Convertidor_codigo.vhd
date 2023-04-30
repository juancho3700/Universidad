----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2019 11:17:55
-- Design Name: 
-- Module Name: Convertidor_codigo - Convertidor_codigo
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

entity Convertidor_codigo is
    Port ( Col : in STD_LOGIC_VECTOR (1 downto 0);
           Fil : in STD_LOGIC_VECTOR (1 downto 0);
           Bin : out STD_LOGIC_VECTOR (3 downto 0));
end Convertidor_codigo;

architecture Convertidor_codigo of Convertidor_codigo is

    signal entrada : std_logic_vector (3 downto 0);

begin

    entrada <= Col & Fil;
    
    process (entrada)
    begin
    
        case entrada is
            when "0000" => Bin <= "0001";
            when "0001" => Bin <= "0100";
            when "0010" => Bin <= "0111";
            when "0011" => Bin <= "0000";
            when "0100" => Bin <= "0010";
            when "0101" => Bin <= "0101";
            when "0110" => Bin <= "1000";
            when "0111" => Bin <= "1111";
            when "1000" => Bin <= "0011";
            when "1001" => Bin <= "0110";
            when "1010" => Bin <= "1001";
            when "1011" => Bin <= "1110";
            when "1100" => Bin <= "1010";
            when "1101" => Bin <= "1011";
            when "1110" => Bin <= "1100";
            when "1111" => Bin <= "1101";
            when others => Bin <= "0000";
        end case;
    
    end process;    
end Convertidor_codigo;
