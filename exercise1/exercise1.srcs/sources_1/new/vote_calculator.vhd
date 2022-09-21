----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.09.2022 15:34:08
-- Design Name: 
-- Module Name: vote_calculator - Behavioral
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

-- Program computes the winner from A and B.
-- The one with more votes is the winner.
-- A and B are vectors where 0 is no vote and 1 is a  vote.
-- Example: A = "101" means 2 votes for A. B = "111" means 3 votes for B.

entity vote_calculator is
  port(
    scores_A, scores_B : in std_logic_vector(2 downto 0);
    winner : out std_logic_vector(1 downto 0)
  );
end vote_calculator;

architecture loopy of vote_calculator is

  begin
    process(scores_A, scores_B)
    
    variable vote_count_A: integer;
    variable vote_count_B: integer;
        
    begin
    
        vote_count_A := 0;
        vote_count_B := 0;

-- loop counts 1-bits from vote vectors
      for i in integer range 2 downto 0 loop
        
        if (scores_A(i) = '1') then
          vote_count_A := vote_count_A + 1;
        end if;

        if (scores_B(i) = '1') then
          vote_count_B := vote_count_B + 1;
        end if;
        
      end loop;

      if (vote_count_A = 0 and vote_count_B = 0) then
        winner <= "00";
      elsif (vote_count_A > vote_count_B) then
        winner <= "10";
      elsif (vote_count_A < vote_count_B) then
        winner <= "01";
      elsif (vote_count_A = vote_count_B) then
        winner <= "11";
      end if;
      
    end process;

end loopy;
