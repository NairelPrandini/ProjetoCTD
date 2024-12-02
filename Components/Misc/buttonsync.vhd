library ieee;
use ieee.std_logic_1164.all; 

entity buttonsync is
	port
	(	clk:	in std_logic;
		key:	in std_logic_vector(3 downto 0); 
		key_sync: out std_logic_vector(3 downto 0)
	);
end buttonsync;


architecture ButtonSyncImpl of buttonsync is
type STATES is (EsperaApertar, SaidaAtiva, EsperaSoltar);
signal btn0state, btn1state, btn2state, btn3state : STATES := EsperaApertar;
signal btn0next, btn1next, btn2next, btn3next : STATES := EsperaApertar;
signal key3,key2,key1,key0,btn3,btn2,btn1,btn0: std_logic;
begin

key3 <= key(3);
key2 <= key(2);
key1 <= key(1);
key0 <= key(0);

key_sync <= btn3 & btn2 & btn1 & btn0;

	process (clk) 
	begin
		if clk'event and clk = '1' then
			btn0state <= btn0next;			
			btn1state <= btn1next;
			btn2state <= btn2next;
			btn3state <= btn3next;
		end if;
	end process;
	
	process (key0,btn0state)
	begin
		case btn0state is
			when EsperaApertar =>
				if key0 = '0' then btn0next <= SaidaAtiva; else btn0next <= EsperaApertar; end if;
				btn0 <= '1';
			when SaidaAtiva =>
				if key0 = '0' then btn0next <= EsperaSoltar; else btn0next <= EsperaApertar; end if;	
				btn0 <= '0';
			when EsperaSoltar =>
				if key0 = '0' then btn0next <= EsperaSoltar;	else btn0next <= EsperaApertar; end if;	
				btn0 <= '1';
		end case;		
	end process;
	
	process (key1,btn1state)
	begin
		case btn1state is
			when EsperaApertar =>
				if key1 = '0' then btn1next <= SaidaAtiva; else btn1next <= EsperaApertar; end if;
				btn1 <= '1';
			when SaidaAtiva =>
				if key1 = '0' then btn1next <= EsperaSoltar; else btn1next <= EsperaApertar; end if;	
				btn1 <= '0';
			when EsperaSoltar =>
				if key1 = '0' then btn1next <= EsperaSoltar;	else btn1next <= EsperaApertar; end if;	
				btn1 <= '1';
		end case;		
	end process;
	
	process (key2,btn2state)
	begin
		case btn2state is
			when EsperaApertar =>
				if key2 = '0' then btn2next <= SaidaAtiva; else btn2next <= EsperaApertar; end if;
				btn2 <= '1';
			when SaidaAtiva =>
				if key2 = '0' then btn2next <= EsperaSoltar; else btn2next <= EsperaApertar; end if;	
				btn2 <= '0';
			when EsperaSoltar =>
				if key2 = '0' then btn2next <= EsperaSoltar;	else btn2next <= EsperaApertar; end if;	
				btn2 <= '1';
		end case;		
	end process;
	
	process (key3,btn3state)
	begin
		case btn3state is
			when EsperaApertar =>
				if key3 = '0' then btn3next <= SaidaAtiva; else btn3next <= EsperaApertar; end if;
				btn3 <= '1';
			when SaidaAtiva =>
				if key3 = '0' then btn3next <= EsperaSoltar; else btn3next <= EsperaApertar; end if;	
				btn3 <= '0';
			when EsperaSoltar =>
				if key3 = '0' then btn3next <= EsperaSoltar;	else btn3next <= EsperaApertar; end if;	
				btn3 <= '1';
		end case;		
	end process;

end ButtonSyncImpl;

