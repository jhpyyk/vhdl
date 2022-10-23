library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity universal_counter is
    Port (
        clk :       in std_logic;
        reset :     in std_logic;
        enable :    in std_logic;
        load :      in std_logic;
        down:       in std_logic;
        data :      in std_logic_vector (7 downto 0) := "00000000";
        count0 :     out std_logic_vector (3 downto 0) := "0000";
        count1 :     out std_logic_vector (3 downto 0) := "0000";
        over :      out std_logic := '0'
    );
end universal_counter;

architecture Behavioral of universal_counter is
    signal clk_div : std_logic;
    begin
    
        process(clk)
            variable counter : integer := 0;
            variable divider : integer := 5000;
            
            begin
                if(rising_edge(clk)) then
                    counter := counter + 1; -- add value to counter on every clock cycle
                    if(counter = divider) then
                        clk_div <= '1';
                    elsif (counter = 2 * divider) then
                        counter := 0;
                        clk_div <= '0';
                    end if;
                end if;
            
        end process;

        process(reset, clk_div, enable, load, down, data)
        
        variable number0 : integer := 0;
        variable number1 : integer := 0;
    
        begin
        if (reset = '1') then
            number0 := 0;
            number1 := 0;
            count0 <= "0000";
            count1 <= "0000";
            over <= '0';
         elsif(rising_edge(clk_div)) then
                if(enable = '1') then
                    if(load = '1') then 
                        count0 <= data(3 downto 0);
                        count1 <= data(7 downto 4);
                        number0 := to_integer(unsigned(data(3 downto 0)));
                        number1 := to_integer(unsigned(data(7 downto 4)));
                        
                    elsif(down = '1') then
                        
                        if(number0 = 0) then
                            number0 := 15;  
                            number1 := number1 - 1;
                            if (number1 = -1) then
                                number1 := 15;
                                over <= '1';
                                count1 <= std_logic_vector(to_unsigned(number1, count1'length));
                            end if;
                            count1 <= std_logic_vector(to_unsigned(number1, count1'length));
                        else
                            number0 := number0 - 1;
                        end if;
                        count0 <= std_logic_vector(to_unsigned(number0, count0'length));
                                       
                    elsif (down = '0') then     
                        if(number0 = 15) then
                            number0 := 0;
                            number1 := number1 + 1;
                            if (number1 = 16) then
                                number1 := 0;
                                over <= '1';
                            end if;
                            count1 <= std_logic_vector(to_unsigned(number1, count1'length));
                        else
                            number0 := number0 + 1;
                        end if;
                        count0 <= std_logic_vector(to_unsigned(number0, count0'length));
                      
                    end if; --load            
                end if; --enable
            end if; --reset
        end process;
    
end Behavioral;