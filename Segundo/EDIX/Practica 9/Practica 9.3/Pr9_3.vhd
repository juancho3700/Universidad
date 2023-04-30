----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2019 20:25:34
-- Design Name: 
-- Module Name: Pr9_3 - Behavioral
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

entity Pr9_3 is
    Port ( reset : in STD_LOGIC;
           load : in STD_LOGIC;
           ce : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (1 downto 0);
           clk : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (1 downto 0);
           ceo : out STD_LOGIC;
           tc : out STD_LOGIC);
end Pr9_3;

architecture Behavioral of Pr9_3 is

    signal qt : std_logic_vector (1 downto 0);

begin

    process (clk)
    begin
    
        if (rising_edge (clk)) then
        
            if (reset = '1') then
                qt <= "00";
                
            elsif (load = '1') then
                qt <= din;
                
            elsif (ce <= '0') then
                qt <= qt;
                
            elsif (ce <= '1') then
                qt <= qt + 1;
                
            end if;
        end if;
    end process;
    
    q <= qt;
    tc <= qt(0) and qt(1);
    ceo <= qt (0) and qt (1) and ce;
    
end Behavioral;
