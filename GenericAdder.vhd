--------------------------------------------------
-- Date: Spring 2014
-- Purp: A generic adder
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------
entity ADD is

generic(n: integer :=4);
port(	A:	in std_logic_vector(n-1 downto 0);
		B:	in std_logic_vector(n-1 downto 0);
		cin : in std_logic;
		cout:	out std_logic;
		sum:	out std_logic_vector(n-1 downto 0)
);

end ADD;

--------------------------------------------------------

architecture behv of ADD is
signal result: std_logic_vector(n downto 0);
 
begin					  
 
    result <= ('0' & A)+('0' & B) + cin;
    sum <= result(n-1 downto 0);
    cout <= result(n);

end behv;

