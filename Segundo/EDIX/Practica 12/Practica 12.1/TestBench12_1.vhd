----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2019 15:59:08
-- Design Name: 
-- Module Name: TestBench12_1 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TestBench12_1 is
--  Port ( );
end TestBench12_1;

architecture Behavioral of TestBench12_1 is

    component Pr12_1 is
        Port ( sel : in STD_LOGIC_VECTOR (1 downto 0);
               e1 : in STD_LOGIC_VECTOR (3 downto 0);
               e2 : in STD_LOGIC_VECTOR (3 downto 0);
               e3 : in STD_LOGIC_VECTOR (3 downto 0);
               e4 : in STD_LOGIC_VECTOR (3 downto 0);
               S : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal t_sel : std_logic_vector (1 downto 0);
    signal t_e1, t_e2, t_e3, t_e4, t_S : std_logic_vector (3 downto 0);

begin

    OOUT: Pr12_1 Port Map (sel => t_sel,
                           e1 => t_e1,
                           e2 => t_e2,
                           e3 => t_e3,
                           e4 => t_e4,
                           S => t_S);
                           
    process
    begin
    
        t_e1 <= "0000";
        t_e2 <= "0101";
        t_e3 <= "1010";
        t_e4 <= "1111";
        
        for I in 0 to 3 loop
            t_sel <= std_logic_vector (to_unsigned (I,2));
            wait for 1 us;
        end loop;
        wait;
    
    end process;
end Behavioral;
