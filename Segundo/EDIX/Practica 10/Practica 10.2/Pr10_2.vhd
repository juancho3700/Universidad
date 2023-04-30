----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2019 18:40:11
-- Design Name: 
-- Module Name: Pr10_2 - Behavioral
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

entity Pr10_2 is
    Port ( A_in : in STD_LOGIC;
           B_in : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (6 downto 0);
           DP : out STD_LOGIC;
           an0 : out STD_LOGIC;
           an1 : out STD_LOGIC;
           an2 : out STD_LOGIC;
           an3 : out STD_LOGIC;
           z1 : out STD_LOGIC;
           z2 : out STD_LOGIC);
end Pr10_2;

architecture Behavioral of Pr10_2 is

    component Maquina_estados_simple is
        Port ( clk : in STD_LOGIC;
               A : in STD_LOGIC;
               B : in STD_LOGIC;
               reset : in STD_LOGIC;
               z1 : out STD_LOGIC;
               z2 : out STD_LOGIC;
               estado : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    component Leds_7_Segs is
        Port ( DIN : in STD_LOGIC_VECTOR (3 downto 0);
               dp_in : in STD_LOGIC;
               en : in STD_LOGIC;
               DP : out STD_LOGIC;
               S : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    signal s1 : std_logic_vector (2 downto 0);
    signal s2 : std_logic_vector (3 downto 0);

begin

    an0 <= '0';
    an1 <= '1';
    an2 <= '1';
    an3 <= '1';
    
    s2 <= '0' & s1;

    MMAQ : Maquina_estados_simple Port Map (clk => clk,
                                            A => A_in,
                                            B => B_in,
                                            reset => reset,
                                            z1 => z1,
                                            z2 => z2,
                                            estado => s1);
    
    
    LLED : Leds_7_Segs Port Map (DIN => s2,
                                 dp_in => '0',
                                 en => '1',
                                 S => S,
                                 DP => DP);

end Behavioral;
