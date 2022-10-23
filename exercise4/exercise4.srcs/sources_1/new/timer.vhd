----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2022 12:18:45
-- Design Name: 
-- Module Name: timer - Behavioral
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

entity timer is
    port(
            clk :       in std_logic;
            timer_out : out std_logic
         );
end timer;


architecture Behavioral of timer is
    begin
        process (clk)
            variable clk_freq : integer := 125_000_000;
            variable counter : integer := 0;
            variable half_cycle : integer := clk_freq / (10 * 2); -- 5Hz; full cycle 10Hz
            begin
                if (rising_edge(clk)) then
                    counter := counter + 1;
                    
                    if (counter = half_cycle) then
                        timer_out <= '0';
                    elsif (counter = 2 * half_cycle) then
                        timer_out <= '1';
                        counter := 0;
                    end if;

                end if;
        end process;

end Behavioral;
