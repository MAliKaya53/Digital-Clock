----------------------------------------------------------------------------------
-- Engineer: 
-- 
-- Description: 
-- FPGA veya mikrodenetleyicide bir butona bastığında, 
-- butonun mekanik yapısı nedeniyle tek bir basma olayı elektriksel olarak 
-- birden fazla hızlı 0-1 geçişi şeklinde algılanır.
-- Bu olaya "switch bounce" denir.
-- Eğer debounce yapılmazsa:
-- Tek basış = FPGA için birkaç basış gibi algılanır
-- Menü atlama, sayaçta birden fazla artış, yanlış tetikleme gibi sorunlar olur
-- 
-- 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity debounce_0 is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           clr : out STD_LOGIC);
end debounce_0;

architecture Behavioral of debounce_0 is
    constant CNT_MAX : integer := 500000; -- 10 ms @ 50 MHz
    signal counter   : integer range 0 to CNT_MAX := 0;
    signal btn_sync  : STD_LOGIC := '0';
    signal btn_reg   : STD_LOGIC := '0';
begin

process(clk)
    begin
        if rising_edge(clk) then
            -- Girişi senkronize et
            btn_sync <= btn;

            -- Eğer giriş değişmediyse sayaç artır
            if btn_sync = btn_reg then
                if counter < CNT_MAX then
                    counter <= counter + 1;
                end if;
            else
                counter <= 0;  -- değişiklik olduysa sayaç sıfırla
            end if;

            -- Sayaç dolduysa çıkış güncelle
            if counter = CNT_MAX then
                btn_reg <= btn_sync;
            end if;
        end if;
    end process;

    clr <= btn_reg; -- debounce edilmiş çıkış

end Behavioral;
