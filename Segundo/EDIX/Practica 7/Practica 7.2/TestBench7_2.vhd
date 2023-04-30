----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 10:44:30
-- Design Name: 
-- Module Name: TestBench7_2 - Behavioral
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

entity TestBench7_2 is
--  Port ( );
end TestBench7_2;

architecture Behavioral of TestBench7_2 is

    component Pr7_2 is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               b : in STD_LOGIC_VECTOR (3 downto 0);
               AiB : out STD_LOGIC;
               AmaB : out STD_LOGIC;
               AmeB : out STD_LOGIC);
    end component;

    signal t_a, t_b: std_logic_vector (3 downto 0);
    signal t_AiB, t_AmaB, t_AmeB: std_logic;

begin

    OOUT: Pr7_2 port map (a => t_a,
                          b => t_b,
                          AiB => t_AiB,
                          AmaB => t_AmaB,
                          AmeB => t_AmeB);

    process
    begin
         t_b <= "1100";
        for I in 0 to 15 loop
          t_a <= std_logic_vector (to_unsigned (I,4));
            wait for 1 us;
        end loop;
        
        t_a <= "0011";
        for I in 0 to 15 loop
          t_b <= std_logic_vector (to_unsigned (I,4));
            wait for 1 us;
        end loop;
        wait;

    end process;
end Behavioral;
