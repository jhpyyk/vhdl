----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2022 12:35:59
-- Design Name: 
-- Module Name: universal_counter - Behavioral
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

entity universal_counter is
    port(
            reset : in std_logic;
            enable : in std_logic;
            load : in std_logic;
            down : in std_logic;
            data : in std_logic_vector (3 downto 0);
            count : out std_logic_vector (3 downto 0);
            over : out std_logic
  );
end universal_counter;

architecture Behavioral of universal_counter is

begin
    process(reset, enable, load, down, data)
    begin
        if (reset = '1') then
            count <= "0000";
            over <= '0';
        elsif (enable = '1') then
        
            if (load = '1') then 
                count <= data;
            elsif (down = '1') then
                count <= count;
            else
                count <= count;
            end if;
            
            
        end if;
    end process;
end Behavioral;
