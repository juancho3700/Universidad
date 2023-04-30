----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2019 11:54:20
-- Design Name: 
-- Module Name: test_Maq_Estados - Behavioral
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

entity Maquina_Estados_tb is
--  Port ( );
end Maquina_Estados_tb;

architecture Behavioral of Maquina_Estados_tb is

 component Maquina_Estados
    port( clk : in std_logic;
          reset : in std_logic;
          ROW1 : in std_logic;
          ROW2 : in std_logic;
          ROW3 : in std_logic;
          ROW4 : in std_logic;
          En_Cont_Col : out std_logic;
          En_Reg_Col : out std_logic;
          En_Reg_Fil : out std_logic;
          Fila_Act : out std_logic_vector(1 downto 0));
    end component;
    
   signal t_clk, t_reset, t_ROW1, t_ROW2, t_ROW3, t_ROW4 : std_logic := '0';
   signal t_En_Cont_Col, t_En_Reg_Col, t_En_Reg_Fil : std_logic;
   signal t_Fila_Act : std_logic_vector(1 downto 0);  
   constant clk_per : time := 1 us;
        
begin

 OOUT: Maquina_Estados port map (clk => t_clk,
                                 reset => t_reset,
                                 ROW1 => t_ROW1,
                                 ROW2 => t_ROW2,
                                 ROW3 => t_ROW3,
                                 ROW4 => t_ROW4,
                                 En_Cont_Col => t_En_Cont_Col,
                                 En_Reg_Col => t_En_Reg_Col,
                                 En_Reg_Fil => t_En_Reg_Fil,
                                 Fila_Act => t_Fila_Act);

    clk_process: process
    begin
                t_clk <= '0';
                wait for clk_per / 2;
                t_clk <= '1';
                wait for clk_per / 2;
    end process;

   process
   begin		
		t_reset <= '1';
	    t_ROW1 <= '1';
        t_ROW2 <= '1';
        t_ROW3 <= '1';
        t_ROW4 <= '1';
		wait for clk_per;
		
		t_reset <= '0';
		wait for 6*clk_per;
		
		t_ROW1 <= '0';
		wait for 2*clk_per;
		
		t_ROW1 <= '1';
		wait for 6*clk_per;
		
		t_ROW1 <= '0';
		wait for 2*clk_per;
		
		t_ROW1 <= '1';
		t_ROW2 <= '0';
		wait for 4*clk_per;

		t_ROW2 <= '1';
		t_ROW3 <= '0';
		wait for 5*clk_per;		 
		
		t_ROW3 <= '1';
		t_ROW4 <= '0';
		wait for 8*clk_per;
			
		assert (false) report "Fin simulacion" severity FAILURE;
		
   end process;
end Behavioral;
