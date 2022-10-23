----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2022 13:17:14
-- Design Name: 
-- Module Name: universal_counter_tb - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity universal_counter_tb is
--  Port ( );
end universal_counter_tb;

architecture Behavioral of universal_counter_tb is
    component universal_counter
        port(
            reset : in std_logic;
            enable : in std_logic;
            load : in std_logic;
            down : in std_logic;
            data : in std_logic_vector (3 downto 0);
            count : out std_logic_vector (3 downto 0);
            over : out std_logic;
            clk : in std_logic
        );
    end component;
    
        signal test_reset : std_logic;
        signal test_enable : std_logic;
        signal test_load : std_logic;
        signal test_down : std_logic;
        signal test_data : std_logic_vector (3 downto 0);
        signal test_count : std_logic_vector (3 downto 0);
        signal test_over : std_logic;
        signal test_clk : std_logic;
    
    begin

    DUT : universal_counter port map(
        reset => test_reset,
        enable => test_enable,
        load => test_load,
        down => test_down,
        data => test_data,
        count => test_count,
        over => test_over,
        clk => test_clk    
    );
    
    process
    
    begin
        wait for 10ns;
        
        test_reset <= '0';
        test_enable <= '0';
        test_load <= '0';
        test_down <= '0';
        test_data <= "0000";
        test_clk <= '0';

        
        -- Testing reset
        test_reset <= '1';
        
        -- These should be irrelevant
        test_enable <= '1';
        test_load <= '1';
        
        for i in 0 to 20 loop
            test_clk <= '1';
            wait for 10ns;
            test_clk <= '0';
            wait for 10ns;
        end loop;
        test_reset <= '1';
        test_clk <= '1';
        wait for 10ns;
        test_reset <= '0';
        test_clk <= '0';
        test_enable <= '0';
        test_load <= '0';
        test_down <= '0';
        
        
        --Testing enable = 0
        wait for 50ns;
        test_enable <= '0';
        
        for i in 0 to 20 loop
            test_clk <= '1';
            wait for 10ns;
            test_clk <= '0';
            wait for 10ns;
        end loop;
        test_reset <= '1';
        test_clk <= '1';
        wait for 10ns;
        test_reset <= '0';
        test_clk <= '0';
        test_enable <= '0';
        test_load <= '0';
        test_down <= '0';
        
        
        --Testing enable = 1
        wait for 50ns;

        test_enable <= '1';
        
        for i in 0 to 20 loop
            test_clk <= '1';
            wait for 10ns;
            test_clk <= '0';
            wait for 10ns;
        end loop;
        test_reset <= '1';
        test_clk <= '1';
        wait for 10ns;
        test_reset <= '0';
        test_clk <= '0';
        test_enable <= '0';
        test_load <= '0';
        test_down <= '0';
                
                
        --Testing counting up
        wait for 50ns;
        test_enable <= '1';
        test_down <= '0';
        
        for i in 0 to 20 loop
            test_clk <= '1';
            wait for 10ns;
            test_clk <= '0';
            wait for 10ns;
        end loop;
        test_reset <= '1';
        test_clk <= '1';
        wait for 10ns;
        test_reset <= '0';
        test_clk <= '0';
        test_enable <= '0';
        test_load <= '0';
        test_down <= '0';
        
        
        --Testing counting down
        wait for 50ns;
        test_enable <= '1';
        test_down <= '1';
        
        for i in 0 to 20 loop
            test_clk <= '1';
            wait for 10ns;
            test_clk <= '0';
            wait for 10ns;
        end loop;
        test_reset <= '1';
        test_clk <= '1';
        wait for 10ns;
        test_reset <= '0';
        test_clk <= '0';
        test_enable <= '0';
        test_load <= '0';
        test_down <= '0';
        
    end process;
    
    
end Behavioral;
