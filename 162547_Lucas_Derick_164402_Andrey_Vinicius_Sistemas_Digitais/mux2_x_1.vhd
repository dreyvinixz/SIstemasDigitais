library ieee;
use ieee.std_logic_1164.all;

entity mux2_x_1 is 													-- Multiplexador 2 para 1 usado para selecionar entre duas entradas com base no sinal de seleção
	port(
		i_a  :  in std_logic;
		i_b  :  in std_logic;
		i_s  :  in std_logic;
		
		o_y  : out std_logic
	);
end mux2_x_1;

architecture Behavioral of mux2_x_1 is
	begin
		process(i_a,i_b,i_s)
	begin
			case i_s is
				when '0' =>
						o_y<= i_a;
						
				when '1' =>
						o_y<= i_b;
						
				when others =>
						o_y<= 'X';
			end case;
		end process;
end architecture	Behavioral;
					
					