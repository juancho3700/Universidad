----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2019 19:01:21
-- Design Name: 
-- Module Name: test_Pr10_3 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_Pr10_3 is
--  Port ( );
end test_Pr10_3;

architecture Behavioral of test_Pr10_3 is
component control_motor is
 Port (    CLK : in  STD_LOGIC;
           MARCHA : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           SENTIDO : in  STD_LOGIC;
           ESTADO : out  STD_LOGIC_VECTOR (3 downto 0);
           A : out  STD_LOGIC;
           B : out  STD_LOGIC;
           C : out  STD_LOGIC;
           D : out  STD_LOGIC);
end component;

signal t_CLK,t_MARCHA,t_RESET,t_SENTIDO,t_A,t_B,t_C,t_D : STD_LOGIC; 
signal t_ESTADO : STD_LOGIC_VECTOR (3 downto 0);
constant clk_period : time := 1 us;

begin


    OOUT: control_motor port map(  CLK=>t_CLK,
                                   MARCHA=>t_MARCHA,
                                   RESET=>t_RESET,
                                   SENTIDO=>t_SENTIDO,
                                   ESTADO=>t_ESTADO,
                                   A=>t_A,
                                   B=>t_B,
                                   C=>t_C,
                                   D=>t_D);
    
    clk_process: process
    begin
                t_CLK<='0';
                wait for clk_period/2;
                t_CLK<='1';
                wait for clk_period/2;
    end process;
    
   process
   begin	
        --s0	
        t_RESET<='1';
              
		t_MARCHA<='0';
		t_SENTIDO<='0';
         wait for  clk_period;	
        --s0
		t_RESET<='0';	
			
		t_MARCHA<='0';
		t_SENTIDO<='0';
        wait for  clk_period;
        --s1--s4    
		t_MARCHA<='1';
		t_SENTIDO<='0';
        wait for  5*clk_period;
        --s1--s4		
		t_MARCHA<='0';
		t_SENTIDO<='0';
        wait for  4*clk_period;
        --s0     
		t_MARCHA<='0';
		t_SENTIDO<='0';
        wait for  clk_period;
        --s5-s8		
		t_MARCHA<='1';
		t_SENTIDO<='1';
         wait for  5*clk_period;
         --s5-s8		
		t_MARCHA<='0';
		t_SENTIDO<='1';
         wait for  4*clk_period;
        --s0		
		t_MARCHA<='0';
		t_SENTIDO<='0';
      wait for  clk_period;
      
	  assert (false) report "Fin_simulacion" severity FAILURE;
		     
   end process;


end Behavioral;
