----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2022 12:18:45
-- Design Name: 
-- Module Name: led_driver - Behavioral
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

entity led_driver is
    port (
            timer_normal :  in std_logic;
            timer_alarm :   in std_logic;
            reset :         in std_logic;
            loop_flag :     in std_logic;
            alarm_flag :    in std_logic;
            led1 :          out std_logic_vector (7 downto 0);
            led2 :          out std_logic_vector (7 downto 0);
            led3 :          out std_logic_vector (7 downto 0)
          );
            signal clk : std_logic;
end led_driver;

architecture Behavioral of led_driver is
    constant ones : std_logic_vector := "11111111";
    constant zeros :std_logic_vector := "00000000";
    
    type led_states is      (state1, state2, state3, state4, state5, state6, state7, state_alarm);
    signal current_state :  led_states := state4;
    signal next_state :     led_states;
    
    begin
        process(clk, timer_normal, timer_alarm, alarm_flag, reset, current_state, next_state)
            begin
                if (alarm_flag = '1') then
                    clk <= timer_alarm;
                else
                    clk <= timer_normal;
                end if;
                
                if (rising_edge(clk)) then
                    if (reset = '1') then
                        current_state <= state4;
                    elsif (alarm_flag = '1' and (not (current_state = state_alarm))) then
                        current_state <= state_alarm;
                    else
                        current_state <= next_state;
                    end if;
                end if;
        end process;
        
        process(clk, timer_normal, timer_alarm, alarm_flag, reset, current_state, next_state)
            variable standby_counter :  integer := 0;
            begin
                case current_state is
                    when state4 =>
                        if (standby_counter = 4) then
                            next_state <= state1;
                            standby_counter := 0;
                        elsif (reset = '0') then
                            if (rising_edge(clk)) then
                                standby_counter := standby_counter + 1;
                            end if;
                        else
                            next_state <= state4;
                        end if;
                    when state1 =>
                        next_state <= state6;
                    when state6 =>
                        if (loop_flag = '0') then
                            next_state <= state2;
                        else
                            next_state <= state7;
                        end if;
                    when state2 =>
                        if (loop_flag = '0') then
                            next_state <= state3;
                        else
                            next_state <= state6;
                        end if;
                    when state3 =>
                        if (loop_flag = '0') then
                            next_state <= state7;
                        else
                            next_state <= state2;
                        end if;
                    when state7 =>
                        if (loop_flag = '0') then
                            next_state <= state1;
                        else
                            next_state <= state3;
                        end if;
                    when state5 =>
                        next_state <= state_alarm;
                    when state_alarm => 
                        if (alarm_flag = '1') then
                            next_state <= state5;
                        else
                            next_state <= state4;
                        end if;
                    end case;
                    
                    case current_state is
                        when state1 =>
                            led1 <= ones;
                            led2 <= zeros;
                            led3 <= zeros;
                        when state2 =>
                            led1 <= zeros;
                            led2 <= ones;
                            led3 <= zeros;
                        when state3 =>
                            led1 <= zeros;
                            led2 <= zeros;
                            led3 <= ones;
                        when state4 =>
                            led1 <= ones;
                            led2 <= ones;
                            led3 <= ones;
                        when state5 =>
                            led1 <= zeros;
                            led2 <= zeros;
                            led3 <= zeros;
                        when state6 =>
                            led1 <= ones;
                            led2 <= ones;
                            led3 <= zeros;
                        when state7 =>
                            led1 <= "10000000";
                            led2 <= zeros;
                            led3 <= "10000000";
                        when state_alarm => 
                            led1 <= ones;
                            led2 <= ones;
                            led3 <= ones;
                        end case;
                end process;
end Behavioral;
