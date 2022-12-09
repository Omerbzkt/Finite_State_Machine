library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buttonsynch is
Port ( 
bi , Reset, Clk : in std_logic;
bo : out std_logic
);
end buttonsynch;

architecture process_3 of buttonsynch is
   type state_type is (S0,S1,S2);
   signal state, next_state: state_type;

begin

state_register : process (Clk, Reset)
begin
if (Reset = '1') then
   state <= S0;
   elsif (Clk'event and Clk = '1') then
   state <= next_state;
   end if;
   end process;
   
output_function: process (bi,state)
begin
case state is
when S0 => bo <= '0';
when S1 => bo <= '1';
when S2 => bo <= '0';
end case;
end process;

next_state_function: process(bi,state)
begin
case state is
when S0 => 
if bi = '1' then next_state <= S1;
else next_state <= S0;
end if;
when S1 =>
if bi = '1' then next_state <= S2;
else next_state <= S0;
end if;
when S2 =>
if bi = '1' then next_state <= S2;
else next_state <= S0;
end if;
end case;
end process;
end architecture;
