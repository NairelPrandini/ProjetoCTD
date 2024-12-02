LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY comp_igual4 IS
    PORT (
        a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        tm : OUT STD_LOGIC
    );
END comp_igual4;

ARCHITECTURE logica OF comp_igual4 IS
BEGIN
    tm <= '1' WHEN a = "0100" ELSE
        '0';
END logica;