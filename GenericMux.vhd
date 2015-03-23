--------------------------------------------------
-- Date: Spring 2014
-- Purp: A generic mux
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--------------------------------------------------------

entity muxNx2x1 is
    generic(N: integer := 4);
    port(y1,y0: in std_logic_vector(N-1 downto 0);
	 s: in std_logic;
	 f: out std_logic_vector(N-1 downto 0) );
end muxNx2x1;

architecture behavior of muxNx2x1 is
begin
	f <= y1 when s='1' else y0;
end behavior;
