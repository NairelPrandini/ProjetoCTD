LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY controle IS
	PORT (
		enter, reset, clock : IN STD_LOGIC;
		sw_erro, end_game, end_time, end_round : IN STD_LOGIC; -- Status
		R1, R2, E1, E2, E3, E4, E5 : OUT STD_LOGIC -- Comandos
	);
END ENTITY;

ARCHITECTURE arc OF controle IS
	TYPE states IS (Init, Setup, Play, Count_Round, Check, Waits, Result);
	SIGNAL EA, PE : states;


	SIGNAL entradas : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL Output : STD_LOGIC_VECTOR(6 DOWNTO 0);


BEGIN
	-- FSM usando dois processos, deve ser feita pelo aluno.

	P1 : PROCESS (reset, clock, PE)
    BEGIN
        IF reset = '1' THEN
            EA <= Init;
        ELSIF clock'event AND clock = '1' THEN
            EA <= PE;
        END IF;
    END PROCESS;


	entradas <= enter & sw_erro & end_game & end_time & end_round;

	P2 : PROCESS (EA, entradas)
    BEGIN
        CASE EA IS
            WHEN Init =>
                Output <= "1100000";  ---ok
                IF entradas(4) = '1' THEN
                    PE <= Setup;
                ELSE
                    PE <= Init;
                END IF;
            WHEN Setup =>
                Output <= "0010000"; ---ok
				IF entradas(4) = '1' THEN
                    PE <= Play;
                ELSE
                    PE <= Setup;
                END IF;
            WHEN Play =>
                Output <= "0001000";  ---ok
                IF entradas(1) = '1' THEN
                    PE <= Result;
                ELSIF (entradas(4) = '1' AND entradas(1) = '0') THEN
                    PE <= Count_Round;
                ELSE
                    PE <= Play;
                END IF;
            WHEN Count_Round =>
                Output <= "0000100";
                PE <= Check;
            WHEN Check =>
                Output <= "0000010";
                IF ((entradas(3) = '1') OR (entradas(2) = '1') OR (entradas(0) = '1')) THEN
                    PE <= Result;
                ELSE
                    PE <= Waits;
                END IF;
            WHEN Waits =>
                Output <= "1000010";
                IF entradas(4) = '1' THEN
                    PE <= Play;
                ELSE
                    PE <= Waits;
                END IF;
            WHEN Result =>
                Output <= "0000001";
                IF entradas(4) = '1' THEN
                    PE <= Init;
                ELSE
                    PE <= Result;
                END IF;
                
        END CASE;
    END PROCESS;


	R1 <= Output(6);
	R2 <= Output(5);
	E1 <= Output(4);
	E2 <= Output(3);
	E3 <= Output(2);
	E4 <= Output(1);
	E5 <= Output(0);

END ARCHITECTURE;