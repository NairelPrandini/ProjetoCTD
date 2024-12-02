LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;

ENTITY usertop IS
	PORT (
		CLOCK_50 : IN STD_LOGIC;
		CLK_500Hz : IN STD_LOGIC;
		---RKEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		---RSW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END usertop;
ARCHITECTURE circuito OF usertop IS

	COMPONENT datapath IS
		PORT (
			SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0); -- Entrada de dados
			CLOCK_50 : IN STD_LOGIC;
			CLOCK_1HZ : IN STD_LOGIC;
			R1, R2, E1, E2, E3, E4, E5 : IN STD_LOGIC; -- Comandos
			sw_erro, end_game, end_time, end_round : OUT STD_LOGIC; -- Status
			HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- Saida de dados
			LEDR : OUT STD_LOGIC_VECTOR(9 DOWNTO 0) -- Saida de dados
		);
	END COMPONENT;

	COMPONENT controle IS
		PORT (
			enter, reset, clock : IN STD_LOGIC;
			sw_erro, end_game, end_time, end_round : IN STD_LOGIC; -- Status
			R1, R2, E1, E2, E3, E4, E5 : OUT STD_LOGIC -- Comandos
		);
	END COMPONENT;

	COMPONENT buttonsync IS
		PORT (
			clk : IN STD_LOGIC;
			key : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			key_sync : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

	-- Sinais
	SIGNAL SyncKeys : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL R1_s, R2_s, E1_s, E2_s, E3_s, E4_s, E5_s : STD_LOGIC;
	SIGNAL sw_erro_s, end_game_s, end_time_s, end_round_s : STD_LOGIC;
	
	
    SIGNAL EnterKey: STD_LOGIC;
    SIGNAL ResetKey: STD_LOGIC;
	

BEGIN

	ubs : buttonsync PORT MAP(CLOCK_50, KEY, SyncKeys);
	
	EnterKey <= NOT(SyncKeys(1));
	ResetKey <= NOT(SyncKeys(0));
	
	
    udat : datapath PORT MAP(
		SW(9 DOWNTO 0),
		CLOCK_50,
		CLK_500Hz,
		R1_s, R2_s, E1_s, E2_s, E3_s, E4_s, E5_s, -- Comandos INPUT
		sw_erro_s, end_game_s, end_time_s, end_round_s,  -- Status
		HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
		LEDR(9 DOWNTO 0) -- Saida de dados
	);

	uctrl : controle PORT MAP(
		EnterKey, ResetKey, CLOCK_50,
		sw_erro_s, end_game_s, end_time_s, end_round_s, -- Status
		R1_s, R2_s, E1_s, E2_s, E3_s, E4_s, E5_s -- Comandos OUTPUT
	);	


END ARCHITECTURE;