library ieee;
use ieee.std_logic_1164.all;

entity and_gate2 is
	port (
		i_A : in  std_logic;
		i_B : in  std_logic;
		
		o_C : out std_logic
	);
end entity and_gate2;

architecture dataflow of and_gate2 is
begin 
	o_C <= i_A and i_B;
end architecture dataflow; -- Esse and é totalmente Inútil (Mais para falar sobre os possíveis questionamentos que pode ter
						   -- os Botões são Active to Low e por isso é invertido (reset e Write)
						   -- E o 0 no reset foi o pulo do Gato para não bugar no display pois isso zera o display em 0