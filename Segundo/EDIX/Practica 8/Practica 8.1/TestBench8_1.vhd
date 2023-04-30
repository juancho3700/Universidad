----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2019 15:02:10
-- Design Name: 
-- Module Name: TestBench8_1 - Behavioral
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

entity TestBench8_1 is
--  Port ( );
end TestBench8_1;

architecture Behavioral of TestBench8_1 is

    component Pr8_1 is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               b : in STD_LOGIC_VECTOR (3 downto 0);
               res : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal t_a, t_b: std_logic_vector (3 downto 0);
    signal t_res: std_logic_vector (7 downto 0);

begin

    OOUT: Pr8_1 port map (a => t_a,
                          b => t_b,
                          res => t_res);
                          
    process
    begin
    
        t_b <= "1010";
        for I in 0 to 15 loop
            t_a <= std_logic_vector (to_unsigned (I,4));
            wait for 1 us;
        end loop;
        
        t_A <= "0101";
        for I in 0 to 15 loop
            t_B <= std_logic_vector (to_unsigned (I,4));
            wait for 1 us;
        end loop;
        wait;
    
    end process;
end Behavioral;
