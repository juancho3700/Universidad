----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2019 14:19:41
-- Design Name: 
-- Module Name: TestBench_c_a2 - Behavioral
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

entity TestBench_c_a2 is
--  Port ( );
end TestBench_c_a2;

architecture Behavioral of TestBench_c_a2 is

    component Compl_a2 is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               c_a2 : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal t_a, t_ca2: std_logic_vector (3 downto 0);

begin

    CCA2: Compl_a2 port map (a => t_a,
                             c_a2 => t_ca2);
                             
    process
    begin
    
    for I in 0 to 15 loop
        t_a <= std_logic_vector (to_unsigned (I,4));
        wait for 1 us;
    end loop;
    wait;
    
    end process;
end Behavioral;
