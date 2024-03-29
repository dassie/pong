library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity char_rom is 
	port (
			addr :in unsigned(7 downto 0);
			
			r_out :out std_logic_vector(9 downto 0);
			g_out :out std_logic_vector(9 downto 0);
			b_out :out std_logic_vector(9 downto 0)
	);
end entity char_rom;

architecture mapping of char_rom is
	type color is array (0 to 2) of std_logic_vector(9 downto 0);
	constant yellow : color := ("1111111111", "1111111111", "0000000000");
	constant white : color := ("0000000000", "0000000000", "0000000000");

begin

	process (addr) 
	begin
		case addr is
when "00000000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00000001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00000010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00000011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00000100" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00000101" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00000110" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00000111" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00001000" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00001001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00001010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00001011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00001100" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00001101" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00001110" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00001111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00010000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00010001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00010010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00010011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00010100" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00010101" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00010110" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00010111" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00011000" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00011001" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00011010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00011011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00011100" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "00011101" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "00011110" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "00011111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00100000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00100001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00100010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00100011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00100100" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00100101" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00100110" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00100111" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00101000" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00101001" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00101010" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00101011" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00101100" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00101101" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "00101110" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "00101111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00110000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00110001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00110010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00110011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00110100" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "00110101" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "00110110" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "00110111" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "00111000" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "00111001" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00111010" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "00111011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "00111100" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00111101" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00111110" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "00111111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01000000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01000001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01000010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01000011" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "01000100" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01000101" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "01000110" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01000111" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01001000" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01001001" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01001010" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01001011" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01001100" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01001101" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01001110" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01001111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01010000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01010001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01010010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01010011" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "01010100" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01010101" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "01010110" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "01010111" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01011000" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01011001" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01011010" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01011011" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01011100" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01011101" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01011110" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01011111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01100000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01100001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01100010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01100011" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "01100100" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "01100101" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01100110" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01100111" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01101000" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01101001" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01101010" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01101011" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01101100" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01101101" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01101110" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01101111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01110000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01110001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01110010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01110011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01110100" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01110101" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01110110" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01110111" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01111000" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01111001" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01111010" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01111011" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "01111100" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01111101" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "01111110" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "01111111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "10000000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "10000001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "10000010" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10000011" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10000100" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10000101" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10000110" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10000111" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10001000" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10001001" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10001010" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10001011" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10001100" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10001101" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "10001110" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "10001111" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "10010000" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "10010001" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "10010010" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10010011" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10010100" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10010101" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10010110" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10010111" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10011000" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10011001" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10011010" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10011011" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10011100" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "10011101" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "10011110" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "10011111" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "10100000" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "10100001" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "10100010" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "10100011" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10100100" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10100101" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10100110" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10100111" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10101000" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10101001" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10101010" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10101011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "0000111111";
when "10101100" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10101101" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10101110" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "10101111" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "10110000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "10110001" =>
	r_out <= "0111111111";
	g_out <= "1100111111";
	b_out <= "1101111111";
when "10110010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "10110011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "10110100" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10110101" =>
	r_out <= "1111111111";
	g_out <= "0000111111";
	b_out <= "0000111111";
when "10110110" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10110111" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10111000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "0000111111";
when "10111001" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10111010" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10111011" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10111100" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10111101" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "10111110" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "10111111" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11000000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11000001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11000010" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11000011" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11000100" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11000101" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11000110" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11000111" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11001000" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11001001" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11001010" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11001011" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11001100" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11001101" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11001110" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11001111" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11010000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11010001" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11010010" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11010011" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11010100" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11010101" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11010110" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11010111" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11011000" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11011001" =>
	r_out <= "0000111111";
	g_out <= "0000111111";
	b_out <= "1111111111";
when "11011010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11011011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11011100" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11011101" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11011110" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11011111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11100000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11100001" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11100010" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11100011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11100100" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11100101" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11100110" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11100111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11101000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11101001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11101010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11101011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11101100" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11101101" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11101110" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11101111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11110000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11110001" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11110010" =>
	r_out <= "0100111111";
	g_out <= "0100111111";
	b_out <= "0000111111";
when "11110011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11110100" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11110101" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11110110" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11110111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11111000" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11111001" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11111010" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11111011" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11111100" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11111101" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11111110" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
when "11111111" =>
	r_out <= "1111111111";
	g_out <= "1111111111";
	b_out <= "1111111111";
		end case;
	end process;
	
	
--	r_out <= yellow(0);
--	g_out <= yellow(1);
--	b_out <= yellow(2);
end architecture mapping;















