library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is 
  generic(
    CLK_FREQ : integer := 50000000; -- Clock frequency in Hz
    BAUD_RATE : integer := 115200   -- Baud rate
  );
  port (
    clk: in std_logic;
    rst: in std_logic;
    rx: in std_logic;
    data_out: out std_logic_vector(7 downto 0);
    data_valid: out std_logic
  );
end entity uart_rx;

architecture rtl of uart_rx is
  constant BAUD_TICK_CNT : integer := CLK_FREQ / BAUD_RATE;
  signal baud_cnt : integer := 0;
  signal bit_cnt : integer := 0;
  signal rx_reg : std_logic := '1';
  signal rx_shift : std_logic_vector(7 downto 0) := (others => '0');
  signal sampling : boolean := false;
begin
  process(clk, rst)
    -- UART RX state machine implementation
  begin
    if rst = '1' then
      baud_cnt <= 0;
      bit_cnt <= 0;
      rx_reg <= '1';
      data_out <= (others => '0');
      data_valid <= '0';
      sampling <= false;
    elsif rising_edge(clk) then
      rx_reg <= rx;

      if not sampling then
        if rx_reg = '0' then -- Start bit detected
          sampling <= true;
          baud_cnt <= BAUD_TICK_CNT / 2; -- Sample in the middle of the bit
          bit_cnt <= 0;
        end if;
      else
        if baud_cnt = BAUD_TICK_CNT - 1 then
          baud_cnt <= 0;
          if bit_cnt < 8 then
            rx_shift(bit_cnt) <= rx_reg; -- Sample data bits
            bit_cnt <= bit_cnt + 1;
          elsif bit_cnt = 8 then
            if rx_reg = '1' then -- Stop bit detected
              data_out <= rx_shift;
              data_valid <= '1';
              sampling <= false; -- End of reception
            end if;
          end if;
        else
          baud_cnt <= baud_cnt + 1;
          data_valid <= '0';
        end if;
      end if;
    end if;
  end process;
end rtl;
