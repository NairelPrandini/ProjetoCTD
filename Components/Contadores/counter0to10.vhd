library ieee;
use ieee.std_logic_1164.all;
USE IEEE.std_logic_unsigned.ALL;

entity counter0to10 is
    port (
    	enable, reset, clock : IN STD_LOGIC;
        round : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        end_round : OUT STD_LOGIC
    );
end entity;

architecture circuito of counter0to10 is
    signal contador : std_logic_vector(3 downto 0) := "0000";
    
    begin
        round <= contador;
        
        process (reset, enable, contador, clock)
        begin
            if (reset = '1') then
                end_round <= '0';
                contador <= "0000";
            elsif (contador = "1010") then
                end_round <= '1';
            elsif (clock'event and clock = '1') then
                if (enable = '1') then
                    contador <= contador + "0001";
                end if;
            end if;
        end process;
end circuito;