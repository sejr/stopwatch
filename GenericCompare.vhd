--------------------------------------------------
-- Date: Spring 2014
-- Purp: A magnitude comparator (unsigned)
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity compare is
    generic(N: integer := 4);
    port(x,y : in std_logic_vector(N-1 downto 0);
	 g,l,e: out std_logic);
end compare;

architecture behavior of compare is
	signal tmp : std_logic_vector(2 downto 0);
begin
	tmp <=	"100" when x > y else
		"010" when x < y else
		"001";
	g <= tmp(2);
	l <= tmp(1);
	e <= tmp(0);
end behavior;
