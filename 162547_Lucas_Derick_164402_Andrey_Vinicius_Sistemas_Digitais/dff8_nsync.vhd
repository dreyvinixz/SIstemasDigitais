library ieee;
use ieee.std_logic_1164.all;

entity dff8_nsync is                             		-- Esse é o flip flop D assíncrono de 8 bits usado para armazenar os bits nas memórias
port (                                                  -- Ele instancia quatro flip flops D assíncronos de 2 bits
    i_d      :  in std_logic_vector(7 downto 0);        -- Literalmente Uma boneca russa de flip flops kkkkk
    i_clk    :  in std_logic;
    i_reset  :  in std_logic;
    i_sel_x  :  in std_logic;
    i_sel_y  :  in std_logic;
    i_wrt    :  in  std_logic;
    
    o_q      : out std_logic_vector(7 downto 0) 
);
end entity dff8_nsync;

architecture structural of dff8_nsync is
    component dff2_nsync is 
    port (
        i_d 		:  in std_logic_vector(1 downto 0);
        i_clk 	:  in std_logic;
        i_reset  :  in std_logic;
        i_sel_x  :  in std_logic;
        i_sel_y  :  in std_logic;
        i_wrt    :  in std_logic;
        o_q      : out std_logic_vector(1 downto 0)
        );
    end component;
begin


    u_ff_1_0: dff2_nsync port map (
        i_d     => i_d(1 downto 0),
        i_clk   => i_clk,
        i_reset => i_reset,
        i_sel_x => i_sel_x,
        i_sel_y => i_sel_y,
        i_wrt   => i_wrt,
        o_q     => o_q(1 downto 0)
    );

    u_ff_3_2: dff2_nsync port map (
        i_d     => i_d(3 downto 2),
        i_clk   => i_clk,
        i_reset => i_reset,
        i_sel_x => i_sel_x,
        i_sel_y => i_sel_y,
        i_wrt   => i_wrt,
        o_q     => o_q(3 downto 2)
    );
    
    u_ff_5_4: dff2_nsync port map (
        i_d     => i_d(5 downto 4),
        i_clk   => i_clk,
        i_reset => i_reset,
        i_sel_x => i_sel_x,
        i_sel_y => i_sel_y,
        i_wrt   => i_wrt,
        o_q     => o_q(5 downto 4)
    );

    u_ff_7_6: dff2_nsync port map (
        i_d     => i_d(7 downto 6),
        i_clk   => i_clk,
        i_reset => i_reset,
        i_sel_x => i_sel_x,
        i_sel_y => i_sel_y,
        i_wrt   => i_wrt,
        o_q     => o_q(7 downto 6)
    );
    
end architecture;