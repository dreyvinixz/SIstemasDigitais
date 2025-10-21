library ieee;
use ieee.std_logic_1164.all;
-- Matheus Nunes, Luis Henrique Reichow, Gustavo Gimenes, Theo, Othavio
entity segmento_d is
port(
	i_a, i_b, i_c, i_d : in std_logic;
	o_saida_D : out std_logic

);
end entity;


architecture COMPORTAMENTAL of segmento_d is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

--este arquivo apresenta a declaração COMPORTAMENTAL do circuito responsável por gerar o sinal do SEGMENTO D do display.

	o_saida_D <= '0' when s_entrada = "0001" else 
					 '0' when s_entrada = "0100" else
					 '0' when s_entrada = "0111" else
					 '0' when s_entrada = "1010" else
					 '0' when s_entrada = "1111" else
					 '1';

end architecture;


architecture COMPORTAMENTAL2 of segmento_d is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

--este arquivo apresenta a declaração COMPORTAMENTAL do circuito responsável por gerar o sinal do SEGMENTO D do display.

	with s_entrada select o_saida_D <= 
					'0' when "0001" | "0100" | "0111" | "1010" | "1111",
					 '1' when others;

end architecture;


architecture ESTRUTURAL of segmento_d is

begin


--este arquivo apresenta a declaração ESTRUTURAL do circuito responsável por gerar o sinal do SEGMENTO D do display.

	o_saida_D <= (i_a and not(i_c)) or (not(i_a) and not(i_b) and not(i_d)) or (i_b and not(i_c) and i_d) or (not(i_b) and i_c and i_d) or (i_b and i_c and not(i_d));

end architecture;