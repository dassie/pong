library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pong is
	port (
			iCLK_50 : in std_logic;
			iKEY : in std_logic_vector (3 downto 0);
			iSW: in std_logic_vector(17 downto 0);
			
			oVGA_CLOCK :out std_logic;
			oVGA_SYNC_N :out std_logic;
			oVGA_BLANK_N :out std_logic;
			oVGA_HS, oVGA_VS :out std_logic;
			oVGA_R :out std_logic_vector(9 downto 0);
			oVGA_G :out std_logic_vector(9 downto 0);
			oVGA_B :out std_logic_vector(9 downto 0)
		 );
end entity pong;

architecture wvr of pong is
	type state is (pause, playing);
	signal game_state, next_state : state := playing;
	
	signal px, py : unsigned(9	downto 0);
	signal pix_x, pix_y : std_logic_vector(9 downto 0);
	
	constant screen_width : integer := 640;
	constant screen_height : integer := 500;
	
	--Signals for wall dimensions
	constant WALL_X : integer := 0;
	constant WALL_WIDTH : integer := 15;
	constant WALL_R : std_logic_vector(9 downto 0) := "1101110011";
	constant WALL_G : std_logic_vector(9 downto 0) := "0001010011";
	constant WALL_B : std_logic_vector(9 downto 0) := "0011110000";
	signal wall_on : std_logic;
	
	--A horizontal bar to separate the text messages from the rest of the screen
	signal bar_on : std_logic;
	constant H_H : integer := 5;
	
	--Signals for the ball
	signal ball_x : unsigned(9 downto 0) := "1010000000"; --320
	signal ball_y : unsigned(9 downto 0) := "0011110000"; --240
	constant BALL_WIDTH : integer := 17;
	constant BALL_R : std_logic_vector(9 downto 0) := "0000000000";
	constant BALL_G : std_logic_vector(9 downto 0) := "1000000000";
	constant BALL_B : std_logic_vector(9 downto 0) := "0000000000";
	signal ball_clock : std_logic;
	signal ball_on : std_logic;
	signal forward : std_logic := '1';
	signal downward : std_logic := '1';
	
	--Signals for the paddle
	signal paddle_x : unsigned(9 downto 0) := "1001101100"; --600
	signal paddle_y : unsigned(9 downto 0) := "0011010111"; --215
	constant PADDLE_WIDTH : integer := 8;
	constant PADDLE_HEIGHT : integer := 60;
	constant PADDLE_R : std_logic_vector(9 downto 0) := "1111111111"; --255
	constant PADDLE_G : std_logic_vector(9 downto 0) := "0100010111"; --69
	constant PADDLE_B : std_logic_vector(9 downto 0) := "0000000011"; --0
	signal paddle_on : std_logic := '1';
	signal paddle_clock : std_logic;
	signal paddle_speed : std_logic_vector(3 downto 0);
	
	--Signals for the score and lives text message
	signal bit_addr, bit_addr_s : std_logic_vector(2 downto 0);
	signal row_addr, row_addr_s : std_logic_vector(3 downto 0);
	signal char_addr, char_addr_s : std_logic_vector(6 downto 0);
	signal rom_addr : std_logic_vector(10 downto 0);
	signal font_word : std_logic_vector(7 downto 0);
	signal font_bit : std_logic;
	signal score_on :std_logic;
	signal text_bit_on : std_logic;
	signal heart_char_on : std_logic;
	signal vga_on : std_logic;
	
	--Signals for computing the score
	signal score_inc, score_clr : std_logic;
	signal dig1, dig2 : std_logic_vector(3 downto 0);
	signal dig1_u, dig2_u : unsigned(3 downto 0) := "0000";
	--Pause signal
	signal pause_h : std_logic := '0';

	signal pixel_clock : std_logic;
