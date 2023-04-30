----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 10:44:10
-- Design Name: 
-- Module Name: Pr7_2 - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pr7_2 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           AiB : out STD_LOGIC;
           AmaB : out STD_LOGIC;
           AmeB : out STD_LOGIC);
end Pr7_2;

architecture Behavioral of Pr7_2 is
begin

    process (a, b)
    begin
    
        if a = b then AiB <= '1';
                      AmaB <= '0';
                      AmeB <= '0';
                      
            elsif a > b then AiB <= '0';
                             AmaB <= '1';
                             AmeB <= '0';
                             
            elsif a < b then AiB <= '0';
                             AmaB <= '0';
                             AmeB <= '1';
            else AiB <= '0';
                 AmaB <= '0';
                 AmaB <= '0';
        end if;
 
    end process;
end Behavioral;
