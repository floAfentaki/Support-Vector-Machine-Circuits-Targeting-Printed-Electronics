parameter N_features = 17,
parameter feature_bits = 5,
parameter weightWidth = 8,
parameter  biasWidth= 8,
parameter  inputWidth= 4,
parameter [weightWidth*N_features-1: 0] weights[0 : 44]= {136'b0000100100001011000011100000100011110101000000011101101011110011111000111110110111111101111011111111101100000011000010101111101000001011, 136'b0000011100010011000000111111101011100000110100100001001100010111111001001111110100011110001110001111111011111001111100100000110111101101, 136'b1111111100011110111010100000011011110000111101011110111111110101111111100000010000001011000001100000011100000100000100001111110100010010, 136'b1111110011111010111000011111110011111110111111000000000000001010111111110000010100010110111101110001110000001101000100010001011100011110, 136'b0000100100010110110000100000000011101111111001001111000000010010000100100001011011100111000011010000110100101101000111011111101011111001, 136'b0000000000000110111000110000011111111110000001101110111111111110111100101111110100001100111110001111110100000100000110111111010100101101, 136'b0000001100001011111110100000001111111010111110101111100011111110111101101111011100000101111110110000110011111110000100110000011100001111, 136'b0000000100010000111101000000011011110100111101101111110111111000000001010000011100000111000001110000011100000011000011111111011000010001, 136'b0000000100001101111111010000011011110001111110101110111011111111111101001111101011111111111111110000100000000110000101110000000000101100, 136'b0000000011100001111101001111111000000011000000100000000000010000111010010000111011101111110100101111001011101000111100010001100010100110, 136'b0000000011110101000100101111111100000110111110110000001100001011111100010000010000000101000000000000110011110111111111010000101010111010, 136'b0000000000010011110100010001110011010011000101010000010111100000000111111111110111110011000000000000000000001101110110100000000110110010, 136'b1111110011101110111101011111000000000101000011110001000100010111000100110000010000010001111110000001001011100111111101000000110011101010, 136'b0000000111110010111100101111101111110111111110001111110000100000111110110000001111100000111001110000010111100101111110100001100110100001, 136'b1111111000000011110101100000001011111111000011110010001100000110000101000000010111111011111010101110010011111001111011010000100000000010, 136'b0000000000000000111011010001101111000101111011000010111111111001000001011111111111011100111111000010001111100010001010100001101011111000, 136'b0000000111111001111010100011110011010001110011110010111011001011000100110100001011011101111110010001101111111001000111001110011000000000, 136'b1111111111110101000000110000000100001110000000010000000000000101111101111111110111111000111100101111010011110011111011010001100111110111, 136'b0000000111110000000001011111111000001100000001110000000000001001111100111111010000000001111110111111111100000000111011010001010011011001, 136'b1111111000010101111001000000010000001100000001000001000111111010111111001110001100001110111110101111111100000101110010000001101111000100, 136'b1111111111110000111111011111110000000011000011011111111000001011111111101111111000000100111110010000010011110111111101100001101111111011, 136'b0000000011111010111110010000000100000111000000100000000100000011111111010000001011111100111101011111010011111011111010100001111111101011, 136'b0000000111110100111101100000100000001001000100010000100000001111000000001111100011111000111011001110111111111000111100010001000100000011, 136'b0000010100000011111111011111111100000001111111110000100111111100111111101111011011111100111110001111101111101110111101000010000111111111, 136'b1111111011011110111100111111110000100011000111111111011000001001110110000000101111101001111100001111110000000111111010101111101011101101, 136'b0000000111111010000101001111101100010000000000001111101000001001111100010001000000001000000010000000000011111100111011001111101111010001, 136'b1111110100000110110110100001101000001011000010100000100111110011111101110000001100010000000100001111100100001010110001001111001011010100, 136'b1111111111101110111110101111110111111110000100100000010000001011000011010000110100010000111111110000000011111010111100000000000011111111, 136'b1111111011100100000001111101110100000100001010111101010000100010111010100010000000000100000000101110111100001101111001101111000111100011, 136'b0000000011110010111011010000001100000000000100100001000100000001000011100000101011111001111111111110010100001100111001011111010000000010, 136'b0000001111101001010000000000100000000000111110001101111011111110110110010000001111100011111101000001001011101000000100000000100111011100, 136'b0000000111111110000100110000000000001010111110001111110000000000111110000000000000000100000001110000101011111110111110100000000111011000, 136'b1111100100010000000110001111110100000111111100111101010011110101111100101111011100010011000011110000111111111111111110111111111011011011, 136'b0000001011110111111110010000011011101101000010001111101011111100000110010000011100100101000000110010010100001001111111100001011011101001, 136'b0000000011111110000011101111110111110110111101111110000000000011000010010000011111101101000011100010001011110000000011110001101110110101, 136'b0000000111110011001110110001000000111001000010101111110111100101110010111110010111100100111010001110110011101011111011001111111100000101, 136'b1111111111110100001110011111011111100110111111010001111100001001110100111111000000101000000100100010001111010001111100110010001111001011, 136'b0000000100101101111100110000100111011010111111010001011011100101000000011110101100011011000100010001110011100110111111011110111000110010, 136'b1111111011111010111101001110111011111010000011100001000100010101000100000000100100111110000010010001110111110110111011110001001100010101, 136'b0000001000000111000011110000011000001010111111001111010011110011111010111111000111100101000000001111001011111101000001111111110111111101, 136'b0000100000001101000011010000100000010010111011001111001011110010111110001111011111110100000011001111101100000100111010111110101111100011, 136'b1111110000011001111111000000100000000101111010000000001011101100111111010000001111111011000001101111010100000010111111011111101111110010, 136'b0000000111010100000100110000000000010111111100100000101100011000111010110000011011101011111100110000010111110111000011010000100011110011, 136'b0000001111011011000111111111111100011001000010101111111100000100111101100000001011101101000000000001001111111010111110010001000111000001, 136'b1111111100000100111001111111101100001010000011011110111111101100111111111111001011101101111110111110011111111111111110111111010100101101 },
parameter [weightWidth-1 : 0] bias[0 : 44]= {8'b00101111, 8'b11111000, 8'b00001011, 8'b11111000, 8'b00000010, 8'b00010001, 8'b00001001, 8'b00000011, 8'b00000011, 8'b01001101, 8'b00000011, 8'b01000010, 8'b00000010, 8'b00111111, 8'b00010100, 8'b00101111, 8'b00110110, 8'b00000010, 8'b11111011, 8'b00000001, 8'b11111101, 8'b11111110, 8'b11111110, 8'b00000000, 8'b00011000, 8'b11110001, 8'b00000110, 8'b11110111, 8'b00000110, 8'b11111111, 8'b00011011, 8'b11110110, 8'b00001010, 8'b11101111, 8'b00000010, 8'b00001100, 8'b11111101, 8'b00010000, 8'b11101000, 8'b00001110, 8'b00000100, 8'b00001000, 8'b11110101, 8'b11110000, 8'b00101101 }