begin
	--The VGA sync generator
	oVGA_CLOCK <= pixel_clock;
	oVGA_SYNC_N <= '0';
	VGA: work.vga_sync port map(
							clk50 => iCLK_50,
							reset => iKEY(1),
							hsync => oVGA_HS,
							vsync => oVGA_VS,
							video_on => oVGA_BLANK_N,
							p_tick => pixel_clock,
							pixel_x => pix_x,
							pixel_y => pix_y
						);
	px <= unsigned(pix_x);
	py <= unsigned(pix_y);
	
	--Create clocks for the paddle and the ball
	BCLOCK: work.ball_clock port map(iCLK_50, ball_clock, iSW(17 downto 14));
	PCLOCK: work.ball_clock port map(iCLK_50, paddle_clock, paddle_speed);
	
	--Create a font rom
	font_unit: work.font_rom port map(clk => iCLK_50, addr => rom_addr, data => font_word);
	
	--A score counter
	--SCORE: work.score_counter port map(clk => iCLK_50, reset => '0', inc => score_inc, clr => score_clr, dig1 => dig1, dig2 => dig2);
	dig1 <= std_logic_vector(dig1_u);
	dig2 <= std_logic_vector(dig2_u);
	
	--Compute the ON signals for all objects
	bar_on <= '1' when (py >= 32 and py <= 37) else '0';
	wall_on <= '1' when (px >= WALL_X and px <= WALL_X + WALL_WIDTH) and (py > 37) else '0';
	ball_on <= '1' when 
							  (px >= ball_x and px <= (ball_x + BALL_WIDTH)) and
							  (py >= ball_y and py <= (ball_y + BALL_WIDTH))
						else '0';
	paddle_on <= '1' when
								(px >= paddle_x and px <= (paddle_x + PADDLE_WIDTH)) and
								(py >= paddle_y and py <= (paddle_y + PADDLE_HEIGHT))
							else '0';
	score_on <= '1' when py < 32 and px < 512 else '0';
	heart_char_on <= '1' when 
									pix_x(8 downto 4) = "10001" or
									pix_x(8 downto 4) = "10010" or
									pix_x(8 downto 4) = "10011"
								else
									'0';
	
	--Service pause signal
	pause_h <= '1' when iSW(17) = '1' else '0';

	--Form ROM address and font bit
	rom_addr <= char_addr & row_addr;
	font_bit <= font_word(to_integer(unsigned(not bit_addr)));	
	
	--Computations for displaying the text message at the top
	row_addr_s <= std_logic_vector(py(4 downto 1));
	bit_addr_s <= std_logic_vector(px(3 downto 1));
	text_bit_on <= font_bit when pix_x(9) = '0' and pix_y(9 downto 6) = "0000" else '0';
	with pix_x(8 downto 4) select
		char_addr_s <= 
			"1010011" when "00000", --S
			"1100011" when "00001", --c
			"1101111" when "00010", --o
			"1110010" when "00011", --r
			"1100101" when "00100", --e
			"0101000" when "00101", --(
			"011"&dig1 when "00110", --digit 1
			"011"&dig2 when "00111", --digit 2
			"0101001" when "01000", --)
			"0000000" when "01001", --space
			"0000000" when "01010", --space
			"1001100" when "01011", --L
			"1101001" when "01100", --i
			"1110110" when "01101", --v
			"1100101" when "01110", --e
			"1110011" when "01111", --s
			"0101000" when "10000", --(
			"0000011" when "10001", --heart
			"0000011" when "10010", --heart
			"0000011" when "10011", --heart
			"0101001" when "10100", --)
			"0000000" when "10101", --space
			"0000000" when "10110", --space
			"1010000" when "10111", --P
			"1000001" when "11000", --A
			"1010101" when "11001", --U
			"1010011" when "11010", --S
			"1000101" when "11011", --E
			"0000000" when others;
	
	--Moving the paddle
	process (paddle_clock)
	begin
		if (Rising_Edge(paddle_clock) and pause_h = '0') then
			if (iSW(0) = '1') then
				if (paddle_y /= 37) then
					paddle_y <= paddle_y - 1;
				else
					paddle_y <= paddle_y;
				end if;
			elsif (iSW(1) = '1') then
				if ((paddle_y + PADDLE_HEIGHT) /= screen_height) then
					paddle_y <= paddle_y + 1;
				else
					paddle_y <= paddle_y;
				end if;
			end if;
		end if;
	end process;
	
	--Moving the ball/collision detection
	process (ball_clock)
	begin
		if (Rising_Edge(ball_clock) and pause_h = '0') then
			if (((ball_x + BALL_WIDTH) = paddle_x) and 
			   (((ball_y + BALL_WIDTH) >= paddle_y) or (ball_y >= paddle_y)) and 
			   ((ball_y + BALL_WIDTH) <= (paddle_y + PADDLE_HEIGHT) or (ball_y <= (paddle_y + PADDLE_HEIGHT)))) then
				
				if (dig2_u = "1001") then
					dig2_u <= "0000";
					if (dig1_u = "1001") then
						dig1_u <= "0000";
					else
						dig1_u <= dig1_u + 1;
					end if;
				else
					dig2_u <= dig2_u + 1;
				end if;
				
				forward <= '0';
				ball_x <= ball_x - 1;
				
				if (downward = '1') then
					downward <= '0';
					ball_y <= ball_y - 1;
				else
					ball_y <= ball_y + 1;
				end if;
			else
				score_inc <= '0';
				
				if (forward = '1') then
					if (ball_x = screen_width) then
						ball_x <= "0101000000";
						ball_y <= "0011110000";
						downward <= '1';
					else
						ball_x <= ball_x + 1;
					end if;
				else
					if (ball_x = WALL_X + WALL_WIDTH) then
						forward <= '1';
						ball_x <= ball_x + 1;
					else
						ball_x <= ball_x - 1;
					end if;
				end if;
				
				if (downward = '1') then
					if (ball_y = screen_height) then
						downward <= '0';
						ball_y <= ball_y - 1;
					else
						ball_y <= ball_y + 1;
					end if;
				else
					if (ball_y = 37) then
						downward <= '1';
						ball_y <= ball_y + 1;
					else
						ball_y <= ball_y - 1;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	
	--Display all objects
	process (score_on, wall_on, ball_on, px, py, iSW, char_addr_s, row_addr_s, bit_addr_s, text_bit_on)
	begin
		if (score_on = '1') then
			char_addr <= char_addr_s;
			row_addr <= row_addr_s;
			bit_addr <= bit_addr_s;
			if (text_bit_on = '1') then
				if (px <= 352) then
					if (heart_char_on = '1') then
						oVGA_R <= "1111111111";
					else
						oVGA_R <= "0000000000";
					end if;
					oVGA_G <= "0000000000";
					oVGA_B <= "0000000000";
				else
					if (pause_h = '1') then
						oVGA_R <= "0000000000";
						oVGA_G <= "0000000000";
						oVGA_B <= "0000000000";
					else
						oVGA_R <= "1111111111";
						oVGA_G <= "1111111111";
						oVGA_B <= "1111111111";
					end if;
				end if;
			else
				oVGA_R <= "1111111111";
				oVGA_G <= "1111111111";
				oVGA_B <= "1111111111";	
			end if;
		elsif (bar_on = '1' or wall_on = '1') then
			oVGA_R <= WALL_R;
			oVGA_G <= WALL_G;
			oVGA_B <= WALL_B;
		elsif (ball_on = '1') then
			oVGA_R <= BALL_R;
			oVGA_G <= BALL_G;
			oVGA_B <= BALL_B;
		elsif (paddle_on = '1') then
			oVGA_R <= PADDLE_R;
			oVGA_G <= PADDLE_G;
			oVGA_B <= PADDLE_B;
		else
			if (iSW(5) = '1') then
				oVGA_R <= (others => '1');
			else
				oVGA_R <= (others => '0');
			end if;
			
			if (iSW(4) = '1') then
				oVGA_G <= (others => '1');
			else
				oVGA_G <= (others => '0');
			end if;
			
			if (iSW(3) = '1') then
				oVGA_B <= (others => '1');
			else
				oVGA_B <= (others => '0');
			end if;
		end if;
	end process;
