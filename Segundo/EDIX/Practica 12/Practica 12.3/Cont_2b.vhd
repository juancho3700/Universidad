library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cont_2b is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           load : in STD_LOGIC;
           din : in STD_LOGIC_VECTOR (1 downto 0);
           q : out STD_LOGIC_VECTOR (1 downto 0);
           tc : out STD_LOGIC;
           ceo : out STD_LOGIC);
end Cont_2b;

architecture Contador of Cont_2b is

    signal qt : std_logic_vector (1 downto 0) := "00";

begin

    process (clk)
    begin
    
        if (reset = '1') then
                qt <= "00";
        else 
            if (rising_edge (clk)) then
                
                if (load = '1') then
                    qt <= din;
                
                elsif (ce <= '0') then
                    qt <= qt;
                
                elsif (ce <= '1') then
                    qt <= qt + 1;
                
                end if;
            end if;
        end if;
    end process;
    
    q <= qt;
    tc <= qt(0) and qt(1);
    ceo <= qt (0) and qt (1) and ce;


end Contador;
