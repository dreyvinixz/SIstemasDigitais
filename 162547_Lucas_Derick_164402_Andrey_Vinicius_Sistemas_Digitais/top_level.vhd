library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity top_level is                                                  -- Top level do projeto que integra memória, conversor binário para BCD e display 7 segmentos
    Port (
        i_clk      : in  std_logic;
        i_reset    : in  std_logic;
        i_wrt      : in  std_logic;
        i_sel_x    : in  std_logic;
        i_sel_y    : in  std_logic;
        i_Datas    : in  std_logic_vector(7 downto 0);
        o_segments : out std_logic_vector(6 downto 0);
        o_anodes   : out std_logic_vector(3 downto 0)
    );
end top_level;

architecture Behavioral of top_level is                                              -- Arquitetura comportamental do top level que integra memória, conversor binário para BCD e display 7 segmentos
    signal memoria_saida  : std_logic_vector(7 downto 0);                            -- sinal de saída da memória
    signal bcd_completo   : std_logic_vector(11 downto 0);                           -- sinal BCD completo (centenas, dezenas, unidades)
    signal bcd_centenas   : std_logic_vector(3 downto 0);                            -- sinais BCD individuais
    signal bcd_dezenas    : std_logic_vector(3 downto 0);                            -- sinais BCD individuais
    signal bcd_unidades   : std_logic_vector(3 downto 0);                            -- sinais BCD individuais
    signal wrt_inverted   : std_logic;
    signal reset_inverted : std_logic;

    component memoria_2x2
        Port (
            i_clk    : in  std_logic;
            i_rst    : in  std_logic;
            i_wrt    : in  std_logic;
            i_sel_x  : in  std_logic;
            i_sel_y  : in  std_logic;
            i_Datas  : in  std_logic_vector(7 downto 0);
            o_Q      : out std_logic_vector(7 downto 0)
        );
    end component;

    component binary_to_bcd
        Port (
            i_binary : in  std_logic_vector(7 downto 0);
            o_bcd    : out std_logic_vector(11 downto 0)
        );
    end component;

    component display
        Port (
            i_clk      : in  std_logic;
            i_reset    : in  std_logic;
            i_unit     : in  std_logic_vector(3 downto 0);
            i_deci     : in  std_logic_vector(3 downto 0);
            i_cent     : in  std_logic_vector(3 downto 0);
            o_segments : out std_logic_vector(6 downto 0);
            o_anodes   : out std_logic_vector(3 downto 0)
        );
    end component;

begin
    wrt_inverted   <= not i_wrt;                                        -- Inversão do sinal de escrita (ativo baixo)               
    reset_inverted <= not i_reset;                                      -- Inversão do sinal de reset (ativo baixo)
    
    mem: memoria_2x2 port map (
        i_clk    => i_clk,
        i_rst    => reset_inverted,
        i_wrt    => wrt_inverted,    
        i_sel_x  => i_sel_x,
        i_sel_y  => i_sel_y,
        i_Datas  => i_Datas,
        o_Q      => memoria_saida
    );

    conversor: binary_to_bcd port map (
        i_binary => memoria_saida,
        o_bcd    => bcd_completo
    );

    bcd_centenas <= bcd_completo(11 downto 8);
    bcd_dezenas  <= bcd_completo(7 downto 4);
    bcd_unidades <= bcd_completo(3 downto 0);

    display_ctrl: display port map (
        i_clk      => i_clk,
        i_reset    => '0',                                            -- Reset desativado para o display
        i_unit     => bcd_unidades,
        i_deci     => bcd_dezenas,
        i_cent     => bcd_centenas,
        o_segments => o_segments,
        o_anodes   => o_anodes
    );

end Behavioral;
