----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2019 15:53:00
-- Design Name: 
-- Module Name: Pr9_1 - Behavioral
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

entity Pr9_1 is
    Port ( ce : in STD_LOGIC; --Entrada habilitacion
           clk : in STD_LOGIC;
           jk : in STD_LOGIC_VECTOR(1 downto 0);
           --k : in STD_LOGIC;
           reset : in STD_LOGIC;
           Q : out STD_LOGIC);
end Pr9_1;

architecture Behavioral of Pr9_1 is

signal qt : std_logic :='0'; -- auxiliar para poder hacer qt <= qt

begin

    process (clk, reset, jk)
    begin
        
        if (rising_edge (clk)) then -- entrada habilitacion activa 
         
          if (reset = '1') then -- Si se activa el reset, se pone la salida a 0 independientemente de ce
          qt <= '0';
          elsif (ce = '0') then -- Si no esta activada ce, q se queda en su estado actual
          qt <= qt;
          else case jk is
            when "00" => qt <= qt;
            when "01" => qt <= '0';
            when "10" => qt <= '1';
            when "11" => qt <= not qt;
            when others => qt <= '0';
          end case;
         end if;
       end if;
      
    end process;          
    Q <= qt;
    
end Behavioral;
