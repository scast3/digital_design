library IEEE;
use IEEE.std_logic_1164.all;

entity p2 is
    port(A,B,C,D,E,F,G : in std_logic;
    X,Y : out std_logic);
end p2;

architecture structure of p2 is
signal redGate, purpleGate : std_logic;

begin
    redGate <= (not C and D) and (not E)