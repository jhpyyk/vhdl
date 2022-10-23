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
        data :      in std_logic_vector (3 downto 0);
        count :     out std_logic_vector (3 downto 0) := "0000";
        over :      out std_logic := '0'
    );
end universal_counter;

architecture Behavioral of universal_counter is

begin

    process(reset, clk)
    
    variable number : integer := 0;

    begin
        if(rising_edge(clk)) then
            if (reset = '1') then
                number := 0;
                count <= "0000";
                over <= '0';
            elsif(enable = '1') then
                if(load = '1') then 
                    count <= data;
                    number := to_integer(unsigned(data));
                    
                elsif(down = '1') then
                    
                    if(number = 0) then
                        over <= '1';
                        number := 15;
                    else
                        number := number - 1;
                    end if;
                    count <= std_logic_vector(to_unsigned(number, count'length));
                                   
                elsif (down = '0') then     
                    if(number = 15) then
                        over <= '1';
                        number := 0;
                    else
                        number := number + 1;
                    end if;
                    count <= std_logic_vector(to_unsigned(number, count'length));
                  
                end if; --load            
            end if; --enable
        end if; --reset
    end process;
    
end Behavioral;