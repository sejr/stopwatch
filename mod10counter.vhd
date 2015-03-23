----------------------------------------------------------------------------------
-- Company: Ohio Northern University
-- Engineers: Eric Biedenharn, Donald Bartlett
-- Date: March 20, 2014
-- Purp: Create a mod10counter
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

----------------------------------------------------------------------------------
-- Display results
----------------------------------------------------------------------------------

entity Mod10Counter is
	Port (reset, clk, enb, synch: in std_logic;
		roll: out std_logic;
		Q: out std_logic_vector(3 downto 0));

end Mod10Counter;


architecture structure of Mod10Counter is

	component compare is
		generic(N: integer := 4);
    port(x,y : in std_logic_vector(N-1 downto 0);
	 g,l,e: out std_logic);	
	end component;
	
	component muxNx2x1 is
		generic(N: integer := 4);
    port(y1,y0: in std_logic_vector(N-1 downto 0);
	 s: in std_logic;
	 f: out std_logic_vector(N-1 downto 0) );
	end component;

	component ADD is
		generic(n: integer :=4);
		port (A: in std_logic_vector (n-1 downto 0);
			B: in std_logic_vector (n-1 downto 0);
			cin : in std_logic;
			cout: out std_logic;
			sum : out std_logic_vector (n-1 downto 0));
	end component;
	
	component reg is
  	  	generic(N: integer:=4);
   	 	port(clk,reset, c : in std_logic;
			d: in std_logic_vector(N-1 downto 0);
			q : out std_logic_vector(N-1 downto 0));
	end component;

	signal constant_9, constant_1 : std_logic_vector (3 downto 0);
	signal selA, cpG, regC, cinA : std_logic;
	signal sumA, muxA, regA : std_logic_vector (3 downto 0);
	
	
	begin 
	
	constant_9 <= "1001";
	constant_1 <= "0001";
	cinA <= '0';
	add1: ADD generic map (4) port map (constant_1, regA, cinA, open, sumA);
	checkA: compare generic map (4) port map (sumA, constant_9, cpG, open, open);
	selA <= cpG OR synch;
	mux1 : muxNx2x1 generic map (4) port map ("0000", sumA, selA, muxA);
	roll <= cpG AND enb;
	regC <= synch XOR enb;
	reg1 : reg generic map (4) port map (clk, reset, regC, muxA, regA);
	Q <= regA;

end structure;