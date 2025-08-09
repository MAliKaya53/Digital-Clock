----------------------------------------------------------------------------------
-- Engineer: 
-- 
-- 
-- Description: 7-segment output max value is 9
-- 8 is created by max slices (7 slice)
-- Binary Coded Decimal (BCD) to 7-segment display code
-- you can read detaily : https://www.geeksforgeeks.org/digital-logic/bcd-to-7-segment-decoder/
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder_7seg is
    Port ( in1 : in STD_LOGIC_VECTOR (3 downto 0);
           out1 : out STD_LOGIC_VECTOR (6 downto 0));
end decoder_7seg;

architecture Behavioral of decoder_7seg is

begin

process begin
    case in1 is
        when "0000" => out1 <= "1111110";
        when "0001" => out1 <= "0110000";
        when "0010" => out1 <= "1101101";
        when "0011" => out1 <= "1111001";
        when "0100" => out1 <= "0110011";
        when "0101" => out1 <= "1011011";
        when "0110" => out1 <= "1011111";
        when "0111" => out1 <= "1110000";
        when "1000" => out1 <= "1111111";
        when "1001" => out1 <= "1111011";
    end case;
end process;
end Behavioral;
