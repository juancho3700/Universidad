----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2019 22:56:35
-- Design Name: 
-- Module Name: TestBench4_2 - Behavioral
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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TestBench4_2 is
--  Port ( );
end TestBench4_2;

architecture Behavioral of TestBench4_2 is

component Pr4_2 is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           R : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal t_A, t_B: STD_LOGIC_VECTOR (1 downto 0);
signal t_R: STD_LOGIC_VECTOR (2 downto 0);

begin

    OOUT: Pr4_2 port map (A => t_A,
                          B => t_B,
                          R => t_R);

process
begin

    for I in 0 to 3 loop
        t_A <= std_logic_vector (to_unsigned(I,2));
        for J in 0 to 3 loop
            t_B <= std_logic_vector (to_unsigned(J,2));
            wait for 100 us;
        end loop;
    end loop;
    wait;
        
end process;
end Behavioral;
