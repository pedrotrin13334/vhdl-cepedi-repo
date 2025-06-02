library protoULA;
use protoULA.custom_types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_gate is
port(
    An_in : in signed_array(3 downto 0);
    operation_out : out signed(15 downto 0);
    sel_in : in std_logic_vector(1 downto 0)
);
end mux_gate;

architecture Behavorial of mux_gate is
begin

operation_out <= An_in(to_integer(unsigned(sel_in))); 
    
end architecture Behavorial;