----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2019 20:25:59
-- Design Name: 
-- Module Name: TestBench9_3 - Behavioral
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

entity TestBench9_3 is
--  Port ( );
end TestBench9_3;

architecture Behavioral of TestBench9_3 is

    component Pr9_3 is
        Port ( reset : in STD_LOGIC;
               load : in STD_LOGIC;
               ce : in STD_LOGIC;
               din : in STD_LOGIC_VECTOR (1 downto 0);
               clk : in STD_LOGIC;
               q : out STD_LOGIC_VECTOR (1 downto 0);
               ceo : out STD_LOGIC;
               tc : out STD_LOGIC);
    end component;

    signal t_reset, t_load, t_ce, t_ceo, t_tc, clk : std_logic := '0';
    signal t_din, t_q : std_logic_vector (1 downto 0) := "00";
    signal clk_per : time := 1 us;

begin

    OOUT: Pr9_3 Port Map (reset => t_reset,
                          load => t_load,
                          ce => t_ce,
                          din => t_din,
                          clk => clk,
                          q => t_q,
                          ceo => t_ceo,
                          tc => t_tc);

    clk_proc: process
    begin
    
        clk <= '1';
        wait for clk_per / 2;
        clk <= '0';
        wait for clk_per / 2;
    
    end process;

    proceso: process
    begin
    
        t_reset <= '1';
        wait for clk_per;
        
        t_reset <= '0';
        wait for 2 * clk_per;
        
        t_din <= "10";
        t_load <= '1';
        wait for clk_per;
        
        t_load <= '0';
        t_ce <= '1';
        wait for 20 * clk_per;
                
        t_reset <= '1';
        t_din <= "00";
        wait for clk_per;

    end process;
end Behavioral;
