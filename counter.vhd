------------------------------------------

-- Purp:        generic counter
-- Fnc:		00 hold
--		10 count up
--		x1 synch reset
------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity counter is
    generic(N: integer:=4);
    port(clk,reset : in std_logic;
	c: in std_logic_vector(1 downto 0); 
	d: in std_logic_vector(N-1 downto 0);
	 q : out std_logic_vector(N-1 downto 0));
end counter;

architecture behavior of counter is
    signal tmp: std_logic_vector(N-1 downto 0);
begin
    process (clk, reset)
    begin
	if (reset='0') then
	    tmp <= (others => '0');
	elsif (clk'event and clk='1')  then
	case c is
	    when "00" => tmp <= tmp;  
		when "01" => tmp <= d;
	    when "10" => tmp <= tmp+1;
	    when others => tmp <= (others => '0');
	end case;
	end if;
    end process;
    q <= tmp;
end behavior;

