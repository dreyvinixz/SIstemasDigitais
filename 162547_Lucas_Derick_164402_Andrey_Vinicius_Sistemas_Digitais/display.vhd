library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity display is
    Port (
        i_clk       : in  std_logic;                        -- clock de entrada
        i_reset     : in  std_logic;                        -- sinal de reset                 
        i_unit      : in  std_logic_vector(3 downto 0);     -- é o valor BCD da unidade (4 bits)
        i_deci      : in  std_logic_vector(3 downto 0);     -- é o valor BCD da dezena (4 bits)
        i_cent      : in  std_logic_vector(3 downto 0);     -- é o valor BCD da centena (4 bits)
        o_segments  : out std_logic_vector(6 downto 0);     -- são os 7 segmentos do display
        o_anodes    : out std_logic_vector(3 downto 0)      -- são os anodos do display (4 bits) Energia os  dígitos individualmente
    );                                                      -- são usados 4 bits por causa do display de 4 dígitos, mas só 3 são usados
end display;

architecture Behavioral of display is                                   -- Contador para multiplexação dos 3 dígitos
                   
    signal refresh_counter : unsigned(19 downto 0) := (others => '0');  -- Contador de 20 bits
    signal digit_select    : unsigned(1 downto 0);

    
    signal seg_unit, seg_deci, seg_cent : std_logic_vector(6 downto 0); -- Segmentos para cada dígito
    

    signal mux_sel : std_logic_vector(1 downto 0);                      -- Seleção do multiplexador          

    component bcd_to_7seg
        Port (
            i_bcd      : in  std_logic_vector(3 downto 0);              
            o_segments : out std_logic_vector(6 downto 0)               
        );
    end component;

begin

    decoder_unit: bcd_to_7seg port map (i_bcd => i_unit,
                                        o_segments => seg_unit);    -- Segmentos do dígito de unidades
    decoder_deci: bcd_to_7seg port map (i_bcd => i_deci,
                                        o_segments => seg_deci);   -- Segmentos do dígito de dezenas
    decoder_cent: bcd_to_7seg port map (i_bcd => i_cent,
                                        o_segments => seg_cent);   -- Segmentos do dígito de centenas

                            
    process(i_clk, i_reset)                                        -- Contador para multiplexação dos dígitos
    begin
        if i_reset = '1' then
            refresh_counter <= (others => '0');
        elsif rising_edge(i_clk) then                              -- Incrementa o contador a cada ciclo de clock
            refresh_counter <= refresh_counter + 1;
        end if;
    end process;


    digit_select <= refresh_counter(19 downto 18);              -- Usa os dois bits mais significativos para selecionar o dígito atual          
    mux_sel <= std_logic_vector(digit_select);                  -- Converte para std_logic_vector para uso no processo de multiplexação  

                                                                -- Multiplexar: selecionar segmentos e anodo baseado em digit_select
    process(mux_sel, seg_unit, seg_deci, seg_cent)
    begin
        case mux_sel is
                                                                -- Mostrar unidades (primeiro dígito da direita)
            when "00" =>
                o_segments <= seg_unit;                         -- Segmentos do dígito de unidades
                o_anodes   <= "1110";                           -- Ativar apenas o primeiro anodo (rightmost)

                                                                -- Mostrar dezenas (segundo dígito)
            when "01" =>
                o_segments <= seg_deci;                         -- Segmentos do dígito de dezenas
                o_anodes   <= "1101";                           -- Ativar apenas o segundo anodo

                                                                -- Mostrar centenas (terceiro dígito da esquerda)
            when "10" =>
                o_segments <= seg_cent;                         -- Segmentos do dígito de centenas
                o_anodes   <= "1011";                           -- Ativar apenas o terceiro anodo

                                                                -- Estado padrão (nunca deveria chegar aqui)
            when others =>
                o_segments <= "1111111";                        -- Todos os segmentos apagados
                o_anodes   <= "1111";                           -- Todos os anodos desativados

        end case;
    end process;

end Behavioral;
