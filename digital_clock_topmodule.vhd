----------------------------------------------------------------------------------
-- Engineer: 
-- 
-- Description: 
-- 
-- 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digital_clock_topmodule is
    Port ( clk  : in  STD_LOGIC;
           sw   : in  STD_LOGIC;
           btnC : in  STD_LOGIC; -- Reset butonu
           btnR : in  STD_LOGIC;
           btnU : in  STD_LOGIC;
           seg  : out STD_LOGIC_VECTOR (6 downto 0);
           an   : out STD_LOGIC_VECTOR (3 downto 0);
           led  : out STD_LOGIC_VECTOR (7 downto 0));
end digital_clock_topmodule;

architecture Behavioral of digital_clock_topmodule is
component digital_clock is
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
end component;

component sevenseg_driver is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           in1 : in  STD_LOGIC_VECTOR (3 downto 0);
           in2 : in  STD_LOGIC_VECTOR (3 downto 0);
           in3 : in  STD_LOGIC_VECTOR (3 downto 0);
           in4 : in  STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an  : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component debounce_0 is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           clr : out STD_LOGIC);
end component;


-- sinyaller
signal h2,h1,m2,m1,s2,s1                        : std_logic_vector(3 downto 0) ;
signal h_up, min_up                             : std_logic;

signal btnCclr, btnUclr, btnRclr                : STD_LOGIC;
signal btnCclr_prev, btnUclr_prev, btnRclr_prev : STD_LOGIC;

begin


  debC : debounce_0 port map(clk, btnC, btnCclr);
  debR : debounce_0 port map(clk, btnR, btnRclr);
  debU : debounce_0 port map(clk, btnU, btnUclr);
  -- seven segment sürücü
  seg7 : sevenseg_driver port map(clk, '0', h2, h1, m2, m1, seg, an);
  -- dijital saat modülü
  clock1 : digital_clock port map(clk, sw, btnCclr, h_up, min_up, s1, s2, m1, m2, h1, h2);
  
    -- hrup ve minup güncelleme süreci
    process(clk)
    begin
        if rising_edge(clk) then
            btnUclr_prev <= btnUclr;
            btnRclr_prev <= btnRclr;

            if (btnUclr_prev = '0' and btnUclr = '1') then
                h_up <= '1';
            else
                h_up <= '0';
            end if;

            if (btnRclr_prev = '0' and btnRclr = '1') then
                min_up <= '1';
            else
                min_up <= '0';
            end if;
        end if;
    end process;
    
    
end Behavioral;
