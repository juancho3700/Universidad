----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2019 16:48:15
-- Design Name: 
-- Module Name: Pr9_2 - Behavioral
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

entity Reg_filas is
    Port ( reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           clk : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (1 downto 0);
           Q : out STD_LOGIC_VECTOR (1 downto 0));
end Reg_filas;

architecture Reg_filas of Reg_filas is

    signal Q_aux : std_logic_vector (1 downto 0) := "00";

begin

    process (reset, clk, d)
    begin
    
        if (clk'event and clk = '1') then
            if (reset = '1') then
                Q_aux <= "00";
            elsif (ce = '0') then
                Q_aux <= q_aux;
            else Q_aux <= d;
            end if;
        end if;
        
    end process;
    Q <= Q_aux;

end Reg_filas;
