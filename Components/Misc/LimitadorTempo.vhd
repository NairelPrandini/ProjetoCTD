library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all; -- Change from std_logic_signed to std_logic_unsigned

entity LimitadorTempo is
	port (
		tempo : in std_logic_vector(3 downto 0);
		saida : out std_logic_vector(3 downto 0)
	);
end LimitadorTempo;

architecture circuito of LimitadorTempo is
begin
	saida <= "0101" when tempo < "0101" else
			 "1010" when tempo > "1010" else
			 tempo;
end circuito;
