parameter N_features = 21,
parameter feature_bits = 5,
parameter weightWidth = 6,
parameter  biasWidth= 6,
parameter  inputWidth= 4,
parameter [weightWidth*N_features-1: 0] weights[0 : 2]= {126'b110001001110111010001101111110111111101011101111000110110011111010111110111111111010001000111001010001000111010101101101111101, 126'b000011011110111000001010000101000001101010110110000100111001000001000010111110110100111100000011000101101011111111110001111111, 126'b111001000100111000111110111011111010110101110001111110110111111111000001000011000010001010111111000101010010000110110011000001 },
parameter [weightWidth-1 : 0] bias[0 : 2]= {6'b000101, 6'b010101, 6'b000010 }
