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
            
            count0   : out std_logic_vector (3 downto 0);
            count1   : out std_logic_vector (3 downto 0);
            over    : out std_logic
        );
    end component;

begin


    DUT : universal_counter port map ( -- mapping ports to inputs
        reset       => SW0,
        enable      => SW1,
        load        => SW2,
        down        => SW3,
        --data(0)     => SW4,
        --data(1)     => SW5,
        --data(2)     => SW6,
        --data(3)     => SW7,
        count0(0)    => LD0,
        count0(1)    => LD1,
        count0(2)    => LD2,
        count0(3)    => LD3,
        count1(0)    => LD4,
        count1(1)    => LD5,
        count1(2)    => LD6,
        count1(3)    => LD7,  
        --over        => LD7,
        clk         => GCLK
    );
end Behavioral;