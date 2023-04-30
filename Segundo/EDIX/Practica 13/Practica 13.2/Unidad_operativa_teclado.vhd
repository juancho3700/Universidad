----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2019 11:17:55
-- Design Name: 
-- Module Name: Unidad_operativa_teclado - Behavioral
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

entity Unidad_operativa_teclado is
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
end Unidad_operativa_teclado;

architecture Behavioral of Unidad_operativa_teclado is

    component Ctr_2b is
        Port ( reset : in STD_LOGIC;
               load : in STD_LOGIC;
               ce : in STD_LOGIC;
               din : in STD_LOGIC_VECTOR (1 downto 0);
               clk : in STD_LOGIC;
               q : out STD_LOGIC_VECTOR (1 downto 0);
               ceo : out STD_LOGIC;
               tc : out STD_LOGIC);
    end component;
    
    component Reg_filas is
        Port ( reset : in STD_LOGIC;
               ce : in STD_LOGIC;
               clk : in STD_LOGIC;
               d : in STD_LOGIC_VECTOR (1 downto 0);
               Q : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    component Reg_columnas is
        Port ( reset : in STD_LOGIC;
               ce : in STD_LOGIC;
               clk : in STD_LOGIC;
               d : in STD_LOGIC_VECTOR (1 downto 0);
               Q : out STD_LOGIC_VECTOR (1 downto 0));
    end component;
    
    component Convertidor_codigo is
        Port ( Col : in STD_LOGIC_VECTOR (1 downto 0);
               Fil : in STD_LOGIC_VECTOR (1 downto 0);
               Bin : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component Dec_1_a_4 is
        Port ( G : in STD_LOGIC;
               d : in STD_LOGIC_VECTOR (1 downto 0);
               q : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component Leds_7_Segs is
        Port ( DIN : in STD_LOGIC_VECTOR (3 downto 0);
               dp_in : in STD_LOGIC;
               en : in STD_LOGIC;
               DP : out STD_LOGIC;
               S : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    signal out_ctr, out_reg_col, out_reg_fil : std_logic_vector (1 downto 0);
    signal out_conv : std_logic_vector (3 downto 0);

begin

    CCTR : Ctr_2b Port Map (reset => reset,
                            load => '0',
                            ce => En_Cont_col,
                            din => "00",
                            clk => clk,
                            q => out_ctr);
                            
    RREGF : Reg_filas Port Map (reset => reset,
                                ce => En_reg_Fil,
                                clk => clk,
                                d => out_ctr,
                                Q => out_reg_col);
                                
    GGERC : Reg_columnas Port Map (reset => reset,
                                   ce => En_Reg_Fil,
                                   clk => clk,
                                   d => Fila_Act,
                                   Q => out_reg_fil);
                                   
    CCONV : Convertidor_codigo Port Map (Col => out_reg_col,
                                         Fil => out_reg_fil,
                                         Bin => out_conv);
                                         
    DDEC : Dec_1_a_4 Port Map (G => '1',
                               d => out_ctr,
                               q (0) => col1,
                               q (1) => col2,
                               q (2) => col3,
                               q (3) => col4);
                               
    LLED : Leds_7_Segs Port Map (DIN => out_conv,
                                 dp_in => '0',
                                 en => '1',
                                 S => S,
                                 DP => DP);
                                 
    an0 <= '0';
    an1 <= '1';
    an2 <= '1';
    an3 <= '1';

end Behavioral;
