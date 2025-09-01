entity axis_rx_adapter is
  port (
    clk       : in  std_logic;
    rst       : in  std_logic;
    uart_data : in  std_logic_vector(7 downto 0);
    uart_valid: in  std_logic;
    m_axis_tdata  : out std_logic_vector(7 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in  std_logic
  );
end entity;

architecture rtl of axis_rx_adapter is
begin
  process(clk, rst)
  begin
    if rst = '1' then
      m_axis_tdata <= (others => '0');
      m_axis_tvalid <= '0';
    elsif rising_edge(clk) then
      if uart_valid = '1' then
        m_axis_tdata <= uart_data;
        m_axis_tvalid <= '1';
      elsif m_axis_tready = '1' and m_axis_tvalid = '1' then
        -- Clear valid when data is accepted
        m_axis_tvalid <= '0'; 
      end if;
    end if;
  end process;
end rtl;