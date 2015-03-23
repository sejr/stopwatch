------------------------------------------
-- Purp:        A register
-- Fnc:		0 hold
--		     1 load
------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg is
    generic(N: integer:=4);
    port(clk,reset, c : in std_logic;
			d: in std_logic_vector(N-1 downto 0);
			q : out std_logic_vector(N-1 downto 0));
end reg;

architecture behavior of reg is
    
begin
    process (clk, reset)
    begin
	if (reset='0') then
	    q <= (others => '0');
	elsif (clk'event and clk='1')  then
	if (c='1') then q <= d; end if;
	end if;
    end process;
end behavior;

