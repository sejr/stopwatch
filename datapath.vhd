----------------------------------------------------------------------------------
-- DIGITAL LOGIC, Spring 2015
-- LAB 9: STOPWATCH DATAPATH
--
-- Sam Roth and Tyler Silcox
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datapath is
    Port
    (
        clk, reset                  : in  STD_LOGIC;
        cw                          : in  STD_LOGIC_VECTOR (3 downto 0);
        sw                          : out STD_LOGIC;
        tenth_digit, unit_digit     : out STD_LOGIC_VECTOR (6 downto 0);
    );
end datapath;

architecture Behavioral of datapath is

    component counter is
        generic(N: integer:=4);
        port
        (
            clk,reset               : in  STD_LOGIC;
    	    c                       : in  STD_LOGIC_VECTOR (1 downto 0);
            d                       : in  STD_LOGIC_VECTOR (N-1 downto 0);
            q                       : out STD_LOGIC_VECTOR (N-1 downto 0)
        );
    end component;

    component compare is
        generic(N: integer := 4);
        port
        (
            x, y                    : in  STD_LOGIC_VECTOR (N-1 downto 0);
            g, l, e                 : out STD_LOGIC
        );
    end component;

    component Mod10Counter is
        port
        (
            reset, clk, enb, synch  : in  STD_LOGIC;
            roll                    : out STD_LOGIC;
            Q                       : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component Hex2Seven is
        port
        (
            hex                     : in  STD_LOGIC_VECTOR (3 downto 0);
            seg                     : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    signal constant_9               : STD_LOGIC_VECTOR (23 downto 0);
    signal roll                     : STD_LOGIC;
    signal unit_digit               : STD_LOGIC_VECTOR (3 downto 0);
    signal tenth_digit              : STD_LOGIC_VECTOR (3 downto 0);
    signal seg_unit                 : STD_LOGIC_VECTOR (6 downto 0);
    signal seg_tenth                : STD_LOGIC_VECTOR (6 downto 0);

    begin

        constant_9 <= "000000000000000000001001";

        sec_cnt:   counter      generic map (24) port map (clk, reset, c, d, q);
        sec_cmp:   compare      generic map (24) port map (x, constant_9, g, l, e);

    	unit:      Mod10Counter port map (reset, sw, roll, cw(3), open, unit);
        tenth:     Mod10Counter port map (reset, sw, cw(2), cw(3), roll, Q);

        UnitSeg:   Hex2Seven    port map (unit_digit, seg_unit);
        TenthSeg:  Hex2Seven    port map (tenth_digit, seg_tenth);

end Behavioral;
