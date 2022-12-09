library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Twodigitd is
Port (
BCDin: in std_logic_vector (5 downto 0);
clk_t: in std_logic; 
seven_segment : out std_logic_vector (6 downto 0);
anode: out std_logic_vector (3 downto 0)
);
end Twodigitd;

architecture Behavioral of Twodigitd is
signal count: natural range 0 to 100000 :=0;
signal an_number: natural range 0 to 3 :=0;

begin
process(clk_t)
begin
if(rising_edge(clk_t)) then
   count <=count+1;
   if(count >= 100000) then
      count <=0;
      an_number <= an_number +1;
      if (an_number>3) then
          an_number <=0;
      end if;
  end if;
end if;
end process;

process(an_number)
begin 
    case an_number is
    when 0 => anode <= "1110";
    when 1 => anode <= "1101";
    when 2 => anode <= "1011";
    when 3 => anode <= "0111";
    end case;
    
end process;

process(an_number)
begin 
case an_number is 
when 0 => 
case BCDin is
when "000000" => seven_segment <= "1000000";
when "000101" => seven_segment <= "0010010";
when "001010" => seven_segment <= "1000000";
when "001111" => seven_segment <= "0010010";
when "010100" => seven_segment <= "1000000";
when "011001" => seven_segment <= "0010010";
when "011110" => seven_segment <= "1000000";
when "100011" => seven_segment <= "0010010";
when others =>   seven_segment <= "1111111";
end case;
when 1 => 
case BCDin is
when "000000" => seven_segment <= "1000000";
when "000101" => seven_segment <= "1000000";
when "001010" => seven_segment <= "1111001";
when "001111" => seven_segment <= "1111001";
when "010100" => seven_segment <= "0100100";
when "011001" => seven_segment <= "0100100";
when "011110" => seven_segment <= "0110000";
when "100011" => seven_segment <= "0110000";
when others =>   seven_segment <= "1111111";
end case;
when others =>   seven_segment <= "1111111";
end case;

end process;

end Behavioral;