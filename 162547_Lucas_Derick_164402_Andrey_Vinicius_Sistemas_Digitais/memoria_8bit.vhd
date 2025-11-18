library ieee;
use ieee.std_logic_1164.all;

entity memoria_8bit is                                                         -- Memória de 8 bits usada no projeto                
  port (
    i_clk   : in std_logic;
    i_rst   : in std_logic;
    i_wrt   : in std_logic;
    i_sel_x : in std_logic; 
    i_sel_y : in std_logic; 
    i_Datas : in std_logic_vector(7 downto 0);
    o_Quit  : out std_logic_vector(7 downto 0)
  );
end entity;

architecture behavioral of memoria_8bit is                                  -- Arquitetura comportamental da memória de 8 bits usada no projeto
  component dff8_nsync is
    port (
      i_d     : in  std_logic_vector(7 downto 0);
      i_clk   : in  std_logic;
      i_reset : in  std_logic;
      i_sel_x : in  std_logic;
      i_sel_y : in  std_logic;
      i_wrt   : in  std_logic;
      o_q     : out std_logic_vector(7 downto 0)
    );
  end component;

  signal i_rst_int, i_wrt_int : std_logic;
  signal q_word : std_logic_vector(7 downto 0);                                -- sinal interno para armazenar os dados da memória
begin

  i_rst_int <= not i_rst;                                                      -- Inversão do sinal de reset para o flip-flop (ativo baixo) Botão de reset ativo alto
  i_wrt_int <=  i_wrt;                                                         -- Passa o sinal de escrita diretamente


  u_cell: dff8_nsync port map(
    i_d     => i_Datas,
    i_clk   => i_clk,
    i_reset => i_rst_int,
    i_sel_x => i_sel_x,
    i_sel_y => i_sel_y,
    i_wrt   => i_wrt_int,
    o_q     => q_word
  );

  o_Quit <= q_word when (i_sel_x='1' and i_sel_y='1') else (others => '0');   -- saída só é válida quando célula selecionada  
  
end architecture;
-- Fiz isso por causa que se eu usasse só aquela boneca russa de flip flops iria ficar muito dificil de entender e compilaria errado
-- Então decidi fazer uma arquitetura comportamental para facilitar a compreensão e evitar erros de compilação