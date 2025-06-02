library IEEE;
use IEEE.numeric_std.all;

entity and_gate is
port(
    A_in : in signed(15 downto 0);
    B_in : in signed(15 downto 0);
    C_out : out signed(15 downto 0)
);
end and_gate;

architecture Behavorial of and_gate is
begin
    
    C_out <= A_in and B_in; 
    
end architecture Behavorial;
