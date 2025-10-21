library ieee;
use ieee.std_logic_1164.all;

entity segmento_c is
port(
	i_a, i_b, i_c, i_d : in std_logic;
	o_saida_C : out std_logic

);
end entity;


architecture COMPORTAMENTAL of segmento_c is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

--este arquivo apresenta a declaração COMPORTAMENTAL do circuito responsável por gerar o sinal do SEGMENTO A do display.

	o_saida_C <= '0' when s_entrada = "0010" else 
					 '0' when s_entrada = "1111" else
					 '0' when s_entrada = "1110" else
					 '0' when s_entrada = "1100" else
					 '1';

end architecture;


architecture COMPORTAMENTAL2 of segmento_c is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

--este arquivo apresenta a declaração COMPORTAMENTAL do circuito responsável por gerar o sinal do SEGMENTO A do display.

	with s_entrada select o_saida_C <= 
					'0' when "0010" | "1100" | "1110" | "1111",
					'1' when others;

end architecture;


architecture ESTRUTURAL of segmento_c is

begin


--este arquivo apresenta a declaração ESTRUTURAL do circuito responsável por gerar o sinal do SEGMENTO C do display.

   o_saida_C <= (i_a or i_b or not(i_c) or i_d) and (not(i_a) or not(i_b) or i_c or i_d) and (not(i_a) or not(i_b) or not(i_c) or i_d) and (not(i_a) or not(i_b) or not(i_c) or not(i_d));
end architecture;