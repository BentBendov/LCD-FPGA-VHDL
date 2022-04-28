library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lcd_top is
	port (
		clk          : in  std_logic;
		ir_giris	 : in  std_logic;	-- ir girisi yeni ekledim 
		sw_i		 : in  std_logic;
		reset_sayi   : in  std_logic;   -- sayiyi resetlemek icin yeni ekledim 
		rst          : in  std_logic;
		lcd_e        : out std_logic;
		lcd_rs       : out std_logic;
		lcd_rw       : out std_logic;
		lcd_db       : out std_logic_vector(7 downto 0));
		
end lcd_top;

architecture Behavioral of lcd_top is

	COMPONENT lcd_controller IS
	  PORT(
		 clk        	: IN    STD_LOGIC;  --system clock
		 reset_n    	: IN    STD_LOGIC;  --active low reinitializes lcd 
		 rw, rs, e  	: OUT   STD_LOGIC;  --read/write, setup/data, and enable for lcd
		 lcd_data   	: OUT   STD_LOGIC_VECTOR(7 DOWNTO 0); --data signals for lcd
		 line1_buffer 	: IN STD_LOGIC_VECTOR(127 downto 0); -- Data for the top line of the LCD
		 line2_buffer 	: IN STD_LOGIC_VECTOR(127 downto 0)); -- Data for the bottom line of the LCD
	END COMPONENT;
	
	component ir_counter is
		Port (
			clk					: in 	std_logic;
			btn					: in 	std_logic;
			reset_sayi			: in 	std_logic;
			birler_cikis 		: out 	std_logic_vector (7 downto 0);
			onlar_cikis			: out 	std_logic_vector (7 downto 0)
		);
	end component;
	-- These lines can be configured to be input from anything. 
	-- 8 bits per character
	signal top_line 	: std_logic_vector(127 downto 0) := x"00000000000000000000000000000000"; 
	signal bottom_line 	: std_logic_vector(127 downto 0) := x"00000000000000000000000000000000";  

	
	signal	onlar 	: std_logic_vector (7 downto 0) := x"00";
	signal  birler  : std_logic_vector (7 downto 0) := x"00";
	signal  yuzler  : std_logic_vector (7 downto 0) := x"20";
	signal  yazi 	: std_logic_vector (103 downto 0) := x"4F626A65207361796973693A20";   -- 4F626A65207361796973693A20 
begin




process (clk) begin
	if (rising_edge(clk)) then
		if (sw_i = '0')then
			top_line    	<=	yazi & yuzler & onlar & birler;
			bottom_line 	<=  x"536963616B6C696B2020203A20202020";   
		else
			top_line 		<=  x"4B61776169204665797A612020202020";
			bottom_line	 	<=  x"5961706162696C697273696E20696E61";			
		end if;
	end if;
	end process;

LCD: lcd_controller port map(
	clk => clk,
	reset_n => rst,
	e => lcd_e,
	rs => lcd_rs,
	rw => lcd_rw,
	lcd_data => lcd_db,
	line1_buffer => top_line,
	line2_buffer => bottom_line 
);

i_karoc_ircounter : ir_counter
	port map (
	clk				=> clk,
	btn				=> ir_giris,
	reset_sayi		=> reset_sayi,
	birler_cikis 	=> birler,
	onlar_cikis		=> onlar
	);
end Behavioral;