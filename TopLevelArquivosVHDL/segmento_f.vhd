library ieee;
use ieee.std_logic_1164.all;

entity segmento_f is 

port(
    i_a, i_b, i_c, i_d : in std_logic;
	o_saida_F : out std_logic
);

end entity;

architecture COMPORTAMENTAL of segmento_f is

    signal s_entrada : std_logic_vector(3 downto 0);

begin
    s_entrada <= i_a & i_b & i_c & i_d;

    o_saida_F <=   '0' when s_entrada = "0001" else 
						 '0' when s_entrada = "0010" else
						 '0' when s_entrada = "0011" else
						 '0' when s_entrada = "0111" else
						 '0' when s_entrada = "1101"  
                   else
					    '1';

end architecture;

architecture COMPORTAMENTAL2 of segmento_f is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

    with s_entrada select o_saida_F <= 
					'0' when "0001" | "0010" | "0011" | "0111" | "1101",
					 '1' when others;

end architecture;

/*
architecture ESTRUTURAL of segmento_f is

begin
    o_saida_F <= (i_a or i_b or not(i_c) or i_d) and (not(i_a) or not(i_b) or i_d) and (not(i_a) or not(i_b) or i_c) and (not(i_a) or i_c or i_d);

end architecture;
*/