----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2019 14:10:11
-- Design Name: 
-- Module Name: reg_desplazamiento_derecha_8_bits - Behavioral
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

entity reg_desplazamiento_derecha_8_bits is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           load : in  STD_LOGIC;
           msb_in : in  STD_LOGIC;
           shift_enable : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           lsb_out : out  STD_LOGIC;
           q_shift : out  STD_LOGIC_VECTOR (7 downto 0));
end reg_desplazamiento_derecha_8_bits;

architecture Behavioral of reg_desplazamiento_derecha_8_bits is
signal q_aux : STD_LOGIC_VECTOR (7 downto 0);
begin
	q_shift<=q_aux;
	process(clk,reset,q_aux,load,shift_enable,msb_in)
		begin
		if rising_edge(clk) then
			if reset='1' then
				q_aux<="00000000";
			elsif load='1' then
				  q_aux<=data_in;
				  elsif shift_enable='0' then
						q_aux<=q_aux;
					    else
					    q_aux<=msb_in & q_aux(7 downto 1);
								
			      end if;
		   end if;
	end process;
	lsb_out<=q_aux(0);
end Behavioral;

