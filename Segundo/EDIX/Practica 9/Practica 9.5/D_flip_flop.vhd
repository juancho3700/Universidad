----------------------------------------------------------------------------------
-- Company: University of Vigo
-- Engineer: Luis Jacobo Alvarez Ruiz de Ojeda
--
-- Create Date:    17:57:59 11/27/2007
-- Module Name:    D_flip_flop - Behavioral
-- Target Devices: all
-- Tool versions: ISE 8.2
-- Description: D_flip_flop with CE, asynchronous reset ("async_reset") and synchronous reset ("sync_reset")
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity D_flip_flop is
    Port ( clk : in  STD_LOGIC; -- global clock
           async_reset : in  STD_LOGIC; -- global asynchronous reset
           sync_reset : in  STD_LOGIC; -- synchronous reset
           ce : in  STD_LOGIC; -- clock enable
           d : in std_logic; -- data input
           q : out std_logic -- data output
           );
end D_flip_flop;

architecture Behavioral of D_flip_flop is

begin

  process (clk, ce, async_reset, sync_reset, d)
  begin
    if async_reset='1' then
      q <= '0'; -- Asynchronous reset

    elsif (clk'event and clk='1') then

      if sync_reset='1' then
        q <= '0'; -- Synchronous reset

      elsif ce = '1' then
        q <= d;		-- Synchronous input

      end if;
    end if;
  end process;
end Behavioral;
