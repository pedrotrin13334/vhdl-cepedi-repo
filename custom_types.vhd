library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package custom_types is
    type signed_array is array (integer range <>) of signed(15 downto 0);
end package custom_types;