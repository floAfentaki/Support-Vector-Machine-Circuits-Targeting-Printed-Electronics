module SVM_PICKER_10_CLASS#(
	`include "./hdl/params.vh"
)(
	input w_class,
	output reg ready,
	input clk,
	input rst_n,
	input svmready,
	output reg signed[weightWidth*N_features-1:0] weight,
	output reg signed [biasWidth-1:0] bia,
	output reg [3:0] winner
);
parameter[5:0] S01= 64'b000000, S02= 64'b000001, S03= 64'b000010, S04= 64'b000011, S05= 64'b000100, S06= 64'b000101, S07= 64'b000110, S08= 64'b000111, S09= 64'b001000, S12= 64'b001001, S13= 64'b001010, S14= 64'b001011, S15= 64'b001100, S16= 64'b001101, S17= 64'b001110, S18= 64'b001111, S19= 64'b010000, S23= 64'b010001, S24= 64'b010010, S25= 64'b010011, S26= 64'b010100, S27= 64'b010101, S28= 64'b010110, S29= 64'b010111, S34= 64'b011000, S35= 64'b011001, S36= 64'b011010, S37= 64'b011011, S38= 64'b011100, S39= 64'b011101, S45= 64'b011110, S46= 64'b011111, S47= 64'b100000, S48= 64'b100001, S49= 64'b100010, S56= 64'b100011, S57= 64'b100100, S58= 64'b100101, S59= 64'b100110, S67= 64'b100111, S68= 64'b101000, S69= 64'b101001, S78= 64'b101010, S79= 64'b101011, S89= 64'b101100, SFINAL = 64'b101101 ;
reg[5:0] next;
reg[5:0] state;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
    state<=S09;
     end
    else state <= next; 
end

always@(posedge clk or negedge rst_n)begin
	if (!rst_n) begin
		winner<=16'b00000;
		ready<=1'b0;
	end else begin
	if(state==S01 && w_class==0 && svmready == 1)begin
		winner<=16'b0000;
		ready <= 1'b1;
	end
	else if(state==S01 && w_class==1 && svmready == 1)begin
		winner<=16'b0001;
		ready <= 1'b1;
	end
	else if(state==S12 && w_class==0 && svmready == 1)begin
		winner<=16'b0001;
		ready <= 1'b1;
	end
	else if(state==S12 && w_class==1 && svmready == 1)begin
		winner<=16'b0010;
		ready <= 1'b1;
	end
	else if(state==S23 && w_class==0 && svmready == 1)begin
		winner<=16'b0010;
		ready <= 1'b1;
	end
	else if(state==S23 && w_class==1 && svmready == 1)begin
		winner<=16'b0011;
		ready <= 1'b1;
	end
	else if(state==S34 && w_class==0 && svmready == 1)begin
		winner<=16'b0011;
		ready <= 1'b1;
	end
	else if(state==S34 && w_class==1 && svmready == 1)begin
		winner<=16'b0100;
		ready <= 1'b1;
	end
	else if(state==S45 && w_class==0 && svmready == 1)begin
		winner<=16'b0100;
		ready <= 1'b1;
	end
	else if(state==S45 && w_class==1 && svmready == 1)begin
		winner<=16'b0101;
		ready <= 1'b1;
	end
	else if(state==S56 && w_class==0 && svmready == 1)begin
		winner<=16'b0101;
		ready <= 1'b1;
	end
	else if(state==S56 && w_class==1 && svmready == 1)begin
		winner<=16'b0110;
		ready <= 1'b1;
	end
	else if(state==S67 && w_class==0 && svmready == 1)begin
		winner<=16'b0110;
		ready <= 1'b1;
	end
	else if(state==S67 && w_class==1 && svmready == 1)begin
		winner<=16'b0111;
		ready <= 1'b1;
	end
	else if(state==S78 && w_class==0 && svmready == 1)begin
		winner<=16'b0111;
		ready <= 1'b1;
	end
	else if(state==S78 && w_class==1 && svmready == 1)begin
		winner<=16'b1000;
		ready <= 1'b1;
	end
	else if(state==S89 && w_class==0 && svmready == 1)begin
		winner<=16'b1000;
		ready <= 1'b1;
	end
	else if(state==S89 && w_class==1 && svmready == 1)begin
		winner<=16'b1001;
		ready <= 1'b1;
	end
	else begin 
		winner<=16'b00000;
		ready <= 1'b0;
	end
end
end

always@*begin
	next=state;
	weight <= weights[0];
	bia <= bias[0];

	case(state)
    S09:begin
    weight<=weights[0];
    bia<=bias[0];
    if(w_class==0 && svmready) next=S08;
    else if(w_class==1 && svmready == 1)next=S19;
    end
    S08:begin
    weight<=weights[1];
    bia<=bias[1];
    if(w_class==0 && svmready) next=S07;
    else if(w_class==1 && svmready == 1)next=S18;
    end
    S07:begin
    weight<=weights[2];
    bia<=bias[2];
    if(w_class==0 && svmready) next=S06;
    else if(w_class==1 && svmready == 1)next=S17;
    end
    S06:begin
    weight<=weights[3];
    bia<=bias[3];
    if(w_class==0 && svmready) next=S05;
    else if(w_class==1 && svmready == 1)next=S16;
    end
    S05:begin
    weight<=weights[4];
    bia<=bias[4];
    if(w_class==0 && svmready) next=S04;
    else if(w_class==1 && svmready == 1)next=S15;
    end
    S04:begin
    weight<=weights[5];
    bia<=bias[5];
    if(w_class==0 && svmready) next=S03;
    else if(w_class==1 && svmready == 1)next=S14;
    end
    S03:begin
    weight<=weights[6];
    bia<=bias[6];
    if(w_class==0 && svmready) next=S02;
    else if(w_class==1 && svmready == 1)next=S13;
    end
    S02:begin
    weight<=weights[7];
    bia<=bias[7];
    if(w_class==0 && svmready) next=S01;
    else if(w_class==1 && svmready == 1)next=S12;
    end
    S01:begin
    weight<=weights[8];
    bia<=bias[8];
    if(svmready) next=SFINAL;
  end
    S19:begin
    weight<=weights[9];
    bia<=bias[9];
    if(w_class==0 && svmready) next=S18;
    else if(w_class==1 && svmready == 1)next=S29;
    end
    S18:begin
    weight<=weights[10];
    bia<=bias[10];
    if(w_class==0 && svmready) next=S17;
    else if(w_class==1 && svmready == 1)next=S28;
    end
    S17:begin
    weight<=weights[11];
    bia<=bias[11];
    if(w_class==0 && svmready) next=S16;
    else if(w_class==1 && svmready == 1)next=S27;
    end
    S16:begin
    weight<=weights[12];
    bia<=bias[12];
    if(w_class==0 && svmready) next=S15;
    else if(w_class==1 && svmready == 1)next=S26;
    end
    S15:begin
    weight<=weights[13];
    bia<=bias[13];
    if(w_class==0 && svmready) next=S14;
    else if(w_class==1 && svmready == 1)next=S25;
    end
    S14:begin
    weight<=weights[14];
    bia<=bias[14];
    if(w_class==0 && svmready) next=S13;
    else if(w_class==1 && svmready == 1)next=S24;
    end
    S13:begin
    weight<=weights[15];
    bia<=bias[15];
    if(w_class==0 && svmready) next=S12;
    else if(w_class==1 && svmready == 1)next=S23;
    end
    S12:begin
    weight<=weights[16];
    bia<=bias[16];
    if(svmready) next=SFINAL;
  end
    S29:begin
    weight<=weights[17];
    bia<=bias[17];
    if(w_class==0 && svmready) next=S28;
    else if(w_class==1 && svmready == 1)next=S39;
    end
    S28:begin
    weight<=weights[18];
    bia<=bias[18];
    if(w_class==0 && svmready) next=S27;
    else if(w_class==1 && svmready == 1)next=S38;
    end
    S27:begin
    weight<=weights[19];
    bia<=bias[19];
    if(w_class==0 && svmready) next=S26;
    else if(w_class==1 && svmready == 1)next=S37;
    end
    S26:begin
    weight<=weights[20];
    bia<=bias[20];
    if(w_class==0 && svmready) next=S25;
    else if(w_class==1 && svmready == 1)next=S36;
    end
    S25:begin
    weight<=weights[21];
    bia<=bias[21];
    if(w_class==0 && svmready) next=S24;
    else if(w_class==1 && svmready == 1)next=S35;
    end
    S24:begin
    weight<=weights[22];
    bia<=bias[22];
    if(w_class==0 && svmready) next=S23;
    else if(w_class==1 && svmready == 1)next=S34;
    end
    S23:begin
    weight<=weights[23];
    bia<=bias[23];
    if(svmready) next=SFINAL;
  end
    S39:begin
    weight<=weights[24];
    bia<=bias[24];
    if(w_class==0 && svmready) next=S38;
    else if(w_class==1 && svmready == 1)next=S49;
    end
    S38:begin
    weight<=weights[25];
    bia<=bias[25];
    if(w_class==0 && svmready) next=S37;
    else if(w_class==1 && svmready == 1)next=S48;
    end
    S37:begin
    weight<=weights[26];
    bia<=bias[26];
    if(w_class==0 && svmready) next=S36;
    else if(w_class==1 && svmready == 1)next=S47;
    end
    S36:begin
    weight<=weights[27];
    bia<=bias[27];
    if(w_class==0 && svmready) next=S35;
    else if(w_class==1 && svmready == 1)next=S46;
    end
    S35:begin
    weight<=weights[28];
    bia<=bias[28];
    if(w_class==0 && svmready) next=S34;
    else if(w_class==1 && svmready == 1)next=S45;
    end
    S34:begin
    weight<=weights[29];
    bia<=bias[29];
    if(svmready) next=SFINAL;
  end
    S49:begin
    weight<=weights[30];
    bia<=bias[30];
    if(w_class==0 && svmready) next=S48;
    else if(w_class==1 && svmready == 1)next=S59;
    end
    S48:begin
    weight<=weights[31];
    bia<=bias[31];
    if(w_class==0 && svmready) next=S47;
    else if(w_class==1 && svmready == 1)next=S58;
    end
    S47:begin
    weight<=weights[32];
    bia<=bias[32];
    if(w_class==0 && svmready) next=S46;
    else if(w_class==1 && svmready == 1)next=S57;
    end
    S46:begin
    weight<=weights[33];
    bia<=bias[33];
    if(w_class==0 && svmready) next=S45;
    else if(w_class==1 && svmready == 1)next=S56;
    end
    S45:begin
    weight<=weights[34];
    bia<=bias[34];
    if(svmready) next=SFINAL;
  end
    S59:begin
    weight<=weights[35];
    bia<=bias[35];
    if(w_class==0 && svmready) next=S58;
    else if(w_class==1 && svmready == 1)next=S69;
    end
    S58:begin
    weight<=weights[36];
    bia<=bias[36];
    if(w_class==0 && svmready) next=S57;
    else if(w_class==1 && svmready == 1)next=S68;
    end
    S57:begin
    weight<=weights[37];
    bia<=bias[37];
    if(w_class==0 && svmready) next=S56;
    else if(w_class==1 && svmready == 1)next=S67;
    end
    S56:begin
    weight<=weights[38];
    bia<=bias[38];
    if(svmready) next=SFINAL;
  end
    S69:begin
    weight<=weights[39];
    bia<=bias[39];
    if(w_class==0 && svmready) next=S68;
    else if(w_class==1 && svmready == 1)next=S79;
    end
    S68:begin
    weight<=weights[40];
    bia<=bias[40];
    if(w_class==0 && svmready) next=S67;
    else if(w_class==1 && svmready == 1)next=S78;
    end
    S67:begin
    weight<=weights[41];
    bia<=bias[41];
    if(svmready) next=SFINAL;
  end
    S79:begin
    weight<=weights[42];
    bia<=bias[42];
    if(w_class==0 && svmready) next=S78;
    else if(w_class==1 && svmready == 1)next=S89;
    end
    S78:begin
    weight<=weights[43];
    bia<=bias[43];
    if(svmready) next=SFINAL;
  end
    S89:begin
    weight<=weights[44];
    bia<=bias[44];
    if(svmready) next=SFINAL;
  end
    //SFINAL:next=S09;
  endcase
end
//assign ready=state[0]&state[2]&state[3]&state[5];
endmodule