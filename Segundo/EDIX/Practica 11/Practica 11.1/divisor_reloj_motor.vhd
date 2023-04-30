-- Divisor de reloj para el motor paso a paso
-- Se trata de obtener a la salida una señal cuadrada de una frecuencia de 50 Hz
-- Con una frecuencia de reloj de entrada de 100 MHz, hay que dividir por 2.000.000

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divisor_reloj_motor is
    Port ( clkin : in std_logic;
           clkout : out std_logic;
           reset : in std_logic);
end divisor_reloj_motor;

architecture divisor_reloj_motor of divisor_reloj_motor is

signal count: integer range 0 to 999999 := 0; -- Hay que dividir por 1.000.000 para tener una señal cuadrada
signal clkout_aux: std_logic:='0';

begin

clkout <= clkout_aux;

process (reset,clkin)
begin
	if reset = '1' then clkout_aux <='0';
								count <= 0;
 	elsif
		clkin='1' and clkin'event then
			if count = 999999 then clkout_aux <= not clkout_aux;
									 count <= 0;
			else count <= count+1;
			end if;
	end if;
end process;
end divisor_reloj_motor;
