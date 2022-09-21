----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.09.2022 16:00:51
-- Design Name: 
-- Module Name: vote_calculator_test - tb
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
use IEEE.numeric_std;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vote_calculator_test is
--  Port ( );
end vote_calculator_test;

architecture tb of vote_calculator_test is
  component vote_calculator
    port(
      scores_A, scores_B : in std_logic_vector(2 downto 0);
      winner : out std_logic_vector(1 downto 0)
    );
  end component;
  
  signal test_scores_A, test_scores_B : std_logic_vector (2 downto 0);
  signal test_winner : std_logic_vector (1 downto 0);
  
-- score_sum_array is a list of the number of 1-bits in an integer's binary representation
-- where the integer is the index.
-- Example:
-- 1 -> "001" -> 1 1-bit
-- 5 -> "101" -> 2 1-bits
-- 7 -> "111" -> 3 1-bits
  type score_sum_array is array (0 to 7) of integer;
  signal score_sum_array_signal : score_sum_array := (0,1,1,2,1,2,2,3); 
  
-- Returns the winner of A and B. votes_A and votes_B are vectors
-- where the number of 1-bits means number of votes respectively. 
  impure function result(votes_A, votes_B : std_logic_vector := "000") return std_logic_vector is
    variable score_A : integer;
    variable score_B : integer;
    begin
-- Convert vote vector to unsigned integer and looks up the number of 1-bits from the array
      score_A := score_sum_array_signal(numeric_std.to_integer(numeric_std.unsigned(votes_A)));
      score_B := score_sum_array_signal(numeric_std.to_integer(numeric_std.unsigned(votes_B)));
      if (score_A = 0 and score_B = 0) then
        return "00";
      elsif (score_A > score_B) then
        return "10";
      elsif (score_A < score_B) then
        return "01";
      elsif (score_A = score_B) then
        return "11";
      end if;
    end result;
  
  begin
   
    DUT: vote_calculator port map (
      scores_A => test_scores_A,
      scores_B => test_scores_B,
      winner => test_winner
    );
    
    process
    begin
-- Loop generates all combinations of possible vote vectors of length 3
-- by converting integers to vectors.
-- Then compares the design's winner to the test's result. 
      for i in integer range 0 to 7 loop
        for j in integer range 0 to 7 loop
        wait for 10ns;
          test_scores_A <= std_logic_vector(numeric_std.to_unsigned(i, test_scores_A'length));
          test_scores_B <= std_logic_vector(numeric_std.to_unsigned(j, test_scores_B'length));
          assert(test_winner = result(test_scores_A, test_scores_B));
            report "ERROR"
            severity error;
        end loop;
      end loop;
    end process;


end tb;
