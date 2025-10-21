library ieee;
use ieee.std_logic_1164.all;

entity toplevel is
port(
	i_binario : in std_logic_vector(3 downto 0);
	i_display : in std_logic;
	o_saida_display : out std_logic_vector(6 downto 0)

);
end entity;

architecture behavior of toplevel is

	signal S_SAIDA, s_display : std_logic_vector(6 DOWNTO 0);
	signal S_SAIDA_XOR : std_logic_vector(6 DOWNTO 0);
	
begin

o_saida_display <= s_saIDA_XOR;

s_display <= i_display & i_display & i_display & i_display & i_display & i_display & i_display;

 s_saida_XOR <= s_saida xor s_display;


--como o projeto possui 3 architeturas, eu posso instanciar escolhendo qual delas, por default, se não especificar, ele instancia com a última



--SEGMENTO A
	ua : work.segmento_a(estrutural) port map (i_binario(3), i_binario(2), i_binario(1), i_binario(0), s_saida(6));    -- instancia com a estrutural
	--u1 : work.segmento_a(comportamental) port map (i_a, i_b, i_c, i_d, o_saida_A);    -- instancia com a comportamental
	
	--u2 : work.segmento_a(comportamental2) port map (i_a, i_b, i_c, i_d, o_saida_A);    -- instancia com a comportamental2
	
	--u3 : work.segmento_a port map (i_a, i_b, i_c, i_d, o_saida_A);   -- instancia com a estrutural

--SEGMENTO B
ub : work.segmento_b port map (i_binario(3), i_binario(2), i_binario(1), i_binario(0), s_saida(5));    -- instancia com a estrutural


--SEGMENTO C
uc : work.segmento_c port map (i_binario(3), i_binario(2), i_binario(1), i_binario(0), s_saida(4));    -- instancia com a estrutural


--SEGMENTO D
ud : work.segmento_d port map (i_binario(3), i_binario(2), i_binario(1), i_binario(0), s_saida(3));    -- instancia com a estrutural

--SEGMENTO E

ue : work.segmento_e port map (i_binario(3), i_binario(2), i_binario(1), i_binario(0), s_saida(2));

--SEGMENTO F

  uf : work.segmento_f port map(
  i_binario(3), 
  i_binario(2), 
  i_binario(1), 
  i_binario(0), 
  s_saida(1)
  );

--SEGMENTO G
ug : work.segmento_g port map (i_binario(3), i_binario(2), i_binario(1), i_binario(0), s_saida(0));



end architecture;