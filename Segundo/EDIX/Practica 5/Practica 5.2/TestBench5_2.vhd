library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TestBench5_2 is

end TestBench5_2;

architecture Behavioral of TestBench5_2 is

    component Pr5_2 is
        Port( d: in STD_LOGIC_VECTOR (2 downto 0);
              q: out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal t_d: std_logic_vector (2 downto 0);
    signal t_q: std_logic_vector (7 downto 0);

begin

    OOUT: Pr5_2 port map ( d => t_d,
                           q => t_q);
                           
    process
    begin
    
        for I in 0 to 7 loop
            t_d <= std_logic_vector (to_unsigned (I,3));
            wait for 100 ns;
        end loop;
        wait;

    end process;
end Behavioral;
