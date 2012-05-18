library ieee;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all;

entity vga_sync is
	port (
				clk50 :in std_logic;
				reset :in std_logic;
				
				hsync :out std_logic;
				vsync :out std_logic;
				
				p_tick :out std_logic;
				video_on :out std_logic;
				
				pixel_x :out std_logic_vector(9 downto 0);
				pixel_y :out std_logic_vector(9 downto 0)
			);
end entity vga_sync;

--------------------------------------------------------------------------------

architecture wvr of vga_sync is
	constant HD :integer := 670;
	constant HF :integer := 16; --h. f r o n t p o r c h (D)
	constant HB :integer := 48; --h. b a c k p o r c h (B)
	constant HR :integer := 96; --h. r e t r a c e (A)
	
	constant VD :integer := 510; -- v e r t i c a l d i s p l a y a r e a (C)
	constant VF :integer := 10; -- v . f r o n t p o r c h (D)
	constant VB :integer := 33; -- v . b a c k p o r c h (B)
	constant VR :integer := 2; -- v . r e t r a c e (A)

	signal mod2_reg, mod2_next : std_logic;

	signal vcount_reg, vcount_next : unsigned(9 downto 0) ;
	signal hcount_reg, hcount_next : unsigned (9 downto 0) ;

	signal hsync_reg, hsync_next : std_logic;
	signal vsync_reg, vsync_next : std_logic;

	signal h_end, v_end, pixel_tick: std_logic;
begin

	process(pixel_tick, reset)
	begin 
		if (reset = '0') then
			vcount_reg <= (others => '0');
			hcount_reg <= (others => '0');
			
			vsync_reg <= '0';
			hsync_reg <= '0';
		elsif (Rising_Edge(pixel_tick)) then
			vcount_reg <= vcount_next;
			hcount_reg <= hcount_next;
			
			vsync_reg <= vsync_next;
			hsync_reg <= hsync_next;
		end if;
	end process;
	
	mod2_next <= not mod2_reg;
	mod2_reg <= mod2_next when (Rising_Edge(clk50));
	pixel_tick <= '1' when mod2_reg = '1' else '0';

	h_end <= '1' when hcount_reg = (HD + HF + HB + HR - 1) else '0';
	v_end <= '1' when vcount_reg = (VD + VF + VB + VR - 1) else '0';

	--horizontal sync signals
	process (hcount_reg, h_end, pixel_tick)
	begin
		if (pixel_tick = '1') then
			if (h_end = '1') then
				hcount_next <= (others => '0');
			else
				hcount_next <= hcount_reg + 1;
			end if;
		else
			hcount_next <= hcount_reg;
		end if;
	end process;

	--Vertical sync signals
	process (vcount_reg, h_end, v_end, pixel_tick)
	begin
		if (pixel_tick = '1' and h_end = '1') then
			if (v_end = '1') then
				vcount_next <= (others => '0');
			else
				vcount_next <= vcount_reg + 1;
			end if;
		else
			vcount_next <= vcount_reg;
		end if;
	end process;


	hsync_next <= '1' when (hcount_reg >= (HD + HF) ) and (hcount_reg <= (HD + HF + HR - 1)) else '0';
	vsync_next <= '1' when (vcount_reg >= (VD + VF)) and (vcount_reg <= (VD + VF + VR - 1)) else '0';
	video_on <= '1' when (hcount_reg < HD) and (vcount_reg < VD) else '0';


	hsync <= hsync_reg;
	vsync <= vsync_reg;
	pixel_x <= std_logic_vector(hcount_reg);
	pixel_y <= std_logic_vector(vcount_reg);
	p_tick <= pixel_tick;
end architecture wvr;









































