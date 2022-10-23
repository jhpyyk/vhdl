----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2022 15:14:53
-- Design Name: 
-- Module Name: led_driver_tb - Behavioral
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

entity led_driver_tb is
--  Port ( );
end led_driver_tb;

architecture Behavioral of led_driver_tb is
    component led_driver
        port (
                clk :           in std_logic;
                reset :         in std_logic;
                loop_flag :     in std_logic;
                alarm :         in std_logic;
                led1 :          out std_logic_vector (7 downto 0);
                led2 :          out std_logic_vector (7 downto 0);
                led3 :          out std_logic_vector (7 downto 0)
              );
    end component;
        
    signal test_clk :           std_logic;
    signal test_reset :         std_logic;
    signal test_loop_flag :     std_logic;
    signal test_alarm :         std_logic;
    signal test_led1 :          std_logic_vector (7 downto 0);
    signal test_led2 :          std_logic_vector (7 downto 0);
    signal test_led3 :          std_logic_vector (7 downto 0);

begin

    DUT : led_driver port map(
            clk         => test_clk,
            reset       => test_reset,
            loop_flag   => test_loop_flag,
            alarm       => test_alarm,
            led1        => test_led1,
            led2        => test_led2,
            led3        => test_led3
    );
    
    clock_process : process
    begin
        wait for 5ns;
        test_clk <= '0';
        wait for 5ns;
        test_clk <= '1';
    end process;
    
    stim_process : process
    begin
    
        test_loop_flag <= '0';
        test_reset <= '1';
        wait for 100ns;
        test_reset <= '0';
        wait for 5000ns;
        
    end process;


end Behavioral;
