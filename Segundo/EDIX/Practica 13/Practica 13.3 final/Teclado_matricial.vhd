----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2019 13:15:02
-- Design Name: 
-- Module Name: Teclado_matricial - Behavioral
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

entity Teclado_matricial is
    Port ( row1 : in STD_LOGIC;
           row2 : in STD_LOGIC;
           row3 : in STD_LOGIC;
           row4 : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (6 downto 0);
           DP : out STD_LOGIC;
           an0 : out STD_LOGIC;
           an1 : out STD_LOGIC;
           an2 : out STD_LOGIC;
           an3 : out STD_LOGIC;
           col_1 : out STD_LOGIC;
           col_2 : out STD_LOGIC;
           col_3 : out STD_LOGIC;
           col_4 : out STD_LOGIC);
end Teclado_matricial;

architecture Behavioral of Teclado_matricial is

    component divider1000 is
        Port ( clkin : in std_logic;
               clkout : out std_logic;
               reset : in std_logic);
    end component;
    
    component Maquina_Estados is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               ROW1 : in STD_LOGIC;
               ROW2 : in STD_LOGIC;
               ROW3 : in STD_LOGIC;
               ROW4 : in STD_LOGIC;
               En_Cont_Col : out STD_LOGIC;
               En_Reg_Col : out STD_LOGIC;
               En_Reg_Fil : out STD_LOGIC;
               Fila_Act : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
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

    signal out_div, out_en_cont, out_en_col, out_en_fil : std_logic;
    signal out_fila_act : std_logic_vector (1 downto 0);

begin

    DIVV : divider1000 Port Map (clkin => clk,
                                 reset => reset,
                                 clkout => out_div);
    
    MMAQ : Maquina_Estados Port Map (clk => out_div,
                                     reset => reset,
                                     ROW1 => row1,
                                     ROW2 => row2,
                                     ROW3 => row3,
                                     ROW4 => row4,
                                     En_Cont_Col => out_en_cont,
                                     En_Reg_Col => out_en_col,
                                     En_Reg_Fil => out_en_fil,
                                     Fila_Act => out_fila_act);
    
    UUOT : Unidad_operativa_teclado Port Map (En_Cont_Col => out_en_cont,
                                              En_Reg_Col => out_en_col,
                                              En_Reg_Fil => out_en_fil,
                                              Fila_Act => out_fila_act,
                                              clk => out_div,
                                              reset => reset,
                                              S => S,
                                              DP => DP,
                                              an0 => an0,
                                              an1 => an1,
                                              an2 => an2,
                                              an3 => an3,
                                              col1 => col_1,
                                              col2 => col_2,
                                              col3 => col_3,
                                              col4 => col_4);

end Behavioral;
