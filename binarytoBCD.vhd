----------------------------------------------------------------------------------
-- Project Name: BINARY TO BINARY CODED DECIMAL
-- Description: FOR EXAMPLE 0000 1111 1111 INPUT WE DONT SEE IN 7-SEGMENT
-- SO WE NEED TO CONVERT IT DECIMAL 0255 -> 0, 2, 5, 5
-- 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity binarytoBCD is
  Port ( 
        binary : in  std_logic_vector(11 downto 0);
        thos   : out std_logic_vector(3 downto 0);
        huns   : out std_logic_vector(3 downto 0);
        tens   : out std_logic_vector(3 downto 0);
        ones   : out std_logic_vector(3 downto 0)
  );
end binarytoBCD;

architecture Behavioral of binarytoBCD is

begin


process (binary) 
    variable bcd_data  : unsigned (11 downto 0);
    variable thos_data : unsigned (11 downto 0);
    variable huns_data : unsigned (11 downto 0);
    variable tens_data : unsigned (11 downto 0);
    variable ones_data : unsigned (11 downto 0);
begin
    bcd_data := unsigned(binary);
    thos_data:= bcd_data  / 1000;
    bcd_data := bcd_data mod 1000;
    huns_data:= bcd_data  / 100;
    bcd_data := bcd_data mod 100;
    tens_data:= bcd_data  / 10;
    bcd_data := bcd_data mod 10;
    ones_data:= bcd_data;
    
    thos <= std_logic_vector(thos_data(3 downto 0));
    huns <= std_logic_vector(huns_data(3 downto 0));
    tens <= std_logic_vector(tens_data(3 downto 0));
    ones <= std_logic_vector(ones_data(3 downto 0));

end process;

end Behavioral;
