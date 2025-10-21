library ieee;
use ieee.std_logic_1164.all;

entity latch_d is
    port(
        i_d     : in  std_logic;
        i_en    : in  std_logic;   -- enable
        o_q     : out std_logic;
        o_qn    : out std_logic
    );
end entity latch_d;

architecture estrutural of latch_d is
    signal s_q, s_qn : std_logic;
begin
    process(i_d, i_en, s_q, s_qn)
    begin
        if i_en = '1' then
            s_q  <= i_d;
            s_qn <= not i_d;
        end if;
    end process;

    o_q  <= s_q;
    o_qn <= s_qn;
end architecture estrutural;
