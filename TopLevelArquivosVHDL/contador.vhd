library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
    port(
        clk   : in  std_logic;
        rst   : in  std_logic;
        saida : out std_logic_vector(3 downto 0)
    );
end entity contador;

architecture rtl of contador is
    signal count : integer range 0 to 15 := 0;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            count <= 0;
        elsif rising_edge(clk) then
            if count = 15 then
                count <= 0;
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    -- Converte o contador inteiro para std_logic_vector
    saida <= std_logic_vector(to_unsigned(count, saida'length));
end architecture rtl;
