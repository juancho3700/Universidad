----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2019 12:00:12
-- Design Name: 
-- Module Name: TestBench6_1 - Behavioral
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

entity TestBench6_1 is
--  Port ( );
end TestBench6_1;

architecture Behavioral of TestBench6_1 is

    component Pr6_1 is
    Port ( G : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal t_G: std_logic;
    signal t_d: std_logic_vector (1 downto 0);
    signal t_q: std_logic_vector (3 downto 0);

begin

    OOUT: Pr6_1 port map (G => t_G,
                          d => t_d,
                          q => t_q);

    process
    begin
        t_G <= '0';
        
        for I in 0 to 3 loop
            t_d <= std_logic_vector (to_unsigned (I,2));
            wait for 1 us;
        end loop;
        
        t_G <= '1';
        
        for I in 0 to 3 loop
            t_d <= std_logic_vector (to_unsigned (I,2));
            wait for 1 us;
        end loop;
        wait;
        
    end process;
end Behavioral;
