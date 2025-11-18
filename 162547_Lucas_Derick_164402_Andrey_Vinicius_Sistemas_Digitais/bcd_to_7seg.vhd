library IEEE;
use IEEE.std_logic_1164.all;

entity bcd_to_7seg is
    Port (
        i_bcd       : in  std_logic_vector(3 downto 0);
        o_segments  : out std_logic_vector(6 downto 0)  -- a b c d e f g
    );
end bcd_to_7seg;

architecture Behavioral of bcd_to_7seg is
begin
    process(i_bcd)
    begin
         case i_bcd is
            when "0000" => o_segments <= "0000001"; 
            when "0001" => o_segments <= "1001111"; 
            when "0010" => o_segments <= "0010010"; 
            when "0011" => o_segments <= "0000110"; 
            when "0100" => o_segments <= "1001100"; 
            when "0101" => o_segments <= "0100100"; 
            when "0110" => o_segments <= "0100000"; 
            when "0111" => o_segments <= "0001111"; 
            when "1000" => o_segments <= "0000000"; 
            when "1001" => o_segments <= "0000100"; 
            when others => o_segments <= "1111111"; 
        end case;
    end process;
end Behavioral;
