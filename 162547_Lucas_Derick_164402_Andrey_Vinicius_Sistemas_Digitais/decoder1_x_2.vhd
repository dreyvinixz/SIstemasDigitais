library ieee;
use ieee.std_logic_1164.all;

entity decoder1_x_2 is
	port (
		i_a  :  in std_logic;
		
		o_y0  : out std_logic;
		o_y1  : out std_logic
	);
end entity decoder1_x_2;
architecture Behavioral of decoder1_x_2 is -- Esse é o decodificador 1 para 2 usado para selecionar qual das memórias vai estar ativa
begin
	process(i_a)
	begin
		case i_a is
			when '0' =>
				o_y0 <= '1';
				o_y1 <= '0';
			when '1' =>
				o_y0 <= '0';
				o_y1 <= '1';
			when others =>
				o_y0 <= '0';
				o_y1 <= '0';
			end case;
	end process;
end architecture Behavioral; -- ele tem duas saídas ativas 
		