LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

--para uso com o clock de 50MHz da placa DE2 (CLOCK_50)

ENTITY div_freq IS
	PORT (
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		CLK_1Hz : OUT STD_LOGIC
	);
END div_freq;

ARCHITECTURE circuito OF div_freq IS
	SIGNAL cont : STD_LOGIC_VECTOR(27 DOWNTO 0); -- Registra valor da contagem

BEGIN
	P1 : PROCESS (clk, reset, cont)
	BEGIN

		IF reset = '1' THEN
			cont <= x"0000000";
			CLK_1Hz <= '0';

		ELSIF clk'event AND clk = '1' THEN

			--1Hz = 50.000.000Hz / 50.000.000
			IF cont < x"2FAF07F" THEN --se contador < 49.999.999 (2FAF07F em hexadecimal)
				CLK_1Hz <= '0';
				cont <= cont + 1;

			ELSE
				cont <= x"0000000";
				CLK_1Hz <= '1';

			END IF;
		END IF;
	END PROCESS;

END circuito;