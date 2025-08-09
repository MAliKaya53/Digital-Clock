
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity digital_clock is
    Port ( clk    : in STD_LOGIC;
           en     : in STD_LOGIC;
           rst    : in STD_LOGIC;
           hr_up  : in STD_LOGIC;
           min_up : in STD_LOGIC;
           s1     : out STD_LOGIC_VECTOR (3 downto 0);
           s2     : out STD_LOGIC_VECTOR (3 downto 0);
           m1     : out STD_LOGIC_VECTOR (3 downto 0);
           m2     : out STD_LOGIC_VECTOR (3 downto 0);
           h1     : out STD_LOGIC_VECTOR (3 downto 0);
           h2     : out STD_LOGIC_VECTOR (3 downto 0));
end digital_clock;

architecture Behavioral of digital_clock is


component binarytoBCD is
  Port ( 
        binary : in  std_logic_vector(11 downto 0);
        thos   : out std_logic_vector(3 downto 0);
        huns   : out std_logic_vector(3 downto 0);
        tens   : out std_logic_vector(3 downto 0);
        ones   : out std_logic_vector(3 downto 0)
  );
end component;

-- onesec value depends on fpga clock frequency
constant ONESEC         : integer := 10; --100000000; -- 1 sec
signal   clk_c          : integer := 0;
-- hour, min and sec values as 6-bit -> 2^6-1 = 63, 60 -> second and minute max
signal   hour, min, sec : integer := 0;
begin

process (clk) begin 
    if (rising_edge(clk)) then
        if rst = '1' then 
            hour  <= 0;
            min   <= 0;
            sec   <= 0;
            clk_c <= 0;
        elsif min_up = '1' then    -- depends on min buton
            if (min = 59) then
                min <= 0;
            else
                min <= min + 1;
            end if;
        elsif hr_up = '1' then     -- depends on hour buton
            if (hour  = 23) then
                hour <= 0;
            else
                hour <= hour + 1;
            end if;
        elsif en = '1' then
            if clk_c = ONESEC then -- if clk_c equal to clock clock frequency
                clk_c <= 0;
                if(sec = 59) then
                    sec <= 0;
                    if(min = 59) then
                        min <= 0;
                        if(hour = 23) then
                            hour <= 0;
                        else
                            hour <= hour + 1;
                        end if;
                    else
                        min <= min + 1;
                    end if;
                else
                    sec <= sec + 1;
                end if;
            else
                clk_c <= clk_c + 1;
            end if;  
        end if;
   end if;
end process;
    
-- 12-bit binary input converts to decimal output
SANIYE: binarytoBCD PORT MAP (binary => std_logic_vector(to_unsigned(sec, 12)),  tens => s2, ones => s1);
DK    : binarytoBCD PORT MAP (binary => std_logic_vector(to_unsigned(min, 12)),  tens => m2, ones => m1);
SAAT  : binarytoBCD PORT MAP (binary => std_logic_vector(to_unsigned(hour, 12)), tens => h2, ones => h1);

end Behavioral;
