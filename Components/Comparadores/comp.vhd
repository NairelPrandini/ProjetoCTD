LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY comp IS
    PORT (
        seq_user : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        seq_reg : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        seq_mask : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END comp;

ARCHITECTURE logica OF comp IS
BEGIN
    seq_mask(0) <= (seq_user(0) AND seq_reg(0));
    seq_mask(1) <= (seq_user(1) AND seq_reg(1));
    seq_mask(2) <= (seq_user(2) AND seq_reg(2));
    seq_mask(3) <= (seq_user(3) AND seq_reg(3));
    seq_mask(4) <= (seq_user(4) AND seq_reg(4));
    seq_mask(5) <= (seq_user(5) AND seq_reg(5));
    seq_mask(6) <= (seq_user(6) AND seq_reg(6));
    seq_mask(7) <= (seq_user(7) AND seq_reg(7));
    seq_mask(8) <= (seq_user(8) AND seq_reg(8));
    seq_mask(9) <= (seq_user(9) AND seq_reg(9));

END logica;