library ieee;
use ieee.std_logic_1164.all;

--Responsável técnico: Rafael Schvittz

entity segmento_a is
port(
	i_a, i_b, i_c, i_d : in std_logic;
	o_saida_A : out std_logic

);
end entity;


architecture COMPORTAMENTAL of segmento_a is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

--este arquivo apresenta a declaração COMPORTAMENTAL do circuito responsável por gerar o sinal do SEGMENTO A do display.

	o_saida_A <= '0' when s_entrada = "0001" else 
					 '0' when s_entrada = "0100" else
					 '0' when s_entrada = "1011" else
					 '0' when s_entrada = "1101" else
					 '1';

end architecture;


architecture COMPORTAMENTAL2 of segmento_a is

	signal s_entrada : std_logic_vector(3 downto 0);

begin

s_entrada <= i_a & i_b & i_c & i_d;

--este arquivo apresenta a declaração COMPORTAMENTAL do circuito responsável por gerar o sinal do SEGMENTO A do display.

	with s_entrada select o_saida_A <= 
					'0' when "0001" | "0100" | "1011" | "1101",
					 '1' when others;

end architecture;


architecture ESTRUTURAL of segmento_a is

begin


--este arquivo apresenta a declaração ESTRUTURAL do circuito responsável por gerar o sinal do SEGMENTO A do display.

	o_saida_A <= 
		(not(i_b) and not(i_d)) or 
		(not(i_a) and i_c) or 
		(not(i_a) and i_b and i_d) or 
		(i_b and i_c) or 
		(i_a and not(i_b) and not(i_c)) or 
		(i_a and not(i_d));

end architecture;

architecture compotamental3 of segmento_a is

	signal s_entrada : std_logic_vector(3 downto 0);
	signal o_saida : std_logic;
	
begin

	s_entrada <= i_a & i_b & i_c & i_d;

	process(s_entrada)
	begin
		o_saida_A <= '0';  -- condicao generica;
		if(s_entrada = "0000") then
			o_saida_A <= '1';
		elsif (s_entrada = "0001") then
			o_saida_A <= '0';
		elsif (s_entrada = "0010") then
			o_saida_A <= '1';
		elsif (s_entrada = "0011") then
			o_saida_A <= '1';
		elsif (s_entrada = "0100") then
			o_saida_A <= '0';
		elsif (s_entrada = "0101") then
			o_saida_A <= '1';
		elsif (s_entrada = "0110") then
			o_saida_A <= '1';
		elsif (s_entrada = "0111") then
			o_saida_A <= '1';
		elsif (s_entrada = "1000") then
			o_saida_A <= '1';
		elsif (s_entrada = "1001") then
			o_saida_A <= '1';
		elsif (s_entrada = "1010") then
			o_saida_A <= '1';
		elsif (s_entrada = "1011") then
			o_saida_A <= '0';
		elsif (s_entrada = "1100") then
			o_saida_A <= '1';
		elsif (s_entrada = "1101") then
			o_saida_A <= '0';
		elsif (s_entrada = "1110") then
			o_saida_A <= '1';
		elsif (s_entrada = "1111") then
			o_saida_A <= '1';
		end if;
	
	end process;
	
	
	
	s_entrada <= i_a & i_b;
	
	s_and : process(i_a, i_b)
	begin
		case (s_entrada) is
		when "00" => 
			o_saida <= '0';
		when "01" => 
			o_saida <= '0';
		when "10" => 
			o_saida <= '0';
		when "11" => 
			o_saida <= '1';
		when others => 
			o_saida <= '0';	
		end case;
	end process;
	
	
	
	

end architecture;