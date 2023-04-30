library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder_1a4 is
    Port ( G : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0));
end Decoder_1a4;

architecture Decoder_1a4 of Decoder_1a4 is

begin

    process (d)
    begin
    
        case d is
            when "00" => q <= "1110";
            when "01" => q <= "1101";
            when "10" => q <= "1011";
            when "11" => q <= "0111";
            when others => q <= "0000";
        end case;
    
    end process;

end Decoder_1a4;