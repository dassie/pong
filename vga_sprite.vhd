library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_sprite is
	port (
			iCLK_50 : in std_logic;
			iKEY : in std_logic_vector (3 downto 0);
			iSW: in std_logic_vector(2 downto 0);
			
			oVGA_CLOCK :out std_logic;
			oVGA_SYNC_N :out std_logic;
			oVGA_BLANK_N :out std_logic;
			oVGA_HS, oVGA_VS :out std_logic;
			oVGA_R :out std_logic_vector(9 downto 0);
			oVGA_G :out std_logic_vector(9 downto 0);
			oVGA_B :out std_logic_vector(9 downto 0)
		 );
end entity vga_sprite;

architecture wvr of vga_sprite is
	signal px, py : unsigned(9 downto 0);
	signal pix_x, pix_y : std_logic_vector(9 downto 0);
	
	constant screen_width : integer := 640;
	constant screen_height : integer := 480;
	
	signal ball_clock : std_logic;
	signal sprite_addr : unsigned(7 downto 0);
	signal sprite_x, sprite_y : unsigned(9 downto 0) := "0011001000"; --200
	signal sprite_r, sprite_g, sprite_b : std_logic_vector(9 downto 0);
	signal sprite_on : std_logic;
	constant sprite_heigth : integer := 16;

	--direction flags
	signal forward : std_logic := '1';
	signal downward : std_logic := '1';
	
	signal pixel_clock : std_logic;
begin
	oVGA_CLOCK <= pixel_clock;
	VGA: work.vga_sync port map(
							clk50 => iCLK_50,
							reset => iKEY(0),
							hsync => oVGA_HS,
							vsync => oVGA_VS,
							video_on => oVGA_BLANK_N,
							p_tick => pixel_clock,
							pixel_x => pix_x,
							pixel_y => pix_y
						);
	px <= unsigned(pix_x);
	py <= unsigned(pix_y);
	
	SCLOCK: work.ball_clock port map(iCLK_50, ball_clock);
	SROM: work.char_rom port map(sprite_addr, sprite_r, sprite_g, sprite_b);
	
	process (ball_clock)
	begin
		if (Rising_Edge(ball_clock)) then
			--Computer horizontal position
			if (forward = '1') then
				if (sprite_x = screen_width) then
					forward <= '0';
					sprite_x <= sprite_x - 1;
				else
					sprite_x <= sprite_x + 1; 
				end if;
			else
				if (sprite_x = 0) then
					forward <= '1';
					sprite_x <= sprite_x + 1;
				else
					sprite_x <= sprite_x - 1;
				end if;
			end if;
			
			--computer vertical position
			if (downward = '1') then
				if (sprite_y = screen_height) then
					downward <= '0';
					sprite_y <= sprite_y - 1;
				else
					sprite_y <= sprite_y + 1;
				end if;
			else
				if (sprite_y = 0) then
					downward <= '1';
					sprite_y <= sprite_y + 1;
				else
					sprite_y <= sprite_y - 1;
				end if;
			end if;
		end if;
	end process;
	
	sprite_on <= '1' when
								(px >= sprite_x and px <= (sprite_x + sprite_heigth)) and
								(py >= sprite_y and py <= (sprite_y + sprite_heigth))
						  else '0';
	
	process (pixel_clock)
	begin
		if (Rising_edge(pixel_clock)) then
			if (sprite_on = '1') then	
				if (sprite_addr = "11111111") then
					sprite_addr <= "00000000";
				else
					sprite_addr <= sprite_addr + 1;
				end if;
			end if;
		end if;
	end process;
	
	
	process (sprite_on, px, py, iSW)
	begin
		if (sprite_on = '1') then	
			oVGA_R <= sprite_r;
			oVGA_G <= sprite_g;
			oVGA_B <= sprite_b;
		else
			if (iSW(2) = '1') then
				oVGA_R <= (others => '1');
			else
				oVGA_R <= (others => '0');
			end if;
			
			if (iSW(1) = '1') then
				oVGA_G <= (others => '1');
			else
				oVGA_G <= (others => '0');
			end if;
			
			if (iSW(0) = '1') then
				oVGA_B <= (others => '1');
			else
				oVGA_B <= (others => '0');
			end if;
		end if;
	end process;
	
	oVGA_SYNC_N <= '0';
end wvr;



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ball_clock is
	port (
			cin :in std_logic;
			cout :out std_logic
			);
end entity ball_clock;

architecture counter of ball_clock is
	signal clk : std_logic := '1';
begin
	process (cin)
		variable lim : integer range 0 to 310000;
	begin
		if (Rising_Edge(cin)) then
			if (lim = 310000) then
				lim := 0;
				clk <= not clk;
			else
				lim := lim + 1;
			end if;
		end if;
	end process;
	
	cout <= clk;
end architecture counter;
				



























