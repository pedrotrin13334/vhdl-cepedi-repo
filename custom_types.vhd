library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
package custom_types is
    constant N_WORD : natural := 16;
    type signed_array is array (natural range <>) of signed(N_WORD-1 downto 0);
end package custom_types;