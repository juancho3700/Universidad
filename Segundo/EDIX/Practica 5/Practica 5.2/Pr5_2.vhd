library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Pr5_2 is
    Port ( d : in STD_LOGIC_VECTOR (2 downto 0);
           q : out STD_LOGIC_VECTOR (7 downto 0));
end Pr5_2;

architecture RTL of Pr5_2 is
begin

    with d select q <=
        "00000001" when "000",
        "00000010" when "001",
        "00000100" when "010",
        "00001000" when "011",
        "00010000" when "100",
        "00100000" when "101",
        "01000000" when "110",
        "10000000" when "111",
        "00000000" when others;

end RTL;
