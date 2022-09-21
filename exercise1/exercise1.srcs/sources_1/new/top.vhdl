----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.09.2022 19:27:34
-- Design Name: 
-- Module Name: exercise1_zedboard - Behavioral
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

entity top is
    Port (
        SW0 : in STD_LOGIC;
        SW1 : in STD_LOGIC;
        SW2 : in STD_LOGIC;
        SW3 : in STD_LOGIC;
        SW4 : in STD_LOGIC;
        SW5 : in STD_LOGIC;
        SW6 : in STD_LOGIC;
        SW7 : in STD_LOGIC;
        
        LD0 : out STD_LOGIC;
        LD1 : out STD_LOGIC;
        LD2 : out STD_LOGIC;
        LD3 : out STD_LOGIC;
        LD4 : out STD_LOGIC;
        LD5 : out STD_LOGIC;
        LD6 : out STD_LOGIC;
        LD7 : out STD_LOGIC;
        
        JA1 : out STD_LOGIC;
        JA2 : out STD_LOGIC;
        JA3 : out STD_LOGIC
    );
end top;

architecture Behavioral of top is
  component vote_calculator
    port(
      scores_A, scores_B : in std_logic_vector(2 downto 0);
      winner : out std_logic_vector(1 downto 0)
    );
  end component;

begin
 
 DUT : vote_calculator port map(
                                scores_A(0) => SW0,
                                scores_A(1) => SW1,
                                scores_A(2) => SW2,
                                scores_B(0) => SW3,
                                scores_B(1) => SW4,
                                scores_B(2) => SW5,
                                winner(0) => LD0,
                                winner(1) => LD1
                                );

end Behavioral;
