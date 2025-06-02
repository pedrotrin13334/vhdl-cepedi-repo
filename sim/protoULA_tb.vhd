library protoULA;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity protoULATb is
end protoULATb;

architecture Behavorial of ProtoULATb is
    constant CLK_PERIOD : time := 20 ns;
    signal clk : std_logic := '0'; 

    signal sig_A : signed(15 downto 0) := (others=>'0');
    signal sig_B : signed(15 downto 0) := (others=>'0');
    signal sig_sel : std_logic_vector(1 downto 0) := (others=>'0');
    signal sig_protoULA : signed(15 downto 0);
    signal sig_mult : signed(31 downto 0) := (0 => '1', others=>'0');
begin
    clk_synth : process
    begin
        clk <= not clk; 
        wait for CLK_PERIOD/2;
    end process;

    protoULATop : entity protoULA.protoULATop
    port map(
        A_in => sig_A,
        B_in => sig_B,
        sel_in => sig_sel,
        protoULA_out => sig_protoULA
    );

    stimulus : process
    begin

        sig_sel <= "01";
        sig_B <= x"0004";

        wait for 5*CLK_PERIOD;
        for value in 0 to 15 loop
            sig_A <= sig_A + x"0002";
            sig_mult <= sig_B*x"0002";
            wait for 1*CLK_PERIOD;
            sig_B <= sig_mult(15 downto 0);
            wait for 5*CLK_PERIOD;
        end loop;

        wait; 
    end process;

end architecture Behavorial;