library ieee;
use ieee.std_logic_1164.all;
entity reflection_address_selector is
	port(guide:in std_logic_vector(7 downto 0);
		 CS:in std_logic; --chip select signal
		 W_address:out std_logic_vector(7 downto 0));
end reflection_address_selector;
architecture dataflow of reflection_address_selector is
signal WR_add:std_logic_vector(7 downto 0);
begin
	W_address<=WR_add when (CS='1') else (others=>'Z') ;
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
				"10110110" when "00001100",
				"10100110" when "00001101",
				"10010110" when "00001110",
				"10000110" when "00001111",
				"01110110" when "00010000",
				"01100100" when "00010001",
				"01010010" when "00010010",
				"01000000" when "00010011",
				"00101110" when "00010100",
				"00011100" when "00010101",
				"00001010" when "00010110",
				"00011010" when "00010111",
				"00101010" when "00011000",
				"00111010" when "00011001",
				"01001010" when "00011010",
				"01101010" when "00011011",
				"01111010" when "00011100",
				"10001010" when "00011101",
				"10011010" when "00011110",
				"10101010" when "00011111",
				"10111100" when "00100000",
				"10101100" when "00100001",
				"10011100" when "00100010",
				"10001100" when "00100011",
				"01111100" when "00100100",
				"01011100" when "00100101",
				"01001100" when "00100110",
				"00111100" when "00100111",
				"00101100" when "00101000",
				"00001100" when "00101001",
				"00011110" when "00101010",
				"00110000" when "00101011",
				"01000010" when "00101100",
				"01010100" when "00101101",
				"01110100" when "00101110",
				"10000100" when "00101111",
				"10010100" when "00110000",
				"10100100" when "00110001",
				"11000100" when "00110010",
				"10110010" when "00110011",
				"10100000" when "00110100",
				"10001110" when "00110101",
				"01011000" when "00110110",
				"01000110" when "00110111",
				"00110100" when "00111000",
				"00100010" when "00111001",
				"00000010" when "00111010",
				"00010100" when "00111011",
				"00100110" when "00111100",
				"00111000" when "00111101",
				"01101110" when "00111110",
				"10000000" when "00111111",
				"10010010" when "01000000",
				"11001000" when "01000001",
				"10111000" when "01000010",
				"10101000" when "01000011",
				"10011000" when "01000100",
				"01100010" when "01000101",
				"01010000" when "01000110",
				"00111110" when "01000111",
				"00001000" when "01001000",
				"00011000" when "01001001",
				"00101000" when "01001010",
				"01101000" when "01001011",
				"01111000" when "01001100",
				"10001000" when "01001101",
				"10111110" when "01001110",
				"10101110" when "01001111",
				"10011110" when "01010000",
				"01011110" when "01010001",
				"01001110" when "01010010",
				"00001110" when "01010011",
				"00100000" when "01010100",
				"00110010" when "01010101",
				"01110010" when "01010110",
				"10000010" when "01010111",
				"11000010" when "01011000",
				"10110000" when "01011001",
				"01010110" when "01011010",
				"01000100" when "01011011",
				"00000100" when "01011100",
				"00010110" when "01011101",
				"01110000" when "01011110",
				"11001010" when "01011111",
				"10111010" when "01100000",
				"01100000" when "01100001",
				"00000110" when "01100010",
				"01100110" when "01100011",
				"11000000" when "01100100",
				"00010000" when "01100101",
				"00010001" when "01100110",
				"00100011" when "01100111",
				"00110101" when "01101000",
				"01000111" when "01101001",
				"01011001" when "01101010",
				"01101011" when "01101011",
				"01111101" when "01101100",
				"10001111" when "01101101",
				"10100001" when "01101110",
				"10110011" when "01101111",
				"11000101" when "01110000",
				"10110101" when "01110001",
				"10100101" when "01110010",
				"10010101" when "01110011",
				"10000101" when "01110100",
				"01110101" when "01110101",
				"01100101" when "01110110",
				"01010011" when "01110111",
				"01000001" when "01111000",
				"00101111" when "01111001",
				"00011101" when "01111010",
				"00001011" when "01111011",
				"00011011" when "01111100",
				"00101011" when "01111101",
				"00111011" when "01111110",
				"01001011" when "01111111",
				"01011011" when "10000000",
				"01111011" when "10000001",
				"10001011" when "10000010",
				"10011011" when "10000011",
				"10101011" when "10000100",
				"10111011" when "10000101",
				"10111101" when "10000110",
				"10101101" when "10000111",
				"10011101" when "10001000",
				"10001101" when "10001001",
				"01101101" when "10001010",
				"01011101" when "10001011",
				"01001101" when "10001100",
				"00111101" when "10001101",
				"00101101" when "10001110",
				"00001101" when "10001111",
				"00011111" when "10010000",
				"00110001" when "10010001",
				"01000011" when "10010010",
				"01100011" when "10010011",
				"01110011" when "10010100",
				"10000011" when "10010101",
				"10010011" when "10010110",
				"10100011" when "10010111",
				"11000011" when "10011000",
				"10110001" when "10011001",
				"10011111" when "10011010",
				"01101001" when "10011011",
				"01010111" when "10011100",
				"01000101" when "10011101",
				"00110011" when "10011110",
				"00010011" when "10011111",
				"00000011" when "10100000",
				"00010101" when "10100001",
				"00100111" when "10100010",
				"00111001" when "10100011",
				"01101111" when "10100100",
				"10000001" when "10100101",
				"10110111" when "10100110",
				"11001001" when "10100111",
				"10111001" when "10101000",
				"10101001" when "10101001",
				"10010111" when "10101010",
				"01100001" when "10101011",
				"01001111" when "10101100",
				"00011001" when "10101101",
				"00000111" when "10101110",
				"00010111" when "10101111",
				"00110111" when "10110000",
				"01100111" when "10110001",
				"01110111" when "10110010",
				"10001001" when "10110011",
				"10111111" when "10110100",
				"10101111" when "10110101",
				"01111111" when "10110110",
				"01011111" when "10110111",
				"00111111" when "10111000",
				"00001111" when "10111001",
				"00100001" when "10111010",
				"01010001" when "10111011",
				"01110001" when "10111100",
				"10010001" when "10111101",
				"11000001" when "10111110",
				"01111001" when "10111111",
				"01010101" when "11000000",
				"00100101" when "11000001",
				"00000101" when "11000010",
				"00101001" when "11000011",
				"10100111" when "11000100",
				"11001011" when "11000101",
				"00000001" when "11000110",
				"01001001" when "11000111",
				"11000111" when "11001000",
				"10000111" when "11001001",
				"00001001" when "11001010",
				"10011001" when "11001011",
				"00000000" when others;
end dataflow;