library ieee;
use ieee.std_logic_1164.all;

entity topo is
    port(
        clk       : in  std_logic;
        rst       : in  std_logic;
        i_display : in  std_logic;
        o_saida   : out std_logic_vector(6 downto 0)
    );
end entity topo;

architecture rtl of topo is
    -- Declarações de components
    component contador
        port(
            clk   : in  std_logic;
            rst   : in  std_logic;
            saida : out std_logic_vector(3 downto 0)
        );
    end component;

    component toplevel
        port(
            i_binario       : in  std_logic_vector(3 downto 0);
            i_display       : in  std_logic;
            o_saida_display : out std_logic_vector(6 downto 0)
        );
    end component;

    -- Binding das instâncias aos alvos (entidade/arquitetura)
    for all : contador use entity work.contador(rtl);
    for all : toplevel use entity work.toplevel(behavior);

    signal s_contador : std_logic_vector(3 downto 0);
begin
    -- Instância do contador
    u_cnt : contador
        port map (
            clk   => clk,
            rst   => rst,
            saida => s_contador
        );

    -- Instância do driver de 7 segmentos
    u_top : toplevel
        port map (
            i_binario       => s_contador,
            i_display       => i_display,
            o_saida_display => o_saida
        );
end architecture rtl;