end wvr;



library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity ball_clock is
	port (
			cin :in std_logic;
			cout :out std_logic;
			
			speed : in std_logic_vector(3 downto 0)
			);
end entity ball_clock;

architecture counter of ball_clock is
	signal clk : std_logic := '1';
begin
	
	process (cin)
		variable mu : integer range 0 to 4;
		variable lim : integer range 0 to 999999999;
	begin
		--mu := 310000 * (conv_integer(speed) + 1);
		
		if (Rising_Edge(cin)) then
			if (lim >= 100000) then
				lim := 0;
				clk <= not clk;
			else
				lim := lim + 1;
			end if;
		end if;
	end process;
	
	cout <= clk;
end architecture counter;
				


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity score_counter is
	port (
				clk :in std_logic;
				reset :in std_logic;
				inc	:in std_logic;
				clr	:in std_logic;
				
				dig1	:out std_logic_vector(3 downto 0);
				dig2	:out std_logic_vector(3 downto 0)
			);
end entity score_counter;

architecture wvr of score_counter is 
	signal dig1_reg, dig1_next : unsigned(3 downto 0);
	signal dig2_reg, dig2_next : unsigned(3 downto 0);
begin
	
	dig1 <= std_logic_vector(dig1_reg);
	dig2 <= std_logic_vector(dig2_reg);
	process (clk, reset)
	begin
		if (reset = '1') then
			dig1_reg <= "0000";
			dig2_reg <= "0000";
		elsif (Rising_Edge(clk)) then
			dig1_reg <= dig1_next;
			dig2_reg <= dig2_next;
		end if;
	end process;

	process(clr, inc, dig1_reg, dig2_reg)
	begin
		dig1_next <= dig1_reg;
		dig2_next <= dig2_reg;
		
		if (clr = '1') then
			dig1_next <= "0000";
			dig2_next <= "0000";
		elsif (inc = '1') then
			if (dig1_reg = 9) then
				dig1_next <= "0000";
				if (dig2_reg = 9) then
					dig2_next <= "0000";
				else
					dig2_next <= dig2_reg + 1;
				end if;
			else
				dig1_next <= dig1_reg + 1;
			end if;
		end if;
	end process;
end architecture wvr;






















