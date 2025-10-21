
library ieee;
use ieee.std_logic_1164.all;

entity segmento_e is
port(
	i_a, i_b, i_c, i_d : in std_logic;
	o_saida_E : out std_logic

);
end entity;


architecture COMPORTAMENTAL of segmento_e is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

--este arquivo apresenta a declaração COMPORTAMENTAL do circuito responsável por gerar o sinal do SEGMENTO E do display.

	o_saida_E <= '0' when s_entrada = "0001" else 
					 '0' when s_entrada = "0011" else
					 '0' when s_entrada = "0100" else
					 '0' when s_entrada = "0101" else
					 '0' when s_entrada = "0111" else
					 '0' when s_entrada = "1001" else
					 '1';

end architecture;


architecture COMPORTAMENTAL2 of segmento_e is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

--este arquivo apresenta a declaração COMPORTAMENTAL do circuito responsável por gerar o sinal do SEGMENTO E do display.

	with s_entrada select o_saida_E <= 
					'0' when "0001" | "0011" | "0100" | "0101" | "0111" | "1001",
					 '1' when others;

end architecture;


architecture ESTRUTURAL of segmento_e is

begin


--este arquivo apresenta a declaração ESTRUTURAL do circuito responsável por gerar o sinal do SEGMENTO E do display.

	o_saida_E <= (not(i_d) and not(i_b)) or ((i_c) and not(i_d)) or (i_a and i_b) or (i_c and i_a);

end architecture;