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
            speed_logic:      in std_logic_vector(1 downto 0);
            clk :       in std_logic;
            timer_out : out std_logic
         );
end timer;


architecture Behavioral of timer is
    begin
        process (clk)
            variable speed : integer;
            variable clk_freq : integer := 125_000_000;
            variable counter : integer := 0;
            variable half_cycle : integer;
            begin
                -- speed 1 is every second
                -- speed 3 is every 3 seconds
                -- speed 5 is every 5 seconds
                if (speed_logic = "00") then
                    speed := 1;           
                elsif (speed_logic = "01") then
                    speed := 3;
                elsif (speed_logic = "11") then
                    speed := 5;
                else
                    speed := 1;
                end if;
                
                half_cycle := (clk_freq * speed) / 2;
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
