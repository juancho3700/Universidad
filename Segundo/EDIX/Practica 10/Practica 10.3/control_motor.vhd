----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2019 18:35:01
-- Design Name: 
-- Module Name: control_motor - Behavioral
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

entity control_motor is
    Port (  CLK : in  STD_LOGIC;
           MARCHA : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           SENTIDO : in  STD_LOGIC;
           ESTADO : out  STD_LOGIC_VECTOR (3 downto 0);
           A : out  STD_LOGIC;
           B : out  STD_LOGIC;
           C : out  STD_LOGIC;
           D : out  STD_LOGIC);
           
end control_motor;

architecture Behavioral of control_motor is

    signal Estado_actual : std_logic_vector (3 downto 0);
    signal Estado_siguiente : std_logic_vector (3 downto 0);
    
    constant s0 : std_logic_vector (3 downto 0) := "0000";
    constant s1 : std_logic_vector (3 downto 0) := "0001";
    constant s2 : std_logic_vector (3 downto 0) := "0010";
    constant s3 : std_logic_vector (3 downto 0) := "0011";
    constant s4 : std_logic_vector (3 downto 0) := "0100";
    constant s5 : std_logic_vector (3 downto 0) := "0101";
    constant s6 : std_logic_vector (3 downto 0) := "0110";
    constant s7 : std_logic_vector (3 downto 0) := "0111";
    constant s8 : std_logic_vector (3 downto 0) := "1000";

begin

estado <= Estado_actual;
	registro_estados : process (clk,reset,Estado_siguiente)
		begin
		if (reset='1') then
			Estado_actual<= s0;
		elsif (clk='1' and clk'event) then
		Estado_actual <=Estado_siguiente;
		end if;
	end process;

	Cambio_Estado : process (Estado_actual, marcha, sentido)
		
		begin		
		
		case Estado_actual is
			when s0 => if (marcha='1' and sentido='0') then Estado_siguiente<=s1;
                       elsif (marcha='1' and sentido='1') then Estado_siguiente<=s5;
                       else Estado_siguiente<=s0;
                       end if;
			when s1 => Estado_siguiente<=s2;
			when s2 => Estado_siguiente<=s3;
			when s3 => Estado_siguiente<=s4;
			when s4 => if(marcha='1') then Estado_siguiente<=s1;
				       else Estado_siguiente<=s0;
			           end if;
			when s5 => Estado_siguiente<=s6;
			when s6 => Estado_siguiente<=s7;
			when s7 => Estado_siguiente<=s8;
			when s8 => if(marcha='1') then Estado_siguiente<=s5;
                       else Estado_siguiente<=s0;
                       end if;
			when others => Estado_siguiente <=s0;
			
		end case;
	end process;
	
	salidas :process (Estado_actual)
	
	    begin
	
		case Estado_actual is
			when s0 =>  A<='0';
						B<='0';
						C<='0';
						D<='0';	
						
			when s1 => 	A<='1';
						B<='0';
						C<='0';
						D<='0';
						
			when s2 => 	A<='0';
						B<='0';
						C<='1';
						D<='0';
						
			when s3 => 	A<='0';
					    B<='1';
						C<='0';
						D<='0';
						
			when s4 => 	A<='0';
						B<='0';
						C<='0';
						D<='1';
						
			when s5 => 	A<='0';
						B<='0';
						C<='0';
						D<='1';
						
			when s6 => 	A<='0';
						B<='1';
						C<='0';
						D<='0';
						
			when s7 => 	A<='0';
						B<='0';
						C<='1';
						D<='0';
						
			when s8 => 	A<='1';
						B<='0';
						C<='0';
						D<='0';
						
			when others => A<='0';
						   B<='0';
						   C<='0';
						   D<='0';
						   
		end case;
	end process;
	
end Behavioral;

