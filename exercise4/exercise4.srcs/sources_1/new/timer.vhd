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
    generic( speed_gen: natural := 1 );
    port(
        speed_logic :       in std_logic_vector(1 downto 0);
        clk :               in std_logic;
        alarm :             in std_logic;
        timer_out_normal :  out std_logic;
        timer_out_alarm :   out std_logic;
        alarm_flag :        out std_logic
     );
     constant clk_freq :    natural := 125_000_000;
     constant clk_div :     natural := clk_freq / 10;
     signal timer_out :     std_logic;
end entity timer;


architecture Behavioral of timer is
    begin
        timer_normal : entity work.timer
            generic map (speed_gen => 10)
            port map(
                    speed_logic => speed_logic,
                    clk => clk,
                    alarm => alarm,
                    timer_out_normal => timer_out
                    );
        timer_alarm : entity work.timer
            generic map (speed_gen => 1)
            port map(
                    speed_logic => speed_logic,
                    clk => clk,
                    alarm => alarm,
                    timer_out_alarm => timer_out
                    );
                    
        process (clk)
            variable speed :        natural := 0;
            variable counter :      natural := 0;
            variable counter_alarm :      natural := 0;
            variable half_cycle :   natural;
            begin
                -- speed 1 is every second
                -- speed 3 is every 3 seconds
                -- speed 5 is every 5 seconds
                -- in alarm state speeds are 10 times faster
                if (speed_logic = "00") then
                    speed := speed_gen * 1;           
                elsif (speed_logic = "01") then
                    speed := speed_gen * 3;
                elsif (speed_logic = "11") then
                    speed := speed_gen * 5;
                else
                    speed := speed_gen * 1;
                end if;
                
                if (alarm = '1') then
                    alarm_flag <= '1';
                end if;
                
                if (alarm = '0') then
                    if (alarm_flag = '1') then
                        if (counter_alarm = clk_freq * speed) then
                            alarm_flag <= '0';
                            counter_alarm := 0;
                        else
                            counter_alarm := counter_alarm + 1;
                        end if;
                    end if;
                end if;
                
                half_cycle := (clk_div * speed) / 2;
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
