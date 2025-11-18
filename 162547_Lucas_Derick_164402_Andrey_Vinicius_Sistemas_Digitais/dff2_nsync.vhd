library ieee;
use ieee.std_logic_1164.all;

entity dff2_nsync is							 		--	 Esse é o flip flop D assíncrono de 2 bits usado para armazenar os bits nas memórias
port (													-- Instancia dois flip flops D assíncronos de 1 bit
	i_d      :  in std_logic_vector(1 downto 0);
	i_clk    :  in std_logic;
	i_reset  :  in std_logic;
	i_sel_x  :  in std_logic;
	i_sel_y  :  in std_logic;
	i_wrt    :  in  std_logic;
	
	o_q      : out std_logic_vector(1 downto 0)
);
end entity dff2_nsync;

architecture structural of dff2_nsync is
	component dff_nsync is
		port(
			i_d     : in  std_logic;
			i_clk   : in  std_logic;
			i_reset : in  std_logic;
			i_sel_x : in std_logic;
			i_sel_y : in std_logic;
			i_wrt   : in std_logic;
			
			o_q     : out std_logic
		);
		end component;
		begin
		u_ff0:dff_nsync port map (i_d     => i_d(0),
										  i_clk   => i_clk,
										  i_reset => i_reset,
										  i_sel_x => i_sel_x,
										  i_sel_y => i_sel_y,
										  i_wrt   => i_wrt,
										  o_q     => o_q(0)
										  );
		u_ff1:dff_nsync port map (i_d     => i_d(1),
										  i_clk   => i_clk,
										  i_reset => i_reset,
										  i_sel_x => i_sel_x,
										  i_sel_y => i_sel_y,
										  i_wrt   => i_wrt,
										  o_q     => o_q(1)
										  );
end architecture;