----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2019 13:49:40
-- Design Name: 
-- Module Name: TestBench_unidad_operativa - Behavioral
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

entity TestBench_unidad_operativa is
--  Port ( );
end TestBench_unidad_operativa;

architecture Behavioral of TestBench_unidad_operativa is

    component Unidad_operativa_teclado is
        Port ( En_Cont_Col : in STD_LOGIC;
               En_Reg_Col : in STD_LOGIC;
               En_Reg_Fil : in STD_LOGIC;
               Fila_Act : in STD_LOGIC_VECTOR (1 downto 0);
               clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               S : out STD_LOGIC_VECTOR (6 downto 0);
               DP : out STD_LOGIC;
               an0 : out STD_LOGIC;
               an1 : out STD_LOGIC;
               an2 : out STD_LOGIC;
               an3 : out STD_LOGIC;
               col1 : out STD_LOGIC;
               col2 : out STD_LOGIC;
               col3 : out STD_LOGIC;
               col4 : out STD_LOGIC);
    end component;

    signal t_en_col_cont, t_en_reg_col, t_en_reg_fil, t_clk, t_reset, t_DP, t_an0, t_an1, t_an2, t_an3, t_col1, t_col2, t_col3, t_col4 : std_logic := '0';
    signal t_fila_act : std_logic_vector (1 downto 0) := "00";
    signal t_S : std_logic_vector (6 downto 0) := "0000000";
    signal clk_per : time := 1 us;

begin

    OOUT : Unidad_operativa_teclado Port Map (En_Cont_col => t_en_col_cont,
                                              En_Reg_Col => t_en_reg_col,
                                              En_Reg_Fil => t_en_reg_fil,
                                              Fila_Act => t_fila_act,
                                              clk => t_clk,
                                              reset => t_reset,
                                              S => t_S,
                                              DP => t_DP,
                                              an0 => t_an0,
                                              an1 => t_an1,
                                              an2 => t_an2,
                                              an3 => t_an3,
                                              col1 => t_col1,
                                              col2 => t_col2,
                                              col3 => t_col3,
                                              col4 => t_col4);
                                              
    clk_proc : process
    begin
    
        t_clk <= '1';
        wait for clk_per / 2;
        
        t_clk <= '0';
        wait for clk_per / 2;
    
    end process;


    proc : process
    begin
    
        wait for clk_per / 2;
    
        t_reset <= '1';
        wait for 3 * clk_per;
        
        t_reset <= '0';
        t_en_col_cont <= '1';
        wait for 2 * clk_per;
        
        t_en_reg_col <= '1';
        t_en_reg_fil <= '1';
        wait for 5 * clk_per;
        
        t_fila_act <= "01";
        wait for 5 * clk_per;
        
        t_fila_act <= "10";
        wait for 5 * clk_per;
        
        t_fila_act <= "11";
        wait for 5 * clk_per;
        
        t_reset <= '1';
        wait for 3 * clk_per;
    
        assert (false) report "Fin simulacion" severity FAILURE;
    
    end process;
end Behavioral;
