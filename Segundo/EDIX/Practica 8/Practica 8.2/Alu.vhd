----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2019 17:24:11
-- Design Name: 
-- Module Name: Alu - Alu
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Alu is
    Port ( entrada1 : in STD_LOGIC_VECTOR (3 downto 0);
           entrada2 : in STD_LOGIC_VECTOR (3 downto 0);
           selector: in STD_LOGIC_VECTOR (1 downto 0);
           salida : out STD_LOGIC_VECTOR (7 downto 0));
end Alu;

architecture Alu of Alu is

    component p_and is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               b : in STD_LOGIC_VECTOR (3 downto 0);
               res : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component Compl_a2 is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               c_a2 : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component Resta is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               b : in STD_LOGIC_VECTOR (3 downto 0);
               res : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    
    component Prod is
        Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
               b : in STD_LOGIC_VECTOR (3 downto 0);
               res : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component MUX is
        Port ( p_and : in STD_LOGIC_VECTOR (7 downto 0);
               c_a2 : in STD_LOGIC_VECTOR (7 downto 0);
               resta : in STD_LOGIC_VECTOR (7 downto 0);
               prod : in STD_LOGIC_VECTOR (7 downto 0);
               sel : in STD_LOGIC_VECTOR (1 downto 0);
               Y : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal P, Q: std_logic_vector (3 downto 0);
    signal R: std_logic_vector (4 downto 0);
    signal S, P1, Q1, R1: std_logic_vector (7 downto 0);

begin

    AAND: p_and port map (a => entrada1,
                          b => entrada2,
                          res => P);
    
    CCA2: Compl_a2 port map (a => entrada1,
                             c_a2 => Q);
    
    RRES: Resta port map (a => entrada1,
                          b => entrada2,
                          res => R);
    
    PPROD: Prod port map (a => entrada1,
                          b => entrada2,
                          res => S);
                          
    P1 <= "0000" & P;
    Q1 <= std_logic_vector (resize (signed (Q),8));
    R1 <= std_logic_vector (resize (signed (R),8));
    
    MMUX: MUX port map (p_and => P1,
                        c_a2 => Q1,
                        resta => R1,
                        prod => S,
                        sel => selector,
                        Y => salida);

end Alu;
