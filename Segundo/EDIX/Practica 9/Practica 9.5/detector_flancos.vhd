-- Detector de flancos
-- Activa sus salidas durante un ciclo de reloj cuando la ent
-- presenta un flanco ascendente (fa), descendente (fd) o cualquiera
-- de los dos (f)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity detector_flancos is
    Port ( ent : in std_logic;
           clk : in std_logic;
           reset : in std_logic;
           fa_ent : out std_logic; -- flanco ascendente
           fd_ent : out std_logic; -- flanco descendente
           f_ent : out std_logic;	  -- cualquier flanco
           ent_s : out std_logic); -- variable sincronizada
end detector_flancos;

architecture Behavioral of detector_flancos is

signal ent_t_1: std_logic:='0';
signal fa_ent_aux : std_logic:='0'; -- flanco ascendente
signal fd_ent_aux : std_logic:='0'; -- flanco descendente
signal ent_s_aux : std_logic:='0'; -- variable sincronizada

begin

fa_ent <= fa_ent_aux;
fd_ent <= fd_ent_aux;
ent_s <= ent_s_aux;


process (reset,clk,ent_s_aux,ent_t_1,ent)
begin
	if reset = '1' then 	ent_s_aux <= '0';
								ent_t_1 <= '0';
	elsif clk = '1' and clk'event then ent_t_1 <= ent_s_aux;
												ent_s_aux <= ent;
	end if;

	fa_ent_aux <= ent_s_aux and not ent_t_1;
	fd_ent_aux <= not ent_s_aux and ent_t_1;
	f_ent <= fa_ent_aux or fd_ent_aux;

end process;

end Behavioral;
