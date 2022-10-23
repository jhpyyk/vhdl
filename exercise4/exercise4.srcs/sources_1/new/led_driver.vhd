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
            clk :           in std_logic;
            reset :         in std_logic;
            speed_logic :   in std_logic_vector(1 downto 0);
            loop_flag :     in std_logic;
            alarm :         in std_logic;
            led1 :          out std_logic_vector (7 downto 0);
            led2 :          out std_logic_vector (7 downto 0);
            led3 :          out std_logic_vector (7 downto 0)
          );

end led_driver;

architecture Behavioral of led_driver is
    constant ones : std_logic_vector := "11111111";
    constant zeros :std_logic_vector := "00000000";
    
    type led_states is      (state1, state2, state3, state4, state5, state6, state7);
    signal current_state :  led_states := state4;
    signal next_state :     led_states;
    
    begin
        process(clk, reset)
            begin
                if (rising_edge(clk)) then
                    if (reset = '1') then
                        current_state <= state4;
                    else
                        current_state <= next_state;
                    end if;
                end if;
        end process;
        
        process(clk, reset, speed_logic, loop_flag, alarm, current_state, next_state)
            variable counter :        integer := 0;
            variable speed :          integer := 1;
            variable standby_counter :  integer := 0;
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
                
                if (rising_edge(clk)) then
                    if (counter = 10 * speed - 1) then
                        case current_state is
                            when state4 =>
                                if (standby_counter = 4) then
                                    next_state <= state1;
                                    standby_counter := 0;
                                else
                                    standby_counter := standby_counter + 1;
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
                                next_state <= state5;
                            end case;
                            counter := 0;
                    else
                        counter := counter + 1;
                    end if;
               end if;
                    
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
                        end case;
                end process;
end Behavioral;
