library ieee;
use ieee.std_logic_1164.all;

entity memoria_2x2 is                                         -- Essa é a memória 2x2 de 8 bits usada no projeto
  port (
    i_clk   : in std_logic;
    i_rst   : in std_logic;
    i_wrt   : in std_logic;
    i_sel_x : in std_logic;
    i_sel_y : in std_logic;
    i_Datas : in std_logic_vector(7 downto 0);
    o_Q     : out std_logic_vector(7 downto 0)
  );
end entity;

architecture structural of memoria_2x2 is
  component decoder1_x_2 is
    port ( i_a : in std_logic;
           o_y0: out std_logic;
           o_y1: out std_logic );
  end component;

  component memoria_8bit is                                   -- Memória de 8 bits usada no projeto
    port (
      i_clk   : in std_logic;
      i_rst   : in std_logic;
      i_wrt   : in std_logic;
      i_sel_x : in std_logic;
      i_sel_y : in std_logic;
      i_Datas : in std_logic_vector(7 downto 0);
      o_Quit  : out std_logic_vector(7 downto 0)
    );
  end component;

  signal sel_x0, sel_x1, sel_y0, sel_y1 : std_logic;          -- sinais de seleção das memórias
  signal q00, q01, q10, q11 : std_logic_vector(7 downto 0);   -- sinais de saída das memórias
  signal sel : std_logic_vector(1 downto 0);                  -- sinal combinado de seleção      
  signal wrt_00, wrt_01, wrt_10, wrt_11 : std_logic;          -- sinais de escrita combinados
  
begin
  dec_x: decoder1_x_2 port map(i_a => i_sel_x,
                               o_y0 => sel_x0,
                               o_y1 => sel_x1);
  dec_y: decoder1_x_2 port map(i_a => i_sel_y,
                               o_y0 => sel_y0,
                               o_y1 => sel_y1);

  wrt_00 <= i_wrt and sel_x0 and sel_y0;                  -- Sinal de escrita para cada memória
  wrt_01 <= i_wrt and sel_x0 and sel_y1;                  -- Sinal de escrita para cada memória
  wrt_10 <= i_wrt and sel_x1 and sel_y0;                  -- Sinal de escrita para cada memória
  wrt_11 <= i_wrt and sel_x1 and sel_y1;                  -- Sinal de escrita para cada memória

  u00: memoria_8bit port map(i_clk=>i_clk, i_rst=>i_rst, 
                              i_wrt=>wrt_00,  
                              i_sel_x=>sel_x0, i_sel_y=>sel_y0,
                              i_Datas=>i_Datas, o_Quit=>q00);

  u01: memoria_8bit port map(i_clk=>i_clk, i_rst=>i_rst, 
                              i_wrt=>wrt_01,  
                              i_sel_x=>sel_x0, i_sel_y=>sel_y1,
                              i_Datas=>i_Datas, o_Quit=>q01);

  u10: memoria_8bit port map(i_clk=>i_clk, i_rst=>i_rst, 
                              i_wrt=>wrt_10,  
                              i_sel_x=>sel_x1, i_sel_y=>sel_y0,
                              i_Datas=>i_Datas, o_Quit=>q10);

  u11: memoria_8bit port map(i_clk=>i_clk, i_rst=>i_rst, 
                              i_wrt=>wrt_11,  
                              i_sel_x=>sel_x1, i_sel_y=>sel_y1,
                              i_Datas=>i_Datas, o_Quit=>q11);

  sel <= i_sel_x & i_sel_y;
  
  with sel select                             -- Seleciona a saída correta baseada nos sinais de seleção
    o_Q <= q00 when "00",
           q01 when "01",
           q10 when "10",
           q11 when "11",
           (others => '0') when others;

end architecture;
