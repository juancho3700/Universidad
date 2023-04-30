----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2019 16:10:36
-- Design Name: 
-- Module Name: TestBench9_1 - Behavioral
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

entity TestBench9_1 is
--  Port ( );
end TestBench9_1;

architecture Behavioral of TestBench9_1 is

    component Pr9_1 is
        Port ( ce : in STD_LOGIC;
               clk : in STD_LOGIC;
               jk : in STD_LOGIC_VECTOR(1 downto 0);
               reset : in STD_LOGIC;
               q : out STD_LOGIC);
    end component;
    
    signal t_ce,t_clk,t_reset : std_logic := '0';
    signal t_jk : std_logic_vector (1 downto 0) := "00";
    signal t_q : std_logic;
    constant clk_per : time := 1us;
    
begin

    OOUT: Pr9_1 port map (ce => t_ce,
                          clk => t_clk,
                          jk => t_jk,
                          reset => t_reset,
                          q => t_q); 

    clk_process :process
    begin
    
        t_clk <= '1';
        wait for clk_per / 2;
        t_clk <= '0';
        wait for clk_per / 2;
        
    end process;
    
    proceso: process
    begin 
     
        t_reset <= '1';
        t_ce <= '0'; 
        t_jk <= "00";
        wait for clk_per;
        
        t_reset <= '0';
        t_ce <= '0';
        wait for 2 * clk_per;
             
        t_ce <= '1';    
        for I in 0 to 3 loop
            (t_jk) <= std_logic_vector (to_unsigned (I,2));
            wait for clk_per;
        end loop;
        
        wait for clk_per;
        
        t_reset <= '1';
        t_jk <= "00";
        wait for clk_per;
        
 assert (false) report "Fin_simulacion" severity FAILURE;

    end process;
    
end Behavioral;
