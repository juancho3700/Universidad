----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2019 15:28:55
-- Design Name: 
-- Module Name: Pr10 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pr10 is
  port ( clk : in    std_logic; 
          load : in    std_logic; 
          msb_in : in    std_logic; 
          reset : in    std_logic; 
          shift_enable : in    std_logic; 
          data_in : in  std_logic_vector (7 downto 0);
          lsb_out : out   std_logic; 
          q_shift : out   std_logic_vector (7 downto 0));
end Pr10;

architecture Behavioral of Pr10 is

 component reg_desplazamiento_derecha_8_bits
      port ( clk : in    std_logic; 
             reset : in    std_logic; 
             load : in    std_logic; 
             msb_in : in    std_logic; 
             shift_enable : in    std_logic; 
             data_in : in    std_logic_vector (7 downto 0); 
             lsb_out : out   std_logic; 
             q_shift : out   std_logic_vector (7 downto 0));
   end component;
   
   component detector_flancos
      port ( entrada : in    std_logic; 
             clk : in    std_logic; 
             reset : in    std_logic; 
             fa_entrada : out   std_logic; 
             fd_entrada : out   std_logic; 
             f_entrada : out   std_logic; 
             entrada_s : out   std_logic);
   end component;
   
   component D_flip_flop is
        Port ( clk : in  STD_LOGIC;
               async_reset : in  STD_LOGIC;
               sync_reset : in  STD_LOGIC;
               ce : in  STD_LOGIC;
               d : in std_logic;
               q : out std_logic);
    end component;
    
    component divider100 is
        Port ( clkin : in std_logic;
               clkout : out std_logic;
               reset : in std_logic);
    end component;
    
    component divider1000 is
        Port ( clkin : in std_logic;
               clkout : out std_logic;
               reset : in std_logic);
    end component;
    
 signal s1, s2, s3, s4 : std_logic;
begin

    REG : reg_desplazamiento_derecha_8_bits
      port map (clk=>clk,
                data_in=>data_in,
                load=>load,
                msb_in=>msb_in,
                reset=>reset,
                shift_enable=>s1,
                lsb_out=>lsb_out,
                q_shift(7 downto 0)=>q_shift(7 downto 0));
   
   
    DDET : detector_flancos
      port map (clk=>clk,
                entrada=>s3,
                reset=>reset,            
                fa_entrada=>s1);
                
    
    DDFF : D_flip_flop
      Port Map (clk => s2,
                async_reset => '0',
                sync_reset => reset,
                ce => '1',
                d => shift_enable,
                q => s3);
    
    
    DIV1 : divider100 Port Map (clkin => clk,
                                reset => reset,
                                clkout => s4);
    
    
    DIV2 : divider1000 Port Map (clkin => s4,
                                 reset => reset,
                                 clkout => s2);


end Behavioral;
