library ieee;
use ieee.std_logic_1164.all;
entity spiral_address_selector is
	port(guide:in std_logic_vector(7 downto 0);
		 CS:in std_logic; --chip select signal
		 W_address:out std_logic_vector(7 downto 0));
end spiral_address_selector;
architecture dataflow of spiral_address_selector is
signal WR_add:std_logic_vector(7 downto 0);
begin
	W_address<=WR_add when (CS='1') else (others=>'Z');
	with guide select
		WR_add<="00000000" when "00000000",
				"00010010" when "00000001",
				"00100100" when "00000010",
				"00110110" when "00000011",
				"01001000" when "00000100",
				"01011010" when "00000101",
				"01101100" when "00000110",
				"01111110" when "00000111",
				"10010000" when "00001000",
				"10100010" when "00001001",
				"10110100" when "00001010",
				"11000110" when "00001011",
				"00000001" when "00001100",
				"00010011" when "00001101",
				"00100101" when "00001110",
				"00110111" when "00001111",
				"01001001" when "00010000",
				"01011011" when "00010001",
				"01101101" when "00010010",
				"01111111" when "00010011",
				"10010001" when "00010100",
				"10100011" when "00010101",
				"10110101" when "00010110",
				"11000111" when "00010111",
				"00000010" when "00011000",
				"00010100" when "00011001",
				"00100110" when "00011010",
				"00111000" when "00011011",
				"01001010" when "00011100",
				"01011100" when "00011101",
				"01101110" when "00011110",
				"10000000" when "00011111",
				"10010010" when "00100000",
				"10100100" when "00100001",
				"10110110" when "00100010",
				"11001000" when "00100011",
				"00000011" when "00100100",
				"00010101" when "00100101",
				"00100111" when "00100110",
				"00111001" when "00100111",
				"01001011" when "00101000",
				"01011101" when "00101001",
				"01101111" when "00101010",
				"10000001" when "00101011",
				"10010011" when "00101100",
				"10100101" when "00101101",
				"10110111" when "00101110",
				"11001001" when "00101111",
				"00000100" when "00110000",
				"00010110" when "00110001",
				"00101000" when "00110010",
				"00111010" when "00110011",
				"01001100" when "00110100",
				"01011110" when "00110101",
				"01110000" when "00110110",
				"10000010" when "00110111",
				"10010100" when "00111000",
				"10100110" when "00111001",
				"10111000" when "00111010",
				"11001010" when "00111011",
				"00000101" when "00111100",
				"00010111" when "00111101",
				"00101001" when "00111110",
				"00111011" when "00111111",
				"01001101" when "01000000",
				"01011111" when "01000001",
				"01110001" when "01000010",
				"10000011" when "01000011",
				"10010101" when "01000100",
				"10100111" when "01000101",
				"10111001" when "01000110",
				"11001011" when "01000111",
				"00000110" when "01001000",
				"00011000" when "01001001",
				"00101010" when "01001010",
				"00111100" when "01001011",
				"01001110" when "01001100",
				"01100000" when "01001101",
				"01110010" when "01001110",
				"10000100" when "01001111",
				"10010110" when "01010000",
				"10101000" when "01010001",
				"10111010" when "01010010",
				"10111011" when "01010011",
				"00000111" when "01010100",
				"00011001" when "01010101",
				"00101011" when "01010110",
				"00111101" when "01010111",
				"01001111" when "01011000",
				"01100001" when "01011001",
				"01110011" when "01011010",
				"10000101" when "01011011",
				"10010111" when "01011100",
				"10101001" when "01011101",
				"10101010" when "01011110",
				"10111100" when "01011111",
				"00001000" when "01100000",
				"00011010" when "01100001",
				"00101100" when "01100010",
				"00111110" when "01100011",
				"01010000" when "01100100",
				"01100010" when "01100101",
				"01110100" when "01100110",
				"10000110" when "01100111",
				"10011000" when "01101000",
				"10011001" when "01101001",
				"10101011" when "01101010",
				"10111101" when "01101011",
				"00001001" when "01101100",
				"00011011" when "01101101",
				"00101101" when "01101110",
				"00111111" when "01101111",
				"01010001" when "01110000",
				"01100011" when "01110001",
				"01110101" when "01110010",
				"10000111" when "01110011",
				"10001000" when "01110100",
				"10011010" when "01110101",
				"10101100" when "01110110",
				"10111110" when "01110111",
				"00001010" when "01111000",
				"00011100" when "01111001",
				"00101110" when "01111010",
				"01000000" when "01111011",
				"01010010" when "01111100",
				"01100100" when "01111101",
				"01110110" when "01111110",
				"01110111" when "01111111",
				"10001001" when "10000000",
				"10011011" when "10000001",
				"10101101" when "10000010",
				"10111111" when "10000011",
				"00001011" when "10000100",
				"00011101" when "10000101",
				"00101111" when "10000110",
				"01000001" when "10000111",
				"01010011" when "10001000",
				"01100101" when "10001001",
				"01100110" when "10001010",
				"01111000" when "10001011",
				"10001010" when "10001100",
				"10011100" when "10001101",
				"10101110" when "10001110",
				"11000000" when "10001111",
				"00001100" when "10010000",
				"00011110" when "10010001",
				"00110000" when "10010010",
				"01000010" when "10010011",
				"01010100" when "10010100",
				"01010101" when "10010101",
				"01100111" when "10010110",
				"01111001" when "10010111",
				"10001011" when "10011000",
				"10011101" when "10011001",
				"10101111" when "10011010",
				"11000001" when "10011011",
				"00001101" when "10011100",
				"00011111" when "10011101",
				"00110001" when "10011110",
				"01000011" when "10011111",
				"01000100" when "10100000",
				"01010110" when "10100001",
				"01101000" when "10100010",
				"01111010" when "10100011",
				"10001100" when "10100100",
				"10011110" when "10100101",
				"10110000" when "10100110",
				"11000010" when "10100111",
				"00001110" when "10101000",
				"00100000" when "10101001",
				"00110010" when "10101010",
				"00110011" when "10101011",
				"01000101" when "10101100",
				"01010111" when "10101101",
				"01101001" when "10101110",
				"01111011" when "10101111",
				"10001101" when "10110000",
				"10011111" when "10110001",
				"10110001" when "10110010",
				"11000011" when "10110011",
				"00001111" when "10110100",
				"00100001" when "10110101",
				"00100010" when "10110110",
				"00110100" when "10110111",
				"01000110" when "10111000",
				"01011000" when "10111001",
				"01101010" when "10111010",
				"01111100" when "10111011",
				"10001110" when "10111100",
				"10100000" when "10111101",
				"10110010" when "10111110",
				"11000100" when "10111111",
				"00010000" when "11000000",
				"00010001" when "11000001",
				"00100011" when "11000010",
				"00110101" when "11000011",
				"01000111" when "11000100",
				"01011001" when "11000101",
				"01101011" when "11000110",
				"01111101" when "11000111",
				"10001111" when "11001000",
				"10100001" when "11001001",
				"10110011" when "11001010",
				"11000101" when "11001011",
				"00000000" when others;
end dataflow;