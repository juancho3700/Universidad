----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2019 12:28:50
-- Design Name: 
-- Module Name: Maquina_estados - Maquina_estados
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

entity Maquina_Estados is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ROW1 : in STD_LOGIC;
           ROW2 : in STD_LOGIC;
           ROW3 : in STD_LOGIC;
           ROW4 : in STD_LOGIC;
           En_Cont_Col : out STD_LOGIC;
           En_Reg_Col : out STD_LOGIC;
           En_Reg_Fil : out STD_LOGIC;
           Fila_Act : out STD_LOGIC_VECTOR (1 downto 0));
end Maquina_Estados;

architecture Maquina_Estados of Maquina_Estados is
 
    signal fila : std_logic_vector(1 downto 0);
	signal est_act : std_logic_vector(3 downto 0);
	signal est_sig : std_logic_vector(3 downto 0);
	
	constant est0 : std_logic_vector(3 downto 0) := "0000";
	constant est1 : std_logic_vector(3 downto 0) := "0001";
	constant est2 : std_logic_vector(3 downto 0) := "0010";
	constant est3 : std_logic_vector(3 downto 0) := "0011";
	constant est4 : std_logic_vector(3 downto 0) := "0100";
	constant reg1 : std_logic_vector(3 downto 0) := "0110";
	constant reg2 : std_logic_vector(3 downto 0) := "0111";
	constant reg3 : std_logic_vector(3 downto 0) := "1000";
	constant reg4 : std_logic_vector(3 downto 0) := "1001";
	constant incr : std_logic_vector(3 downto 0) := "0101";

begin

	process1 : process (clk, est_sig, reset)
	begin
		if reset='1' then
			est_act <= est0;
		elsif(clk'event and clk='1') then
			est_act <= est_sig;
		end if;
	end process;
	
	process2 : process (est_act, ROW1, ROW2, ROW3, ROW4)
	begin
		est_sig <= est0;
		
		case est_act is
		
			when est0 => est_sig <= est1;
			
			when est1 =>
				if (ROW1 = '0') then est_sig <= reg1;
				else est_sig <= est2;
				end if;
				
			when est2 =>
				if (ROW2 = '0') then est_sig <= reg2;
				else est_sig <= est3;
				end if;
				
			when est3 =>
				if (ROW3 = '0') then est_sig <= reg3;
				else est_sig <= est4;
				end if;
				
			when est4 =>
				if (ROW4 = '0') then est_sig <= reg4;
				else est_sig <= incr;
				end if;
				
		    when reg1 => est_sig <= est0;
		    
		    when reg2 => est_sig <= est0;
		    
		    when reg3 => est_sig <= est0;
		    
		    when reg4 => est_sig <= est0;
		    
			when incr => est_sig <= est1;
			
			when others=> est_sig <= est0;
		end case;
	end process;
	
	process3 : process (est_act, fila)
	begin
		case est_act is
		  
		    when est0 => En_Cont_Col <= '0';
		                 En_Reg_Col <= '0';
					     En_Reg_Fil <= '0';
					     fila <= "UU";
					 
			when est1 => En_Cont_Col <= '0';
						 En_Reg_Col <= '0';
						 En_Reg_Fil <= '0';
						 fila <= "00";
						
			when est2 => En_Cont_Col <= '0';
						En_Reg_Col <= '0';
						En_Reg_Fil <= '0';
						fila <= "01";
						
			when est3 => En_Cont_Col <= '0';
						 En_Reg_Col <= '0';
						 En_Reg_Fil <= '0';
						 fila <= "10";
						
			when est4 => En_Cont_Col <= '0';
						 En_Reg_Col <= '0';
						 En_Reg_Fil <= '0';
						 fila <= "11";
						
			when incr => En_Cont_Col <= '1';
						 En_Reg_Col <= '0';
						 En_Reg_Fil <= '0';
						 fila <= "ZZ";
						
			when reg1 => En_Cont_Col <= '0';
						 En_Reg_Col <= '1';
						 En_Reg_Fil <= '1';
						 Fila_Act <= "00";
						
			when reg2 => En_Cont_Col <= '0';
						 En_Reg_Col <= '1';
						 En_Reg_Fil <= '1';
						 Fila_Act <= "01";
						
			when reg3 => En_Cont_Col <= '0';
						 En_Reg_Col <= '1';
						 En_Reg_Fil <= '1';
						 Fila_Act <= "10";
						
			when reg4 => En_Cont_Col <= '0';
						 En_Reg_Col <= '1';
						 En_Reg_Fil <= '1';
						 Fila_Act <= "11";
						
			when others => En_Cont_Col<='0';
						   En_Reg_Col <= '0';
						   En_Reg_Fil <= '0';
						   fila <= "ZZ";
		end case;
	end process;

end Maquina_Estados;
