library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use work.basicBuildingBlocks.ALL;

entity genericAdder is
    generic(N: integer := 4);
    port( a,b: in std_logic_vector(N-1 downto 0);
        sum: out std_logic_vector(N-1 downto 0));
end genericAdder;
----------------------------------------------
entity genericCompare is
    generic(N: integer := 4);
    port( x,y : in std_logic_vector(N-1 downto 0);
        g,l,e: out std_logic);
end genericCompare;
----------------------------------------------
entity genericMux2x1 is
    generic(N: integer := 4);
    port( y1,y0: in std_logic_vector(N-1 downto 0);
        s: in std_logic;
        f: out std_logic_vector(N-1 downto 0) );
end genericMux2x1;
----------------------------------------------
entity genericRegister is
    generic(N: integer := 4);
    port( clk, reset,load: in std_logic;
        d: in std_logic_vector(N-1 downto 0);
        q: out std_logic_vector(N-1 downto 0) );
end genericRegister;
----------------------------------------------

entity mod10Counter is
    Port ( clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        enb : in STD_LOGIC;
        synch : in STD_LOGIC;
        roll : out STD_LOGIC;
        count : out STD_LOGIC_VECTOR (3 downto 0));
end mod10Counter;

architecture Behavioral of mod10Counter is
    component genericAdder is
        generic(N: integer := 4);
        port(a,b: in std_logic_vector(N-1 downto 0);
            sum: out std_logic_vector(N-1 downto 0));
    end component;

    component genericCompare is
        generic(N: integer := 4);
        port(x,y : in std_logic_vector(N-1 downto 0);
            g,l,e: out std_logic);
    end component;

    component genericMux2x1 is
        generic(N: integer := 4);
        port(y1,y0: in std_logic_vector(N-1 downto 0);
            s: in std_logic;
            f: out std_logic_vector(N-1 downto 0) );
    end component;

    component genericRegister is
        generic(N: integer := 4);
        port ( clk, reset,load: in std_logic;
            d: in std_logic_vector(N-1 downto 0);
            q: out std_logic_vector(N-1 downto 0) );
    end component;

    signal countPlusOne : STD_LOGIC_VECTOR(3 downto 0);
    signal nextCount : STD_LOGIC_VECTOR(3 downto 0);
    signal currentCount : STD_LOGIC_VECTOR(3 downto 0);
    signal inputCtrlVec: STD_LOGIC_VECTOR(2 downto 0);
    signal outputCtrlVec: STD_LOGIC_VECTOR(2 downto 0);
    signal equalNine, muxSel, regEnb: STD_LOGIC;

begin
    add_inst : genericAdder
        GENERIC MAP(4)
        PORT MAP(a => currentCount, b => "0001", sum => countPlusOne);

    comp_inst : genericCompare
        GENERIC MAP(4)
        PORT MAP(x => currentCount, y => "1001", g => open, l => open,
        e => equalNine);

    mux_inst: genericMux2x1
        GENERIC MAP(4)
        PORT MAP(y1 => ________, y0 => ________,
        s => ________, f => ________);

    reg_inst: genericRegister
        GENERIC MAP(4)
        PORT MAP(clk => ________, reset => ________, load => ________,
        d => ________, q => ________);

    count <= currentCount;
    inputCtrlVec <= enb & synch & equalNine;

    muxSel <= outputCtrlVec(2);
    regEnb <= outputCtrlVec(1);
    roll <= outputCtrlVec(0);

    outputCtrlVec <= "000" when inputCtrlVec = "000" else
                    "000" when inputCtrlVec = "001" else
                    "010" when inputCtrlVec = "010" else
                    "010" when inputCtrlVec = "011" else
                    "110" when inputCtrlVec = "100" else
                    "011" when inputCtrlVec = "101" else
                    "010" when inputCtrlVec = "110" else
                    "010" when inputCtrlVec = "111";
end Behavioral;