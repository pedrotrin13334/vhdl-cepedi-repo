library protoULA;
use protoULA.custom_types.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity protoULATop is
port(
    A_in : in signed(15 downto 0);
    B_in : in signed(15 downto 0);
    sel_in : in std_logic_vector(1 downto 0);
    protoULA_out : out signed(15 downto 0)
);
end protoULATop;

architecture Behavorial of ProtoULATop is
    signal sig_operations : signed_array(3 downto 0) := (others=>(others=>'0')); 
begin
    and_gate : entity protoULA.and_gate
    port map (
        A_in => A_in,
        B_in => B_in,
        C_out => sig_operations(0)
    );

    mult_gate : entity protoULA.mult_gate
    port map (
        A_in => A_in,
        B_in => B_in,
        C_out => sig_operations(1)
    );

    sub_gate : entity protoULA.sub_gate
    port map (
        A_in => A_in,
        B_in => B_in,
        C_out => sig_operations(2)
    );

    sum_gate : entity protoULA.sum_gate
    port map (
        A_in => A_in,
        B_in => B_in,
        C_out => sig_operations(3)
    );

    mux_gate : entity protoULA.mux_gate 
    port map(
        An_in => sig_operations,
        operation_out => protoULA_out,
        sel_in => sel_in
    ); 

end architecture Behavorial;