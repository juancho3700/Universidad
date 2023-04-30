----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2019 14:11:47
-- Design Name: 
-- Module Name: test_reg - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_reg is
--  Port ( );
end test_reg;

architecture Behavioral of test_reg is
 
 
    COMPONENT reg_desplazamiento_derecha_8_bits is
    port(  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           msb_in : in  STD_LOGIC;
           shift_enable : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           lsb_out : out  STD_LOGIC;
           q_shift : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

   signal t_clk,t_msb_in,t_shift_enable,t_reset,t_load,t_lsb_out :  STD_LOGIC := '0';
   signal t_data_in : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
   signal t_q_shift : STD_LOGIC_VECTOR(7 downto 0);
   constant clk_period : time := 1 us;
 
begin

   OOUT: reg_desplazamiento_derecha_8_bits port map(
          clk => t_clk,
          reset => t_reset,
          load => t_load,
          msb_in => t_msb_in,
          shift_enable => t_shift_enable,
          data_in => t_data_in,
          lsb_out => t_lsb_out,
          q_shift => t_q_shift
        );

   clk_process :process
   begin
		t_clk <= '0';
		wait for clk_period/2;
		t_clk <= '1';
		wait for clk_period/2;
		
   end process;

   stim_proc: process
   begin		
		t_reset<='1';
		t_load<='0';
		t_msb_in<='0';
		t_shift_enable<='0';
		t_data_in<="00000000";
		wait for clk_period;
		
		t_reset<='0';
		t_shift_enable<='0';
		t_load<='0';
		wait for 3*clk_period;
		
		t_shift_enable<='0';
		t_load<='1';
		t_data_in<="10101010";
		wait for clk_period;
		
		t_shift_enable<='1';
		t_load<='0';
		t_msb_in<='0';
		wait for 10*clk_period;
		t_msb_in<='1';
		wait for 10*clk_period;
		
		t_reset<='1';
		t_msb_in<='0';
		t_shift_enable<='0';
		t_data_in<="00000000";
		wait for clk_period;
		 assert (false) report "Fin_simulacion" severity FAILURE;
   end process;


end Behavioral;
