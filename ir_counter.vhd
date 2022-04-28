library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ir_counter is
Port (
	clk			: in 	std_logic;
	btn			: in 	std_logic;
	reset_sayi	: in 	std_logic;
	birler_cikis 		: out 	std_logic_vector (7 downto 0);
	onlar_cikis			: out 	std_logic_vector (7 downto 0)
 );
end ir_counter;




architecture Behavioral of ir_counter is

signal birler_bcd			: std_logic_vector (3 downto 0) := (others => '0');
signal onlar_bcd			: std_logic_vector (3 downto 0) := (others => '0');

--------------------------------------------------------
-- Component Decleration
--------------------------------------------------------
component bcd_to_binary is
port (
bcd_i		: in std_logic_vector (3 downto 0);
sevenseg_o	: out std_logic_vector (7 downto 0)
);
end component;

component c_ir_incrementor is
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
end component;


begin

i_increment : c_ir_incrementor
generic map(
c_birlerlim	=> 9,
c_onlarlim	=> 9
)
port map(
clk			=> clk,
increment_i	=> btn,
reset_i		=> reset_sayi,
birler_o	=> birler_bcd,
onlar_o		=> onlar_bcd
);

i_birler : bcd_to_binary
port map(
bcd_i		=> birler_bcd,
sevenseg_o	=> birler_cikis
);

i_onlar : bcd_to_binary
port map(
bcd_i		=> onlar_bcd,
sevenseg_o	=> onlar_cikis
);

end Behavioral;
