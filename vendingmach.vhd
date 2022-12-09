library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vendingmach is
port(
    Clk,Reset,N,D  : in std_logic; 
    Candy,CR  : out std_logic;
    number : out std_logic_vector (5 downto 0)
    ); 
end vendingmach;

architecture process_2 of vendingmach is

type state is (S0,S1,S2,S3,S4,S5,S6,S7);
signal first_state,next_state : state;
begin

SEQ:process(Clk,Reset)
begin
    if (Reset='1') then
    first_state <= S0;
    elsif(Clk'event and Clk = '1') then
    first_state <= next_state;
    end if;
end process;

st: process(first_state,D,N)
begin
case first_state is
            when s0 =>
                Candy <= '0';
                CR <= '0';
                if N ='1' and D='0' then next_state <=s1;
                    number <= "000101";--5
                   -- number(0)<='1';
                  --  number(1)<='0';
                   -- number(2)<='1';
                  --  number(3)<='0';
                  --  number(4)<='0';
                  --  number(5)<='0';
                elsif D ='1' and N='0' then next_state <=s2;
                    number <= "001010";
                else next_state <=s0;--10
                    number <= "000000";--0
                end if;
            when s1 =>
                Candy <= '0';
                CR <= '0';
                if N ='1' and D='0' then next_state <=s2;
                    number <= "001010";--10
                elsif D ='1' and N='0' then next_state <=s3;
                    number <= "001111";--15
                else next_state <=s1;
                    number <= "000101";--5
                end if;
            when s2 =>
                Candy <= '0';
                CR <= '0';
                if N ='1' and D='0' then next_state <=s3;
                    number <= "001111";--15
                elsif D ='1' and N='0' then next_state <=s4;
                    number <= "010100";--20
                else next_state <=s2;
                    number <= "001010";--10
                end if;
            when s3 =>
                Candy <= '0';
                CR <= '0';
                if N ='1' and D='0' then next_state <=s4;
                    number <= "010100";--20
                elsif D ='1' and N='0' then next_state <=s5;
                    number <= "011001";--25
                else next_state <=s3;
                    number <= "001111";--15
                end if;                
            when s4 =>
                Candy <= '0';
                CR <= '0';
                if N ='1' and D='0' then next_state <=s5;
                    number <= "011001";--25
                elsif D ='1' and N='0' then next_state <=s6;
                    number <= "011110";--30
                else next_state <=s4;
                    number <= "010100";--20
                end if;                
            when s5 =>
                Candy <= '0';
                CR <= '0';
                if N ='1' and D='0' then next_state <=s6;
                    number <= "011110";--30
                elsif D ='1' and N='0' then next_state <=s7;
                    number <= "100011";--35
                else next_state <=s5;
                    number <= "011001";--25
                end if;                
            when s6 =>
                Candy <= '1';
                CR <= '0';
                if N ='1' or D='1' then next_state <=s0;
                    number <= "000000";--0
                else next_state <=s0;
                    number <= "000000";--0
                end if;               
            when s7 =>
                Candy <= '1';
                CR <= '1';
                if N ='1' or D='1' then next_state <=s0;
                    number <= "000000";--0
                else next_state <=s0;
                    number <= "000000";--0
                end if;       
        end case;
end process;
end architecture;