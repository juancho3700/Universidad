----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2019 18:42:40
-- Design Name: 
-- Module Name: Maquina_estados_simple - Behavioral
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

entity Maquina_estados_simple is
    Port ( clk : in STD_LOGIC;
           A : in STD_LOGIC;
           B : in STD_LOGIC;
           reset : in STD_LOGIC;
           z1 : out STD_LOGIC;
           z2 : out STD_LOGIC;
           estado : out STD_LOGIC_VECTOR (2 downto 0));
end Maquina_estados_simple;

architecture Behavioral of Maquina_estados_simple is

    signal est, sig_est : std_logic_vector (2 downto 0);
    constant est0 : std_logic_vector (2 downto 0) := "000";
    constant est1 : std_logic_vector (2 downto 0) := "001";
    constant est2 : std_logic_vector (2 downto 0) := "010";
    constant est3 : std_logic_vector (2 downto 0) := "011";
    constant est4 : std_logic_vector (2 downto 0) := "100";
    constant est5 : std_logic_vector (2 downto 0) := "101";

begin

    estado <= est;

    proc1 : process (clk, reset, sig_est)
    begin
        
        if (reset = '1') then
            est <= est0;
            
        elsif (rising_edge (clk)) then
            est <= sig_est;
            
        end if;
    end process;
    
    
    proc2 : process (est, A, B)
    begin
    
    sig_est <= est0;
    
    case est is
        when est0 =>
            if (A = '1' and B = '0') then
                sig_est <= est1;
            else 
                sig_est <= est0;
            end if;
            
        when est1 =>
            if (A = '0' and B = '0') then
                sig_est <= est2;
            elsif (A = '0' and B = '1') then
                sig_est <= est4;
            else
                sig_est <= est1;
            end if;
            
        when est2 =>
            if (A = '0' and B = '1') then
                sig_est <= est3;
            else 
                sig_est <= est2;
            end if;
            
        when est3 =>
            if (A = '1' and B = '0') then
                sig_est <= est5;
            elsif (A = '1' and B = '1') then
                sig_est <= est0;
            else
                sig_est <= est3;
            end if;
            
        when est4 =>
            if (A = '1') then
                sig_est <= est5;
            else
                sig_est <= est4;
            end if;
        
        when est5 =>
            if (A = '0') then
                sig_est <= est0;
            else 
                sig_est <= est5;
            end if;
        
        when others =>
            sig_est <= est0;
            
        end case;
    end process;
    
    
    proc3 : process (est)
    begin
    
        case est is
            when est0 =>
                z1 <= '0';
                z2 <= '0';
            when est1 =>
                z1 <= '1';
                z2 <= '0';
            when est2 =>
                z1 <= '0';
                z2 <= '1';
            when est3 =>
                z1 <= '1';
                z2 <= '0';
            when est4 =>
                z1 <= '0';
                z2 <= '1';
            when est5 =>
                z1 <= '1';
                z2 <= '0';
            when others =>
                z1 <= '0';
                z2 <= '0';
            
        end case;    
    end process;
end Behavioral;
