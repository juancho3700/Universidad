----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2019 10:57:42
-- Design Name: 
-- Module Name: TestBnch5_1 - Behavioral
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

entity TestBnch5_1 is
--  Port ( );
end TestBnch5_1;

architecture Behavioral of TestBnch5_1 is

    component Pr5_1 is
        Port ( a: in STD_LOGIC_VECTOR (3 downto 0);
               f1: out STD_LOGIC;
               f2: out STD_LOGIC;
               f3: out STD_LOGIC);
    end component;
    
    signal t_a: std_logic_vector (3 downto 0);
    signal t_f1, t_f2, t_f3: std_logic;

begin

    OOUT: Pr5_1 port map (a => t_a,
                          f1 => t_f1,
                          f2 => t_f2,
                          f3 => t_f3);

    process
    begin
    
        for I in 0 to 9 loop
            t_a <= std_logic_vector (to_unsigned (I,4));
            wait for 100 ns;
        end loop;
        wait;

    end process;
end Behavioral;
