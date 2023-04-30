----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2019 15:46:54
-- Design Name: 
-- Module Name: Entrada_dp_in - Behavioral
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

entity Entrada_dp_in is
    Port ( an0 : in STD_LOGIC;
           an1 : in STD_LOGIC;
           an2 : in STD_LOGIC;
           an3 : in STD_LOGIC;
           dp_in : in STD_LOGIC;
           Q : out STD_LOGIC);
end Entrada_dp_in;

architecture Behavioral of Entrada_dp_in is

    signal s1, s2, s3, s4 : std_logic;

begin

    s1 <= dp_in and (not an0);
    s2 <= dp_in and (not an1);
    s3 <= dp_in and (not an2);
    s4 <= dp_in and (not an3);
    Q <= s1 or s2 or s3 or s4;

end Behavioral;
