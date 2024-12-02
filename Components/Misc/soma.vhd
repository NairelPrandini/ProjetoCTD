LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY soma IS
        PORT (
            seq : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            soma_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
END soma;

ARCHITECTURE logica OF soma IS
BEGIN
    soma_out <= (
        ("000" & seq(9)) +
        ("000" & seq(8)) +
        ("000" & seq(7)) +
        ("000" & seq(6)) +
        ("000" & seq(5)) +
        ("000" & seq(4)) +
        ("000" & seq(3)) +
        ("000" & seq(2)) +
        ("000" & seq(1)) +
        ("000" & seq(0))
    );
END logica;