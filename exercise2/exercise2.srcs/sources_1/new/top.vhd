library IEEE;
use IEEE.std_logic_1164.all;

entity top is
    Port (
        SW0     : in STD_LOGIC;
        SW1     : in STD_LOGIC;
        SW2     : in STD_LOGIC;
        SW3     : in STD_LOGIC;
        SW4     : in STD_LOGIC;
        SW5     : in STD_LOGIC;
        SW6     : in STD_LOGIC;
        SW7     : in STD_LOGIC;
        GCLK    : in STD_LOGIC;
        
        LD0     : out STD_LOGIC;
        LD1     : out STD_LOGIC;
        LD2     : out STD_LOGIC;
        LD3     : out STD_LOGIC;
        LD7     : out STD_LOGIC
    );
end top;

architecture Behavioral of top is
    signal clock_signal : std_logic; -- signal to map to clk

    component universal_counter is
        Port(
            clk     : in std_logic;
            reset   : in std_logic;
            enable  : in std_logic;
            load    : in std_logic;
            down    : in std_logic;
            data    : in std_logic_vector (3 downto 0);
            
            count   : out std_logic_vector (3 downto 0);
            over    : out std_logic
        );
    end component;

begin

    process
        variable counter : integer;
        
        begin
            
        if(rising_edge(GCLK)) then
            counter := counter + 1; -- add value to counter on every clock cycle
            clock_signal <= '0';

            if(counter = 15000000) then
                clock_signal <= '1'; -- spikes the clock so rising edge is triggered
                counter := 0; -- resets counter
            end if;
        end if;
        
    end process;

    DUT : universal_counter port map ( -- mapping ports to inputs
        reset       => SW0,
        enable      => SW1,
        load        => SW2,
        down        => SW3,
        data(0)     => SW4,
        data(1)     => SW5,
        data(2)     => SW6,
        data(3)     => SW7,
        count(0)    => LD0,
        count(1)    => LD1,
        count(2)    => LD2,
        count(3)    => LD3, 
        over        => LD7,
        clk         => clock_signal
    );
end Behavioral;