library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

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
        LD4     : out STD_LOGIC;
        LD5     : out STD_LOGIC;
        LD6     : out STD_LOGIC;
        LD7     : out STD_LOGIC
    );
end top;

architecture Behavioral of top is

    component universal_counter is
        Port(
            clk     : in std_logic;
            reset   : in std_logic;
            enable  : in std_logic;
            load    : in std_logic;
            down    : in std_logic;
            --data    : in std_logic_vector (7 downto 0);
            
            count0  : out std_logic_vector (3 downto 0);
            count1  : out std_logic_vector (3 downto 0);
            over    : out std_logic
        );
    end component;
    
    signal count0_pwm   : std_logic_vector(3 downto  0);
    signal count1_pwm   : std_logic_vector(3 downto  0);
    signal led_pwm      : std_logic;

begin


    process(count0_pwm, count1_pwm, led_pwm)
        variable pwm_width  : integer := 1;
        variable counter    : integer;
        variable extra      : integer := 0;
        variable count_added: std_logic_vector(7 downto 0);

        begin
        
        count_added(3 downto 0) := count0_pwm(3 downto 0);
        count_added(7 downto 4)  := count1_pwm(3 downto 0);
        counter := to_integer(unsigned(count_added));
        
        
        if (counter = 0) then
            led_pwm <= '1';
        elsif (counter = pwm_width) then
            led_pwm <= '0';
        end if;
        
        if (counter = 255) then
            extra := extra + 1;
        end if;
        
        if(extra = 10) then
            pwm_width := pwm_width + 1;
            extra := 0;
        end if;
        
        if (pwm_width = 255) then
            pwm_width := 0;
        end if;
        
    end process;


    DUT : universal_counter port map (
        reset       => SW0,
        enable      => SW1,
        load        => SW2,
        down        => SW3,
        --data(0)     => SW4,
        --data(1)     => SW5,
        --data(2)     => SW6,
        --data(3)     => SW7,
        count0      => count0_pwm,
        count1      => count1_pwm,
        --over        => LD7,
        clk         => GCLK   
    );
        LD0 <= count0_pwm(0);
        LD1 <= count0_pwm(1);
        LD2 <= count0_pwm(2);
        LD3 <= count0_pwm(3);
        LD6  <= led_pwm;
end Behavioral;