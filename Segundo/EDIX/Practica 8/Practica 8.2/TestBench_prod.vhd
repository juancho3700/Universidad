----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2019 11:52:48
-- Design Name: 
-- Module Name: TestBench_prod - Behavioral
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

entity TestBench_prod is
--  Port ( );
end TestBench_prod;

architecture Behavioral of TestBench_prod is

    component Prod is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               b : in STD_LOGIC_VECTOR (3 downto 0);
               res : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal t_a, t_b: std_logic_vector (3 downto 0);
    signal t_res: std_logic_vector (7 downto 0);

begin

    PPROD: Prod port map (a => t_a,
                          b => t_b,
                          res => t_res);

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
