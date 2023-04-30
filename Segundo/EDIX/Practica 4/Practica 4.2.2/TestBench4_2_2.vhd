----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.10.2019 11:30:32
-- Design Name: 
-- Module Name: TestBench4_2_2 - Behavioral
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

entity TestBench4_2_2 is
--  Port ( );
end TestBench4_2_2;

architecture Behavioral of TestBench4_2_2 is

component Pr4_2_2 is
    Port ( a : in STD_LOGIC_VECTOR (1 downto 0);
           b : in STD_LOGIC_VECTOR (1 downto 0);
           S0 : out STD_LOGIC;
           S1 : out STD_LOGIC;
           S2 : out STD_LOGIC);
end component;

signal t_a, t_b: std_logic_vector (1 downto 0);
signal t_S0, t_S1, t_S2: std_logic;

begin

    OOUT: Pr4_2_2 port map (a => t_a,
                            b => t_b,
                            S0 => t_S0,
                            S1 => t_S1,
                            S2 => t_S2);
    
    process
    begin
        for I in 0 to 3 loop
            t_a <= std_logic_vector (to_unsigned (I,2));
            for J in 0 to 3 loop
                t_b <= std_logic_vector (to_unsigned (J,2));
                wait for 100 ns;
            end loop;
        end loop;
        wait;
    end process;
end Behavioral;
