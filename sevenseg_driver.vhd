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
use IEEE.NUMERIC_STD.ALL;


entity sevenseg_driver is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           in1 : in  STD_LOGIC_VECTOR (3 downto 0);
           in2 : in  STD_LOGIC_VECTOR (3 downto 0);
           in3 : in  STD_LOGIC_VECTOR (3 downto 0);
           in4 : in  STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an  : out STD_LOGIC_VECTOR (3 downto 0));
end sevenseg_driver;

architecture Behavioral of sevenseg_driver is

component decoder_7seg is
    Port ( in1  : in  STD_LOGIC_VECTOR (3 downto 0);
           out1 : out STD_LOGIC_VECTOR (6 downto 0));
end component;

type state_type is (LEFT, MIDLEFT, MIDRIGHT, RIGHT);
signal state   : state_type := LEFT;
signal seg1    : STD_LOGIC_VECTOR (6 downto 0); 
signal seg2    : STD_LOGIC_VECTOR (6 downto 0); 
signal seg3    : STD_LOGIC_VECTOR (6 downto 0); 
signal seg4    : STD_LOGIC_VECTOR (6 downto 0); 
signal segclk  : STD_LOGIC_VECTOR (6 downto 0) := (others => '0'); --(12 downto 0) := (others => '0'); 

begin

process (clk) begin
    if rising_edge(clk) then
        segclk <= std_logic_vector(unsigned(segclk) + 1);
    end if;
end process;

process (segclk(6), clr) begin--(segclk(12), clr) begin
    if(clr = '1') then
        seg   <= seg1;
        an    <= "0000";
        state <= LEFT;
    elsif (rising_edge(segclk(6)) ) then
        case state is
            when LEFT => 
                seg   <= seg1;
                an    <= "0111"; -- Sol en display aktif
                state <= MIDLEFT;
            when MIDLEFT => 
                seg   <= seg1;
                an    <= "1011"; -- Soldan ikinci aktif
                state <= MIDRIGHT;
             when MIDRIGHT => 
                seg   <= seg1;
                an    <= "1101"; -- Sağdan ikinci aktif
                state <= RIGHT;
             when RIGHT => 
                seg   <= seg1;
                an    <= "1110"; -- Sağ en display aktif
                state <= LEFT;
        end case;
    end if;
end process;

disp1: decoder_7seg port map(in1=> in1, out1=> seg1);
disp2: decoder_7seg port map(in1=> in2, out1=> seg2);
disp3: decoder_7seg port map(in1=> in3, out1=> seg3);
disp4: decoder_7seg port map(in1=> in4, out1=> seg4);

end Behavioral;
