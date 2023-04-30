----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2019 19:29:40
-- Design Name: 
-- Module Name: TestBench_Maquina_Estados - Behavioral
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

entity TestBench_Maquina_Estados is
--  Port ( );
end TestBench_Maquina_Estados;

architecture Behavioral of TestBench_Maquina_Estados is

    component Maquina_estados_simple is
        Port ( clk : in STD_LOGIC;
               A : in STD_LOGIC;
               B : in STD_LOGIC;
               reset : in STD_LOGIC;
               z1 : out STD_LOGIC;
               z2 : out STD_LOGIC;
               estado : out STD_LOGIC_VECTOR (2 downto 0));
    end component;

    signal t_clk, t_A, t_B, t_reset, t_z1, t_z2 : std_logic := '0';
    signal t_estado : std_logic_vector (2 downto 0) := "000";
    signal clk_per : time := 1 us;

begin

    OOUT : Maquina_estados_simple Port Map (clk => t_clk,
                                            A => t_A,
                                            B => t_B,
                                            reset => t_reset,
                                            z1 => t_z1,
                                            z2 => t_z2,
                                            estado => t_estado);
                                            
    clk_proc : process
    begin
    
        t_clk <= '1';
        wait for clk_per / 2;
        t_clk <= '0';
        wait for clk_per / 2;
    
    end process;
    
    
    proc : process
    begin
    
        t_reset <= '1';
        t_A <= '0';
        t_B <= '0';
        wait for 2 * clk_per;
        
        t_reset <= '0';
        
        t_A <= '1';
        wait for 2 * clk_per;
        
        t_A <= '0';
        t_B <= '1';
        wait for 2 * clk_per;
        
        t_A <= '1';
        wait for 2 * clk_per;
        
        t_A <= '0';
        wait for 2 * clk_per;
        
        t_A <= '1';
        t_B <= '0';
        wait for 2 * clk_per;
        
        t_A <= '0';
        t_B <= '0';
        wait for 2 * clk_per;
        
        t_A <= '0';
        t_B <= '1';
        wait for 2 * clk_per;
        
        t_A <= '1';
        t_B <= '1';
        wait for 2 * clk_per;
        
        t_A <= '1';
        t_B <= '0';
        wait for 2 * clk_per;
        
        t_A <= '0';
        t_B <= '0';
        wait for 2 * clk_per;
        
        t_A <= '0';
        t_B <= '1';
        wait for 2 * clk_per;
        
        t_A <= '1';
        t_B <= '0';
        wait for 2 * clk_per;
        
        t_A <= '0';
        wait for 2 * clk_per;
    
    end process;

end Behavioral;
