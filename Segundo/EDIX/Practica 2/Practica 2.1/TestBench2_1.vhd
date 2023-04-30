----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.09.2019 11:31:54
-- Design Name: 
-- Module Name: TestBench2_1 - Behavioral
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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TestBench2_1 is
--  Port ( );
end TestBench2_1;

architecture Behavioral of TestBench2_1 is
    -- Declaración del componente a probar
    component Pr2_1 is
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               c : in STD_LOGIC;
               y : out STD_LOGIC);
    end component;

    -- Declaración señales interconexion
    signal t_a,t_b,t_c,t_y: STD_LOGIC;
    
begin

    -- Declaracion asignación puertos-señales
    UUT:Pr2_1 port map (a => t_a,
                        b => t_b,
                        c => t_c,
                        y => t_y);

    -- Aplicación de estímulos
    
    process
    begin
    
--        t_a <= '1';
--        t_b <= '0';
--        t_c <= '0';
--        wait for 100 ns; 
    
--        t_a <= '1';
--        t_b <= '1';
--        t_c <= '0';
--        wait;
        for I in 0 to 7 loop
             -- Pasa el entero I a binario con 3 bits
            (t_a,t_b,t_c) <=std_logic_vector(to_unsigned(I,3));
            wait for 100 ns;
        end loop;
        wait;
    end process;
end Behavioral;
