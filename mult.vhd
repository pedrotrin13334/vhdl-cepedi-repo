library IEEE;
use IEEE.numeric_std.all;

entity mult_gate is
port(
    A_in : in signed(15 downto 0);
    B_in : in signed(15 downto 0);
    C_out : out signed(15 downto 0)
);
end mult_gate;

architecture Behavorial of mult_gate is
    signal mult_sig : signed(31 downto 0) := (others=>'0');
begin
    
    mult_sig <= A_in * B_in; 
    C_out <= mult_sig(15 downto 0);
    
end architecture Behavorial;
