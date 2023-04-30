----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.09.2019 16:28:26
-- Design Name: 
-- Module Name: TestBench2_2 - Behavioral
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

entity TestBench2_2 is
--  Port ( );
end TestBench2_2;

architecture Behavioral of TestBench2_2 is

    component Pr2_2 is
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               c : in STD_LOGIC;
               d : IN STD_LOGIC;
               y : out STD_LOGIC);
    end component;

    signal t_a, t_b, t_c, t_d, t_y: STD_LOGIC;

begin

    UUT:Pr2_2 port map (a => t_a,
                        b => t_b,
                        c => t_c,
                        d => t_d,
                        y => t_y);

    process
    begin
        
        for I in 0 to 15 loop
            (t_a, t_b, t_c, t_d) <= std_logic_vector(to_unsigned(I,4));
            wait for 100 ns;
        end loop;
        wait;
        
    end process;
end Behavioral;
