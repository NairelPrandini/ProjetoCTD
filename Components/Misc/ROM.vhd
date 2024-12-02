-- Armazena as opcoes das sequencias. O conteudo da memoria deve ser preenchido pelo aluno

-----------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
------------------------------------
ENTITY rom IS
	PORT (
		address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		data : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE circuito OF rom IS
	TYPE memory IS ARRAY (00 TO 15) OF STD_LOGIC_VECTOR(9 DOWNTO 0);
	CONSTANT my_rom : memory := (
		00 => "0001010101",
		01 => "0100011010",
		02 => "0011100100",
		03 => "0001100101",
		04 => "0110101000",
		05 => "1010010100",
		06 => "1100001100",
		07 => "0101100010",
		08 => "0010110100",
		09 => "1001010010",
		10 => "0110011000",
		11 => "1010001010",
		12 => "1101000001",
		13 => "0100101100",
		14 => "0011001010",
		15 => "1000110100"
	);
BEGIN
	data <= my_rom(00) WHEN address = "0000" ELSE
		my_rom(01) WHEN address = "0001" ELSE
		my_rom(02) WHEN address = "0010" ELSE
		my_rom(03) WHEN address = "0011" ELSE
		my_rom(04) WHEN address = "0100" ELSE
		my_rom(05) WHEN address = "0101" ELSE
		my_rom(06) WHEN address = "0110" ELSE
		my_rom(07) WHEN address = "0111" ELSE
		my_rom(08) WHEN address = "1000" ELSE
		my_rom(09) WHEN address = "1001" ELSE
		my_rom(10) WHEN address = "1010" ELSE
		my_rom(11) WHEN address = "1011" ELSE
		my_rom(12) WHEN address = "1100" ELSE
		my_rom(13) WHEN address = "1101" ELSE
		my_rom(14) WHEN address = "1110" ELSE
		my_rom(15);

END circuito;