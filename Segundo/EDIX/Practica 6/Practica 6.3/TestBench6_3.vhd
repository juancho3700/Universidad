----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2019 12:02:29
-- Design Name: 
-- Module Name: TestBench6_3 - Behavioral
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

entity TestBench6_3 is
--  Port ( );
end TestBench6_3;

architecture Behavioral of TestBench6_3 is

    component Pr6_3 is
        Port ( DIN : in STD_LOGIC_VECTOR (3 downto 0);
               dp_in : in STD_LOGIC;
               en : in STD_LOGIC;
               DP : out STD_LOGIC;
               S : out STD_LOGIC_VECTOR (6 downto 0);
               an0, an1, an2, an3: out STD_LOGIC);
    end component;

    signal t_DIN: STD_LOGIC_VECTOR (3 downto 0);
    signal t_dp_in, t_en, t_DP, t_an0, t_an1, t_an2, t_an3: STD_LOGIC;
    signal t_S: STD_LOGIC_VECTOR (6 downto 0);

begin

    OOUT: Pr6_3 port map (DIN => t_DIN,
                          dp_in => t_dp_in,
                          en => t_en,
                          DP => t_DP,
                          S => t_S,
                          an0 => t_an0,
                          an1 => t_an1,
                          an2 => t_an2,
                          an3 => t_an3);

    process
    begin
    
        for I in 0 to 3 loop
            (t_en, t_dp_in) <= std_logic_vector (to_unsigned (I,2));
            for J in 0 to 15 loop
                t_DIN <= std_logic_vector (to_unsigned (J,4));
                wait for 1 us;
            end loop;
        end loop;    
        wait;
        
    end process;
end Behavioral;
