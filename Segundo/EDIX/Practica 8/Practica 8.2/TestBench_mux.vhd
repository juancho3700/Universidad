----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2019 14:27:16
-- Design Name: 
-- Module Name: TestBench_mux - Behavioral
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

entity TestBench_mux is
--  Port ( );
end TestBench_mux;

architecture Behavioral of TestBench_mux is

    component MUX is
        Port ( p_and : in STD_LOGIC_VECTOR (7 downto 0);
               c_a2 : in STD_LOGIC_VECTOR (7 downto 0);
               resta : in STD_LOGIC_VECTOR (7 downto 0);
               prod : in STD_LOGIC_VECTOR (7 downto 0);
               sel : in STD_LOGIC_VECTOR (1 downto 0);
               Y : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal t_p_and, t_c_a2, t_resta, t_prod, t_Y: std_logic_vector (7 downto 0);
    signal t_sel: std_logic_vector (1 downto 0);

begin

    MMUX: MUX port map (p_and => t_p_and,
                        c_a2 => t_c_a2,
                        resta => t_resta,
                        prod => t_prod,
                        sel => t_sel,
                        Y => t_Y);
                        
    process
    begin
    
    t_p_and <= "00000000";
    t_c_a2 <= "00001111";
    t_resta <= "00110011";
    t_prod <= "01010101";
    
    for I in 0 to 3 loop
        t_sel <= std_logic_vector (to_unsigned (I,2));
        wait for 1 us;
    end loop;
    wait;
    
    end process;

end Behavioral;
