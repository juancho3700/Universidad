----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2019 19:12:56
-- Design Name: 
-- Module Name: Entrada_dp_in - Entrada_dp_in
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
           d : in STD_LOGIC_VECTOR (3 downto 0);
           q : out STD_LOGIC);
end Entrada_dp_in;

Architecture Entrada_dp_in of Entrada_dp_in is

    signal s1, s2, s3, s4 : STD_LOGIC;

begin

    s1 <= d(0) and (not an0);
    s2 <= d(1) and (not an1);
    s3 <= d(2) and (not an2);
    s4 <= d(3) and (not an3);
    
    q <= s1 or s2 or s3 or s4;

end Entrada_dp_in;
