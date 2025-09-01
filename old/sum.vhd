library IEEE;
use IEEE.numeric_std.all;

entity sum_gate is
port(
    A_in : in signed(15 downto 0);
    B_in : in signed(15 downto 0);
    C_out : out signed(15 downto 0)
);
end sum_gate;

architecture Behavorial of sum_gate is
begin
    
    C_out <= A_in + B_in; 
    
end architecture Behavorial;