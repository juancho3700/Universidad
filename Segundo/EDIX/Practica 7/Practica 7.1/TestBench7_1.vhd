----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2019 09:46:46
-- Design Name: 
-- Module Name: TestBench7_1 - Behavioral
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

entity TestBench7_1 is
--  Port ( );
end TestBench7_1;

architecture Behavioral of TestBench7_1 is

component Pr7_1 is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           S : out STD_LOGIC);
end component;

signal t_a, t_b, t_Cin, t_Cout, t_S: std_logic;

begin

    OOUT: Pr7_1 port map (a => t_a,
                          b => t_b,
                          Cin => t_Cin,
                          Cout => t_Cout,
                          S => t_S);

process
begin

    for I in 0 to 7 loop
        (t_a, t_b, t_Cin) <= std_logic_vector (to_unsigned (I,3));
        wait for 1 us;
    end loop;
    wait;

end process;
end Behavioral;
