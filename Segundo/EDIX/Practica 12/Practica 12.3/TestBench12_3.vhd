----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2019 09:14:54
-- Design Name: 
-- Module Name: TestBench12_3 - Behavioral
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

entity TestBench12_3 is
--  Port ( );
end TestBench12_3;

architecture Behavioral of TestBench12_3 is

    component Pr12_3 is
        Port ( ent1 : in STD_LOGIC_VECTOR (3 downto 0);
               ent2 : in STD_LOGIC_VECTOR (3 downto 0);
               ent3 : in STD_LOGIC_VECTOR (3 downto 0);
               ent4 : in STD_LOGIC_VECTOR (3 downto 0);
               reset : in STD_LOGIC;
               dp_in : in STD_LOGIC_VECTOR (3 downto 0);
               clk : in STD_LOGIC;
               an0 : out STD_LOGIC;
               an1 : out STD_LOGIC;
               an2 : out STD_LOGIC;
               an3 : out STD_LOGIC;
               S : out STD_LOGIC_VECTOR (6 downto 0);
               dp : out STD_LOGIC);
    end component;

    signal t_ent1, t_ent2, t_ent3, t_ent4, t_dp_in : std_logic_vector (3 downto 0);
    signal t_reset, t_clk, t_an0, t_an1, t_an2, t_an3, t_dp : std_logic;
    signal t_S : std_logic_vector (6 downto 0);
    signal clk_per : time := 1 us;

begin

    OOUT : Pr12_3 Port Map (ent1 => t_ent1,
                            ent2 => t_ent2,
                            ent3 => t_ent3,
                            ent4 => t_ent4,
                            reset => t_reset,
                            dp_in => t_dp_in,
                            clk => t_clk,
                            an0 => t_an0,
                            an1 => t_an1,
                            an2 => t_an2,
                            an3 => t_an3,
                            S => t_S,
                            dp => t_dp);
                            
    clk_proc : process
    begin
    
        t_clk <= '1';
        wait for clk_per / 2;
        
        t_clk <= '0';
        wait for clk_per / 2;
        
    end process;
    
    proc : process
    begin
    
        t_ent1 <= "0000";
        t_ent2 <= "0101";
        t_ent3 <= "1010";
        t_ent4 <= "1111";
        
        t_dp_in <= "1010";
        t_reset <= '1';
        
        wait for 100 * clk_per;
        
        t_reset <= '0';
        wait for 5000 * clk_per;
        
        t_reset <= '1';
        wait;
    end process;

end Behavioral;
