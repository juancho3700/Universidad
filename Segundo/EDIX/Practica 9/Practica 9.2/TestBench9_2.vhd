----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2019 17:02:58
-- Design Name: 
-- Module Name: TestBench9_2 - Behavioral
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

entity TestBench9_2 is
--  Port ( );
end TestBench9_2;

architecture Behavioral of TestBench9_2 is

    component Pr9_2 is
        Port ( reset : in STD_LOGIC;
               ce : in STD_LOGIC;
               clk : in STD_LOGIC;
               d : in STD_LOGIC_VECTOR (3 downto 0);
               Q : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal t_reset, t_ce, t_clk: std_logic := '0';
    signal t_d, t_Q: std_logic_vector (3 downto 0) := "0000";
    signal clk_per: time := 1 us;

begin

    OOUT: Pr9_2 Port Map (reset => t_reset,
                          ce => t_ce,
                          clk => t_clk,
                          d => t_d,
                          Q => t_Q);
    
    clk_proc: process
    begin
    
        t_clk <= '1';
        wait for clk_per / 2;
        t_clk <= '0';
        wait for clk_per / 2;
    
    end process;
                          
    proceso: process
    begin
    
        t_reset <= '1';
        wait for clk_per;
        
        t_reset <= '0';
        wait for clk_per;
        
        t_ce <= '1';
        for I in 0 to 15 loop
            t_d <= std_logic_vector (to_unsigned (I,4));
            wait for clk_per;
        end loop;
        
        t_reset <= '1';
        wait for clk_per;
        
        assert (false) report "Fin_simulacion" severity FAILURE;
    
    end process;
end Behavioral;
