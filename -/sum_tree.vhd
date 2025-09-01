library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

library ProtoULA;
use ProtoULA.custom_types.all;

entity sum_tree is
generic(
    N_SUMS : natural := 2**6
);
port(
    in_sums : in signed_array(N_SUMS-1 downto 0);
    out_sum : out signed(N_WORD-1 downto 0);
    clk_in : in std_logic;
    reset_in : in std_logic
);
begin 
    assert (N_SUMS mod 2) = 0 
    report "Number of sums must be power of two"
    severity failure; 
end sum_tree;

architecture Behavorial of sum_tree is
    signal left_sum : signed(N_WORD-1 downto 0) := (others=>'0');
    signal right_sum : signed(N_WORD-1 downto 0) := (others=>'0');
begin
    
    base_case_gen : if N_SUMS = 2 generate
        left_sum <= in_sums(0);
        right_sum<= in_sums(1);
    end generate base_case_gen;
    
    recursive_gen : if N_SUMS > 2 generate
        left_sums : entity protoULA.sum_tree 
            generic map(N_SUMS => N_SUMS/2) 
            port map(in_sums => in_sums(N_SUMS-1 downto N_SUMS/2),
                     out_sum => left_sum,
                     clk_in => clk_in,
                     reset_in => reset_in); 

        right_sums : entity protoULA.sum_tree 
            generic map(N_SUMS => N_SUMS/2) 
            port map(in_sums => in_sums(N_SUMS/2-1 downto 0),
                     out_sum => right_sum,
                     clk_in => clk_in,
                     reset_in => reset_in);
    end generate recursive_gen;

    process(clk_in) 
    begin 
        if rising_edge(clk_in) then 
            if reset_in = '0' then 
                out_sum <= (others=>'0');
            else 
                out_sum <= left_sum + right_sum; 
            end if;
        end if;
    end process;

end architecture Behavorial;