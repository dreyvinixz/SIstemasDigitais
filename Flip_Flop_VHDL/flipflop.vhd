library ieee;
use ieee.std_logic_1164.all;

entity flipflop is
    port(
        i_d     : in  std_logic;
        i_clk   : in  std_logic;
        i_reset : in  std_logic;
        o_q     : out std_logic;
        o_qn    : out std_logic
    );
end entity flipflop;

architecture estrutural of flipflop is
    -- Declaração do componente latch_d
    component latch_d
        port(
            i_d   : in  std_logic;
            i_en  : in  std_logic;
            o_q   : out std_logic;
            o_qn  : out std_logic
        );
    end component;

    -- Sinais internos
    signal s_m_q, s_m_qn : std_logic;  -- mestre
    signal s_q, s_qn     : std_logic;  -- escravo
begin
    -- Latch mestre: ativo em CLK='0'
    mestre: latch_d
        port map(
            i_d  => i_d,
            i_en => not i_clk,
            o_q  => s_m_q,
            o_qn => s_m_qn
        );

    -- Latch escravo: ativo em CLK='1'
    escravo: latch_d
        port map(
            i_d  => s_m_q,
            i_en => i_clk,
            o_q  => s_q,
            o_qn => s_qn
        );

    -- Reset assíncrono: controla as saídas finais
    process(i_reset, s_q, s_qn)
    begin
        if i_reset = '1' then
            o_q  <= '0';
            o_qn <= '1';
        else
            o_q  <= s_q;
            o_qn <= s_qn;
        end if;
    end process;

end architecture estrutural;
