LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY reg10bits IS PORT (
	clock, reset, enable : IN STD_LOGIC;
	D : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	Q : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
);
END reg10bits;

ARCHITECTURE behv OF reg10bits IS
BEGIN
	PROCESS (clock, D, reset)
	BEGIN
		IF reset = '1' THEN
			Q <= "0000000000";
		ELSIF (clock'event AND clock = '1') THEN
			IF enable = '1' THEN
				Q <= D;
			END IF;
		END IF;
	END PROCESS;
END behv;