--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:56:34 05/31/2019
-- Design Name:   
-- Module Name:   F:/Mis_circuitos/ISE_2019/EDIX/generacion_plantillas/testbench_divisor_reloj_motor.vhd
-- Project Name:  generacion_plantillas
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: divisor_reloj_motor
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench_divisor_reloj_motor IS
END testbench_divisor_reloj_motor;
 
ARCHITECTURE behavior OF testbench_divisor_reloj_motor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT divisor_reloj_motor
    PORT(
         clkin : IN  std_logic;
         clkout : OUT  std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clkin : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal clkout : std_logic;

   -- Clock period definitions
   constant clkin_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: divisor_reloj_motor PORT MAP (
          clkin => clkin,
          clkout => clkout,
          reset => reset
        );

   -- Clock process definitions
   clkin_process :process
   begin
		clkin <= '0';
		wait for clkin_period/2;
		clkin <= '1';
		wait for clkin_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '1';
      wait for clk_period;
		
		reset <= '0';
      wait for 10000000 *clk_period;		

		-- Esta instrucción es para detener la simulación cuando
		-- se ejecuta run -all
		assert (false) report "Fin simulacion" severity FAILURE;

      wait;
   end process;

END;
