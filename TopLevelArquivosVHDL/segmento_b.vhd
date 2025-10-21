library ieee;
use ieee.std_logic_1164.all;

entity segmento_b is
port(
	i_a, i_b, i_c, i_d : in std_logic;
	o_saida_A : out std_logic

);
end entity;


architecture COMPORTAMENTAL of segmento_b is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

--este arquivo apresenta a declaração COMPORTAMENTAL do circuito responsável por gerar o sinal do SEGMENTO A do display.

	o_saida_A <= '0' when s_entrada = "0101" else 
					 '0' when s_entrada = "0110" else
					 '0' when s_entrada = "1011" else
					 '0' when s_entrada = "1100" else
					 '0' when s_entrada = "1110" else
					 '0' when s_entrada = "1111" else
					 '1';

end architecture;


architecture COMPORTAMENTAL2 of segmento_b is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

--este arquivo apresenta a declaração COMPORTAMENTAL do circuito responsável por gerar o sinal do SEGMENTO A do display.

	with s_entrada select o_saida_A <= 
					'0' when "0101" | "0110" | "1011" | "1100" | "1110" | "1111",
					 '1' when others;

end architecture;


architecture ESTRUTURAL of segmento_b is

begin


--este arquivo apresenta a declaração ESTRUTURAL do circuito responsável por gerar o sinal do SEGMENTO A do display.

	o_saida_A <= (not(i_b) and (not(i_a) or not(i_d))) or (i_a and not(i_c) and i_d);

end architecture;