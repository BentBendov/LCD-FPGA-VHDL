library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity c_ir_incrementor is
generic (
c_birlerlim	: integer := 9;
c_onlarlim	: integer := 9
);
port (
clk			: in std_logic;
increment_i	: in std_logic;
reset_i		: in std_logic;
birler_o	: out std_logic_vector (3 downto 0);
onlar_o		: out std_logic_vector (3 downto 0)
);
end c_ir_incrementor;

architecture Behavioral of c_ir_incrementor is

signal birler					: std_logic_vector (3 downto 0) := (others => '0');
signal onlar					: std_logic_vector (3 downto 0) := (others => '0');
signal increment_prev			: std_logic := '0';
begin

process (clk) begin
if (rising_edge(clk)) then

increment_prev <= increment_i;
	if (increment_prev = '1' and increment_i = '0') then
		if (birler = c_birlerlim) then
			if (onlar = c_onlarlim) then
				birler	<= x"0";
				onlar	<= x"0";
			else
				birler 	<= x"0";
				onlar	<= onlar + 1;
			end if;
		else
			birler	<= birler + 1;
		end if;
	end if;
	
	if (reset_i = '1') then
		birler	<= x"0";
		onlar	<= x"0";
	end if;

end if;
end process;

birler_o	<= birler;
onlar_o		<= onlar;

end Behavioral;