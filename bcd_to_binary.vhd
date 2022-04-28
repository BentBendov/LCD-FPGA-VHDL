library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_to_binary is
port (
bcd_i		: in std_logic_vector (3 downto 0);
sevenseg_o	: out std_logic_vector (7 downto 0)
);
end bcd_to_binary;

architecture Behavioral of bcd_to_binary is

begin

process (bcd_i) begin

	case bcd_i is
		
		when "0000" =>			
			sevenseg_o	<= "00110000"; -- 0
			
		when "0001" =>		
			sevenseg_o	<= "00110001"; -- 1
			
		when "0010" =>		
			sevenseg_o	<= "00110010"; -- 2
			
		when "0011" =>
			sevenseg_o	<= "00110011"; -- 3
			
		when "0100" =>
			sevenseg_o	<= "00110100"; -- 4
			
		when "0101" =>
			sevenseg_o	<= "00110101"; -- 5
			
		when "0110" =>
			sevenseg_o	<= "00110110"; -- 6
			
		when "0111" =>
			sevenseg_o	<= "00110111"; -- 7
			
		when "1000" =>
			sevenseg_o	<= "00111000"; -- 8
			
		when "1001" =>
			sevenseg_o	<= "00111001"; -- 9
			
		when others =>
			sevenseg_o	<= "00100000"; -- blank space
		
	end case;

end process;

end Behavioral;