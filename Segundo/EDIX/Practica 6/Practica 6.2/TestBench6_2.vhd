----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2019 16:50:53
-- Design Name: 
-- Module Name: TestBench6_2 - Behavioral
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

entity TestBench6_2 is
--  Port ( );
end TestBench6_2;

architecture Behavioral of TestBench6_2 is

    component Pr6_2 is
        Port ( G : in STD_LOGIC;
               s : in STD_LOGIC_VECTOR (1 downto 0);
               d0, d1, d2, d3: in STD_LOGIC;
               Q : out STD_LOGIC);
    end component;
    
    signal t_d0, t_d1, t_d2, t_d3, t_G, t_Q: STD_LOGIC;
    signal t_s: STD_LOGIC_VECTOR (1 downto 0);
    
begin
    
    OOUT: Pr6_2 port map (G => t_G,
                          s => t_s,
                          Q => t_Q,
                          d0 => t_d0,
                          d1 => t_d1,
                          d2 => t_d2,
                          d3 => t_d3);

    process
    begin

        for I in 0 to 7 loop
            (t_G, t_s(1), t_s(0)) <= std_logic_vector (to_unsigned(I,3));
                for J in 0 to 15 loop
                    (t_d3, t_d2, t_d1, t_d0) <= std_logic_vector (to_unsigned (J,4));
                    wait for 1 us;
                end loop;
            wait for 1 us;
        end loop;
        wait;

    end process;
end Behavioral;
