----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2019 15:36:43
-- Design Name: 
-- Module Name: TestBench8_2 - Behavioral
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

entity TestBench8_2 is
--  Port ( );
end TestBench8_2;

architecture Behavioral of TestBench8_2 is

    component Alu is
        Port ( entrada1 : in STD_LOGIC_VECTOR (3 downto 0);
               entrada2 : in STD_LOGIC_VECTOR (3 downto 0);
               selector : in STD_LOGIC_VECTOR (1 downto 0);
               salida : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal t_a, t_b: std_logic_vector (3 downto 0);
    signal t_sel: std_logic_vector (1 downto 0);
    signal t_s: std_logic_vector (7 downto 0);

begin

    OOUT: Alu port map (entrada1 => t_a,
                        entrada2 => t_b,
                        selector => t_sel,
                        salida => t_s);
                          
    process
    begin
    
    t_sel <= "00";
        t_a <= "0000";
        t_b <= "1111";
        wait for 1 us;
        
        t_a <= "1010";
        t_b <= "0101";
        wait for 1 us;
        
        t_a <= "1111";
        t_b <= "1111";
        wait for 1 us;
    
    t_sel <= "01";
        t_b <= "0000";
        for I in 0 to 15 loop
            t_a <= std_logic_vector (to_unsigned (I,4));
            wait for 1 us;
        end loop;
    
    t_sel <= "10";
        t_b <= "1001";
        for I in 0 to 15 loop
            t_a <= std_logic_vector (to_unsigned (I,4));
            wait for 1 us;
        end loop;
        
        t_a <= "0011";
        for I in 0 to 15 loop
            t_b <= std_logic_vector (to_unsigned (I,4));
            wait for 1 us;
        end loop;
    
    t_sel <= "11";
        t_b <= "1010";
        for I in 0 to 15 loop
            t_a <= std_logic_vector (to_unsigned (I,4));
            wait for 1 us;
        end loop;
        
        t_a <= "0101";
        for I in 0 to 15 loop
            t_b <= std_logic_vector (to_unsigned (I,4));
            wait for 1 us;
        end loop;
    
    wait;
    end process;
    
end Behavioral;
