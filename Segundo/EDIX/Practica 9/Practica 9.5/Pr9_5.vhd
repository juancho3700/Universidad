----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.11.2019 22:35:04
-- Design Name: 
-- Module Name: Pr9_5 - Behavioral
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

entity Pr9_5 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           load : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (1 downto 0);
           ceo : out STD_LOGIC;
           tc : out STD_LOGIC);
end Pr9_5;

architecture Behavioral of Pr9_5 is

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
    
    component D_flip_flop is
        Port ( clk : in  STD_LOGIC;
               async_reset : in  STD_LOGIC;
               sync_reset : in  STD_LOGIC;
               ce : in  STD_LOGIC;
               d : in std_logic;
               q : out std_logic);
    end component;
    
    component detector_flancos is
        Port ( ent : in std_logic;
               clk : in std_logic;
               reset : in std_logic;
               fa_ent : out std_logic;
               fd_ent : out std_logic;
               f_ent : out std_logic;
               ent_s : out std_logic);
    end component;
    
    component divider100 is
        Port ( clkin : in std_logic;
               clkout : out std_logic;
               reset : in std_logic);
    end component;
    
    component divider1000 is
        Port ( clkin : in std_logic;
               clkout : out std_logic;
               reset : in std_logic);
    end component;
    
    signal s1, s2, s3, s4 : std_logic;

begin

    CCON : Cont_2b Port Map (reset => reset,
                             clk => clk,
                             ce => s4,
                             load => load,
                             din => din,
                             q => q,
                             ceo => ceo,
                             tc => tc);
    
    
    DDFF : D_flip_flop Port Map (clk => s2,
                                 async_reset => '0',
                                 sync_reset => reset,
                                 ce => '1',
                                 d => ce,
                                 q => s3);
    
    
    DDET : detector_flancos Port Map (ent => s3,
                                      clk => clk,
                                      reset => reset,
                                      fa_ent => s4);
    
    
    DIV1 : divider100 Port Map (clkin => clk,
                                reset => reset,
                                clkout => s1);
    
    
    DIV2 : divider1000 Port Map (clkin => s1,
                                 reset => reset,
                                 clkout => s2);

end Behavioral;
