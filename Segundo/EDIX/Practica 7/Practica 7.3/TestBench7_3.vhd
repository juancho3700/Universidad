----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 14:50:02
-- Design Name: 
-- Module Name: TestBench7_3 - Behavioral
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

entity TestBench7_3 is
--  Port ( );
end TestBench7_3;

architecture Behavioral of TestBench7_3 is

    component Pr7_3 is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               b : in STD_LOGIC_VECTOR (3 downto 0);
               suma : out STD_LOGIC_VECTOR (4 downto 0));
    end component;

    signal t_a, t_b: std_logic_vector (3 downto 0);
    signal t_suma: std_logic_vector (4 downto 0);

begin  

    OOUT: Pr7_3 port map (a => t_a,
                          b => t_b,
                          suma => t_suma);

    process
    begin
    
        for I in 0 to 15 loop
            t_a <= std_logic_vector (to_unsigned (I,4));
            for J in 0 to 15 loop
                t_b <= std_logic_vector (to_unsigned (J,4));
                wait for 1 us;
            end loop;
        end loop;
        wait;
    
    end process;

end Behavioral;
