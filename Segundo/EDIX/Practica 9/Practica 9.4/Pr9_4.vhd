----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2019 21:41:42
-- Design Name: 
-- Module Name: Pr9_4 - Behavioral
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

entity Pr9_4 is
    Port ( clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           reset : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (1 downto 0);
           load : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (1 downto 0);
           ceo : out STD_LOGIC;
           tc : out STD_LOGIC);
end Pr9_4;

architecture Behavioral of Pr9_4 is

    component Det_flancos is
        Port ( ent : in STD_LOGIC;
               clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               fa_ent : out STD_LOGIC;
               fd_ent : out STD_LOGIC;
           f_ent : out STD_LOGIC;
           ent_s : out STD_LOGIC);
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

    signal P : std_logic;

begin

    

    DDET : Det_flancos Port Map (ent => ce,
                                 reset => reset,
                                 clk => clk,
                                 fa_ent => P);
    
    
    CCON : Cont_2b Port Map (reset => reset,
                             clk => clk,
                             ce => P,
                             load =>load,
                             din => din,
                             q => q,
                             ceo => ceo, tc => tc);


end Behavioral;
