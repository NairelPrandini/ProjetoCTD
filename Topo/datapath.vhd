LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY datapath IS
	PORT (
		SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0); -- Entrada de dados
		CLOCK_50 : IN STD_LOGIC;
		CLOCK_1HZ : IN STD_LOGIC;
		R1, R2, E1, E2, E3, E4, E5 : IN STD_LOGIC; -- Comandos
		sw_erro, end_game, end_time, end_round : OUT STD_LOGIC; -- Status
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- Saida de dados
		LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) -- Saida de dados
	);
END datapath;

ARCHITECTURE circuito OF datapath IS
	--============================================================--
	--                      COMPONENTS                            --
	--============================================================--
	-------------------DIVISOR DE FREQUENCIA------------------------

	COMPONENT div_freq IS
		PORT (
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			CLK_1Hz : OUT STD_LOGIC
		);
	END COMPONENT;

	------------------------CONTADORES------------------------------

	COMPONENT counter_time IS
		PORT (
			clock, reset, enable : IN STD_LOGIC;
			load : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			end_time : OUT STD_LOGIC;
			tempo : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT counter0to10 IS
		PORT (
			enable, reset, clock : IN STD_LOGIC;
			round : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			end_round : OUT STD_LOGIC
		);
	END COMPONENT;

	-------------------ELEMENTOS DE MEMORIA-------------------------

	COMPONENT reg8bits IS
		PORT (
			clock, reset, enable : IN STD_LOGIC;
			D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT reg10bits IS
		PORT (
			clock, reset, enable : IN STD_LOGIC;
			D : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			Q : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT ROM IS
		PORT (
			address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			data : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
	END COMPONENT;

	---------------------MULTIPLEXADORES----------------------------

	COMPONENT mux2pra1_4bits IS
		PORT (
			sel : IN STD_LOGIC;
			x, y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mux2pra1_7bits IS
		PORT (
			sel : IN STD_LOGIC;
			x, y : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
			saida : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mux2pra1_8bits IS
		PORT (
			sel : IN STD_LOGIC;
			x, y : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			saida : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mux2pra1_10bits IS
		PORT (
			sel : IN STD_LOGIC;
			x, y : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			saida : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
	END COMPONENT;

	----------------------DECODIFICADOR-----------------------------

	COMPONENT decod7seg IS
		PORT (
			c : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			h : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;

	-------------------COMPARADORES E SOMA--------------------------

	COMPONENT comp IS
		PORT (
			seq_user : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			seq_reg : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			seq_mask : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT comp_igual4 IS
		PORT (
			a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			tm : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT soma IS
		PORT (
			seq : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			soma_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

	--============================================================--
	--                      SIGNALS                               --
	--============================================================--
	-- Sinais dos Contadores

	SIGNAL CLK_1Hz : STD_LOGIC;

	SIGNAL Level_time : STD_LOGIC_VECTOR(3 DOWNTO 0);

	SIGNAL Level_code : STD_LOGIC_VECTOR(3 DOWNTO 0);

	SIGNAL TIME : STD_LOGIC_VECTOR(3 DOWNTO 0);

	SIGNAL Round : STD_LOGIC_VECTOR(3 DOWNTO 0);

	-- Sinais dos Registros
	SIGNAL regA_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL regB_s : STD_LOGIC_VECTOR(9 DOWNTO 0);

	--SaidaRom
	SIGNAL Code : STD_LOGIC_VECTOR(9 DOWNTO 0);
	----------------------------
	SIGNAL BTMuxA_s : STD_LOGIC_VECTOR(3 DOWNTO 0);

	SIGNAL BTMuxB_s : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL BTMuxC_s : STD_LOGIC_VECTOR(6 DOWNTO 0);

	SIGNAL BTDecod_s : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL BTMUXEN : STD_LOGIC;

	---------------------
	SIGNAL BDMuxA_s : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL BDMuxC_s : STD_LOGIC_VECTOR(6 DOWNTO 0);

	SIGNAL BDMUXRST : STD_LOGIC;

	SIGNAL BDDecodA_s : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL BDDecodB_s : STD_LOGIC_VECTOR(6 DOWNTO 0);

	SIGNAL BRComp_s : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL BRSomaA_s : STD_LOGIC_VECTOR(3 DOWNTO 0);

	SIGNAL BRSomaB_s : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL Input_BRMuxA_x : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL Input_BRMuxA_y : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL BRMuxA_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL EN_RegC : STD_LOGIC;
	SIGNAL RegC_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL InputBRDecodA : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL InputBRDecodB : STD_LOGIC_VECTOR(3 DOWNTO 0);

	--letras
	SIGNAL t : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL n : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL r : STD_LOGIC_VECTOR(6 DOWNTO 0);


	SIGNAL end_game_signal : STD_LOGIC;


	SIGNAL FINAL_RESULT : STD_LOGIC_VECTOR(9 DOWNTO 0);


	SIGNAL BRCompIgual4A_s : STD_LOGIC;

BEGIN
	u0 : div_freq PORT MAP(CLOCK_50, R2, CLK_1Hz);

	------------------------CONTADORES------------------------------


	--IF EMULATOR USE CLOCK_1HZ INSTEAD OF CLK_1HZ SIGNAL


	ucnt_time : counter_time PORT MAP(CLOCK_1HZ, R1, E2, Level_time, end_time, TIME);

	ucnt_round : counter0to10 PORT MAP(E3, R2, CLOCK_50, Round, end_round);

	-------------------ELEMENTOS DE MEMORIA-------------------------
	--BR

	regA : reg8bits PORT MAP(CLOCK_50, R2, E1, SW(7 DOWNTO 0), regA_s);

	regB : reg10bits PORT MAP(CLOCK_50, R2, E2, SW(9 DOWNTO 0), regB_s);

	regC : reg8bits PORT MAP(CLOCK_50, R2, EN_RegC, BRMuxA_s, RegC_s);

	urom : ROM PORT MAP(Level_code, Code);

	---------------------MULTIPLEXADORES----------------------------

	--BT
	BTMuxA : mux2pra1_4bits PORT MAP(E2, Level_time, TIME, BTMuxA_s);
	BTMuxB : mux2pra1_7bits PORT MAP(BTMUXEN, "1111111", t, HEX5);
	BTMuxC : mux2pra1_7bits PORT MAP(BTMUXEN, "1111111", BTDecod_s, HEX4);
	--------------------------------

	--BD
	BDMuxA : mux2pra1_7bits PORT MAP(E1, "1111111", n, BDMuxA_s);
	BDMuxB : mux2pra1_7bits PORT MAP(BDMUXRST, BDMuxA_s, r, HEX3);
	BDMuxC : mux2pra1_7bits PORT MAP(E1, "1111111", BDDecodB_s, BDMuxC_s);
	BDMuxD : mux2pra1_7bits PORT MAP(BDMUXRST, BDMuxC_s, BDDecodA_s, HEX2);

	--BR

	BRMuxA : mux2pra1_8bits PORT MAP(E5, Input_BRMuxA_x, Input_BRMuxA_y, BRMuxA_s);

	BRMuxB : mux2pra1_10bits PORT MAP(E5, "0000000000", Code, FINAL_RESULT);
	-------------------COMPARADORES E SOMA--------------------------

	--BR
	BRComp : comp PORT MAP(Code, regB_s, BRComp_s);

	BRSomaB : soma PORT MAP(BRComp_s, BRSomaB_s);
	--Saida end_game

	BRCompIgual4B : comp_igual4 PORT MAP(BRSomaB_s, end_game_signal); ----Saida end_game

	---Saida SwErro

	BRSomaA : soma PORT MAP(regB_s, BRSomaA_s);

	BRCompIgual4A : comp_igual4 PORT MAP(BRSomaA_s, BRCompIgual4A_s);

	---------------------DECODIFICADORES----------------------------

	-- a fazer pel@ alun@
	BTDecod : decod7seg PORT MAP(BTMuxA_s, BTDecod_s);

	--BD
	BDDecodA : decod7seg PORT MAP(Round, BDDecodA_s);
	BDDecodB : decod7seg PORT MAP(Level_code, BDDecodB_s);

	--BR
	BRDecodA : decod7seg PORT MAP(InputBRDecodA, HEX1);
	BRDecodB : decod7seg PORT MAP(InputBRDecodB, HEX0);

	---------------------ATRIBUICOES DIRETAS---------------------

	Level_code <= regA_s(3 DOWNTO 0);
	Level_time <= regA_s(7 DOWNTO 4);

	BTMUXEN <= (E1 OR E2);
	BDMUXRST <= (R1 XOR R2);
	Input_BRMuxA_x <= "1010" & BRSomaB_s;
	Input_BRMuxA_y <= "000" & end_game_signal & NOT(Round);
	EN_RegC <= (E4 OR E5);
	InputBRDecodA <= RegC_s(7 DOWNTO 4);
	InputBRDecodB <= RegC_s(3 DOWNTO 0);



	LEDR <= FINAL_RESULT;

	sw_erro <= NOT(BRCompIgual4A_s);

	end_game <= end_game_signal;

	t <= "0000111";
	n <= "0101011";
	r <= "0101111";

END circuito;