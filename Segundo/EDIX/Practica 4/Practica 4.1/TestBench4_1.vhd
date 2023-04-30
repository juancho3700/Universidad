----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2019 17:59:35
-- Design Name: 
-- Module Name: TestBench4_1 - Behavioral
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

entity TestBench4_1 is
--  Port ( );
end TestBench4_1;

architecture Behavioral of TestBench4_1 is

    component Pr4_1 is
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               c : in STD_LOGIC;
               d : in STD_LOGIC;
               Y : out STD_LOGIC);
    end component;
    
    signal t_a, t_b, t_c, t_d, t_Y: STD_LOGIC;
    
begin

    OOUT : Pr4_1 port map (a => t_a,
                           b => t_b,
                           c => t_c,
                           d => t_d,
                           Y => t_Y);
    
    process
    begin
    
        for I in 0 to 15 loop
            (t_a, t_b, t_c, t_d) <= std_logic_vector(to_unsigned(I,4));
            wait for 100 ns;
        end loop;
        wait;
        
    end process;
end Behavioral;
