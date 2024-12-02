LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY counter_time IS
    PORT (
        clock, reset, enable : IN STD_LOGIC;
        load : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        end_time : OUT STD_LOGIC;
        tempo : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END counter_time;

ARCHITECTURE count OF counter_time IS
    signal contador : std_logic_vector(3 downto 0) := "0000";
BEGIN

    PROCESS (clock, reset)
    BEGIN
        IF reset = '1' THEN
            contador <= "0000";
            end_time <= '0';
        ELSIF (clock'event AND clock = '1') THEN
            IF enable = '1' THEN
                IF contador = load THEN
                    end_time <= '1';
                ELSE
                    contador <= contador + "0001";
                    end_time <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;
    tempo <= contador;

END count;