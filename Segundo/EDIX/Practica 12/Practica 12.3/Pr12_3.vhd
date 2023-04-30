----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2019 19:18:44
-- Design Name: 
-- Module Name: Pr12_3 - Behavioral
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

entity Pr12_3 is
    Port ( ent1 : in STD_LOGIC_VECTOR (3 downto 0);
           ent2 : in STD_LOGIC_VECTOR (3 downto 0);
           ent3 : in STD_LOGIC_VECTOR (3 downto 0);
           ent4 : in STD_LOGIC_VECTOR (3 downto 0);
           reset : in STD_LOGIC;
           dp_in : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           an0 : out STD_LOGIC;
           an1 : out STD_LOGIC;
           an2 : out STD_LOGIC;
           an3 : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (6 downto 0);
           dp : out STD_LOGIC);
end Pr12_3;

architecture Behavioral of Pr12_3 is

    component MUX is
        Port ( sel : in STD_LOGIC_VECTOR (1 downto 0);
               e1 : in STD_LOGIC_VECTOR (3 downto 0);
               e2 : in STD_LOGIC_VECTOR (3 downto 0);
               e3 : in STD_LOGIC_VECTOR (3 downto 0);
               e4 : in STD_LOGIC_VECTOR (3 downto 0);
               S : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    
    component Entrada_dp_in is
        Port ( an0 : in STD_LOGIC;
               an1 : in STD_LOGIC;
               an2 : in STD_LOGIC;
               an3 : in STD_LOGIC;
               d : in STD_LOGIC_VECTOR (3 downto 0);
               q : out STD_LOGIC);
        end component;
    
    
    component Decoder_1a4 is
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
    
    
    component divider1000 is
        Port ( clkin : in std_logic;
               clkout : out std_logic;
               reset : in std_logic);
    end component;
    
    
    component Cont_2b is
        Port ( reset : in STD_LOGIC;
               clk : in STD_LOGIC;
               ce : in STD_LOGIC;
               load : in STD_LOGIC;
               din : in STD_LOGIC_VECTOR (1 downto 0);
               q : out STD_LOGIC_VECTOR (1 downto 0);
               tc : out STD_LOGIC;
               ceo : out STD_LOGIC);
    end component;
    
    signal s1 : std_logic_vector (3 downto 0);
    signal s2, s3, s4, s5, s6, s7 : std_logic := '0';
    signal s8 : std_logic_vector (1 downto 0);
    

begin

    an0 <= s2;
    an1 <= s3;
    an2 <= s4;
    an3 <= s5;

    MMUX : MUX Port Map (sel => s8,
                         e1 => ent1,
                         e2 => ent2,
                         e3 => ent3,
                         e4 => ent4,
                         S => s1);
    
    
    DDEC : Entrada_dp_in Port Map (an0 => s2,
                                   an1 => s3,
                                   an2 => s4,
                                   an3 => s5,
                                   d => dp_in,
                                   q => s7);
    
    
    ENDP : Decoder_1a4 Port Map (G => '1',
                                 d => s8,
                                 q(0) => s2,
                                 q(1) => s3,
                                 q(2) => s4,
                                 q(3) => s5);
    
    
    LLED : Leds_7_Segs Port Map (DIN => s1,
                                 dp_in => s7,
                                 en => '1',
                                 DP => dp,
                                 S => S);
    
    
    DDIV : Divider1000 Port Map (clkin => clk,
                                 reset => reset,
                                 clkout => s6);
    
    
    CCON : Cont_2b Port Map (reset => reset,
                             clk => s6,
                             ce => '1',
                             load => '0',
                             din => "00",
                             q => s8);
    
end Behavioral;
