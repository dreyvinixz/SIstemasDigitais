library ieee;
use ieee.std_logic_1164.all;

entity dff_nsync is							 		-- Esse é o flip flop D assíncrono usado para armazenar os bits nas memórias
port (
	i_d     :  in  std_logic;
	i_clk   :  in  std_logic;
	i_reset :  in  std_logic;
	i_sel_x :  in  std_logic;
	i_sel_y :  in  std_logic;
	i_wrt   :  in  std_logic;
	
	o_q     : out  std_logic
);
end entity dff_nsync;

architecture Behavioral of dff_nsync is
	signal s_q_internal : std_logic; 							-- estado armazenado
	signal read_enable : std_logic; 							-- habilita leitura (w=0 e célula selecionada)
begin

process(i_clk, i_reset)
	begin
		if (i_reset='1') then
			s_q_internal <= '0';
		elsif rising_edge(i_clk) then							-- escrita na borda de subida do clock(IMPORTANTE)
		if (i_wrt='0' and i_sel_x='1' and i_sel_y='1') then
		s_q_internal <= i_d;
		end if;
	end if;
end process;


read_enable <= i_wrt and i_sel_x and i_sel_y;
o_q <= s_q_internal when read_enable='1' else '0';  			-- saída só é válida quando w=1 e célula selecionada
end architecture Behavioral;
