library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Toplevel is
    Port ( Clk,N,D,Reset : in std_logic;
           Candy : out std_logic;
           CR : out  std_logic;
           out7 : out  std_logic_vector (6 downto 0);
           anode : out std_logic_vector (3 downto 0)
           -- en_out : out std_logic_vector (7 downto 0)
           );
end Toplevel;

architecture Behavioral of Toplevel is
	
	component Clockdiv is
		port ( clk,reset: in std_logic;
               clock_out: out std_logic);
	end component;
	
	component buttonsynch is
       Port ( bi , Reset, Clk : in std_logic;
              bo : out std_logic); 
    end component;
    
    component vendingmach is
       port( Clk,Reset,N,D  : in std_logic; 
             Candy,CR  : out std_logic;
             number : out std_logic_vector); 
    end component;
    
    component Twodigitd is
       Port (BCDin: in std_logic_vector (5 downto 0);
             clk_t: in std_logic; 
             seven_segment : out std_logic_vector (6 downto 0);
             anode: out std_logic_vector (3 downto 0));
    end component;
    
signal clk_out : std_logic;
signal boN : std_logic;
signal boD : std_logic;
signal number : std_logic_vector(5 downto 0);
begin

B1: buttonsynch port map( 
bi => N, 
Reset => Reset, 
Clk => clk_out,
bo => boN
);

B2: buttonsynch port map( 
bi => D, 
Reset => Reset, 
Clk => clk_out,
bo => boD
);

B3: Clockdiv port map( 
clk => Clk,
reset => '0',
clock_out => clk_out
);

B4: vendingmach port map( 
Clk => clk_out,
Reset => Reset,
N => boN,
D => boD,
number => number,
Candy => Candy,
CR => CR
);

B5: Twodigitd port map( 
clk_t => Clk, 
BCDin => number, 
anode => anode,
seven_segment => out7
);

end Behavioral;