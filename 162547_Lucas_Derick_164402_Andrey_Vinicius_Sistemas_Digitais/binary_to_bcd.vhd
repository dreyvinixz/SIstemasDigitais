library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity binary_to_bcd is
  Port (
    i_binary : in  std_logic_vector(7 downto 0);                     -- é o valor binário de entrada (8 bits)
    o_bcd    : out std_logic_vector(11 downto 0)                     -- é o valor BCD de saída (12 bits)
  );
end binary_to_bcd;

architecture Behavioral of binary_to_bcd is
begin
  process(i_binary)                                                  -- Converte um valor binário de 8 bits para BCD de 12 bits
    variable bin : unsigned(7 downto 0);
    variable bcd : unsigned(11 downto 0);
  begin
    bin := unsigned(i_binary);                                       -- Converte a entrada para unsigned
    bcd := (others => '0');

    for i in 0 to 7 loop                                             -- Loop através de cada bit do valor binário
      if bcd(11 downto 8) > to_unsigned(4,4) then
        bcd(11 downto 8) := bcd(11 downto 8) + to_unsigned(3,4);     -- Ajusta cada dígito BCD se maior que 4(Processo que converte binário para BCD)
      end if;
      if bcd(7 downto 4) > to_unsigned(4,4) then
        bcd(7 downto 4) := bcd(7 downto 4) + to_unsigned(3,4);       -- Ajusta cada dígito BCD se maior que 4(Processo que converte binário para BCD)
      end if;
      if bcd(3 downto 0) > to_unsigned(4,4) then
        bcd(3 downto 0) := bcd(3 downto 0) + to_unsigned(3,4);       -- Ajusta cada dígito BCD se maior que 4(Processo que converte binário para BCD)
      end if;

      bcd := bcd(10 downto 0) & bin(7);                              -- Desloca o BCD para a esquerda e adiciona o próximo bit do binário
      bin := bin(6 downto 0) & '0';                                  -- Desloca o binário para a esquerda
    end loop;

    o_bcd <= std_logic_vector(bcd);   -- Atribui o valor BCD convertido à saída
  end process;
end Behavioral;
-- Aqui que fica a lógica do Double Dabble que faz a conversão de Binário para BCD usando a Shiftagem e o ajuste quando o dígito é maior que 4