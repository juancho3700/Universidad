----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2019 21:19:59
-- Design Name: 
-- Module Name: Det_flancos - Detector
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

entity Det_flancos is
    Port ( ent : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           fa_ent : out STD_LOGIC;
           fd_ent : out STD_LOGIC;
           f_ent : out STD_LOGIC;
           ent_s : out STD_LOGIC);
end Det_flancos;

architecture Detector of Det_flancos is

    signal fa_ent_aux, ent_t1, ent_s_aux, fd_ent_aux : std_logic := '0';

begin

    fa_ent <= fa_ent_aux;
    fd_ent <= fd_ent_aux;
    ent_s <= ent_s_aux;
    
    process (reset, clk, ent)
    begin
        if reset = '1' then
            ent_s_aux <= '0';
            ent_t1 <= '0';
        elsif clk = '1' and clk'event then
            ent_t1 <= ent_s_aux;
            ent_s_aux <= ent;
        end if;
        
        fa_ent_aux <= ent_s_aux and not ent_t1;
        fd_ent_aux <= not ent_s_aux and ent_t1;
        f_ent <= fa_ent_aux or fd_ent_aux;
    
    end process;
end Detector;
