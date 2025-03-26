module SVM_PICKER_7_CLASS#(
	`include "./hdl/params.vh"
)(
	input w_class,
	output reg ready,
	input clk,
	input rst_n,
	input svmready,
	output reg signed[weightWidth*N_features-1:0] weight,
	output reg signed [biasWidth-1:0] bia,
	output reg [2:0] winner
);
parameter[4:0] S01= 32'b00000, S02= 32'b00001, S03= 32'b00010, S04= 32'b00011, S05= 32'b00100, S06= 32'b00101, S12= 32'b00110, S13= 32'b00111, S14= 32'b01000, S15= 32'b01001, S16= 32'b01010, S23= 32'b01011, S24= 32'b01100, S25= 32'b01101, S26= 32'b01110, S34= 32'b01111, S35= 32'b10000, S36= 32'b10001, S45= 32'b10010, S46= 32'b10011, S56= 32'b10100, SFINAL = 32'b10101 ;
reg[4:0] next;
reg[4:0] state;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
    state<=S06;
     end
    else state <= next; 
end

always@(posedge clk or negedge rst_n)begin
	if (!rst_n) begin
		winner<=8'b0000;
		ready<=1'b0;
	end else begin
	if(state==S01 && w_class==0 && svmready == 1)begin
		winner<=8'b000;
		ready <= 1'b1;
	end
	else if(state==S01 && w_class==1 && svmready == 1)begin
		winner<=8'b001;
		ready <= 1'b1;
	end
	else if(state==S12 && w_class==0 && svmready == 1)begin
		winner<=8'b001;
		ready <= 1'b1;
	end
	else if(state==S12 && w_class==1 && svmready == 1)begin
		winner<=8'b010;
		ready <= 1'b1;
	end
	else if(state==S23 && w_class==0 && svmready == 1)begin
		winner<=8'b010;
		ready <= 1'b1;
	end
	else if(state==S23 && w_class==1 && svmready == 1)begin
		winner<=8'b011;
		ready <= 1'b1;
	end
	else if(state==S34 && w_class==0 && svmready == 1)begin
		winner<=8'b011;
		ready <= 1'b1;
	end
	else if(state==S34 && w_class==1 && svmready == 1)begin
		winner<=8'b100;
		ready <= 1'b1;
	end
	else if(state==S45 && w_class==0 && svmready == 1)begin
		winner<=8'b100;
		ready <= 1'b1;
	end
	else if(state==S45 && w_class==1 && svmready == 1)begin
		winner<=8'b101;
		ready <= 1'b1;
	end
	else if(state==S56 && w_class==0 && svmready == 1)begin
		winner<=8'b101;
		ready <= 1'b1;
	end
	else if(state==S56 && w_class==1 && svmready == 1)begin
		winner<=8'b110;
		ready <= 1'b1;
	end
	else begin 
		winner<=8'b0000;
		ready <= 1'b0;
	end
end
end

always@*begin
	next=state;
	weight <= weights[0];
	bia <= bias[0];

	case(state)
    S06:begin
    weight<=weights[0];
    bia<=bias[0];
    if(w_class==0 && svmready) next=S05;
    else if(w_class==1 && svmready == 1)next=S16;
    end
    S05:begin
    weight<=weights[1];
    bia<=bias[1];
    if(w_class==0 && svmready) next=S04;
    else if(w_class==1 && svmready == 1)next=S15;
    end
    S04:begin
    weight<=weights[2];
    bia<=bias[2];
    if(w_class==0 && svmready) next=S03;
    else if(w_class==1 && svmready == 1)next=S14;
    end
    S03:begin
    weight<=weights[3];
    bia<=bias[3];
    if(w_class==0 && svmready) next=S02;
    else if(w_class==1 && svmready == 1)next=S13;
    end
    S02:begin
    weight<=weights[4];
    bia<=bias[4];
    if(w_class==0 && svmready) next=S01;
    else if(w_class==1 && svmready == 1)next=S12;
    end
    S01:begin
    weight<=weights[5];
    bia<=bias[5];
    if(svmready) next=SFINAL;
  end
    S16:begin
    weight<=weights[6];
    bia<=bias[6];
    if(w_class==0 && svmready) next=S15;
    else if(w_class==1 && svmready == 1)next=S26;
    end
    S15:begin
    weight<=weights[7];
    bia<=bias[7];
    if(w_class==0 && svmready) next=S14;
    else if(w_class==1 && svmready == 1)next=S25;
    end
    S14:begin
    weight<=weights[8];
    bia<=bias[8];
    if(w_class==0 && svmready) next=S13;
    else if(w_class==1 && svmready == 1)next=S24;
    end
    S13:begin
    weight<=weights[9];
    bia<=bias[9];
    if(w_class==0 && svmready) next=S12;
    else if(w_class==1 && svmready == 1)next=S23;
    end
    S12:begin
    weight<=weights[10];
    bia<=bias[10];
    if(svmready) next=SFINAL;
  end
    S26:begin
    weight<=weights[11];
    bia<=bias[11];
    if(w_class==0 && svmready) next=S25;
    else if(w_class==1 && svmready == 1)next=S36;
    end
    S25:begin
    weight<=weights[12];
    bia<=bias[12];
    if(w_class==0 && svmready) next=S24;
    else if(w_class==1 && svmready == 1)next=S35;
    end
    S24:begin
    weight<=weights[13];
    bia<=bias[13];
    if(w_class==0 && svmready) next=S23;
    else if(w_class==1 && svmready == 1)next=S34;
    end
    S23:begin
    weight<=weights[14];
    bia<=bias[14];
    if(svmready) next=SFINAL;
  end
    S36:begin
    weight<=weights[15];
    bia<=bias[15];
    if(w_class==0 && svmready) next=S35;
    else if(w_class==1 && svmready == 1)next=S46;
    end
    S35:begin
    weight<=weights[16];
    bia<=bias[16];
    if(w_class==0 && svmready) next=S34;
    else if(w_class==1 && svmready == 1)next=S45;
    end
    S34:begin
    weight<=weights[17];
    bia<=bias[17];
    if(svmready) next=SFINAL;
  end
    S46:begin
    weight<=weights[18];
    bia<=bias[18];
    if(w_class==0 && svmready) next=S45;
    else if(w_class==1 && svmready == 1)next=S56;
    end
    S45:begin
    weight<=weights[19];
    bia<=bias[19];
    if(svmready) next=SFINAL;
  end
    S56:begin
    weight<=weights[20];
    bia<=bias[20];
    if(svmready) next=SFINAL;
  end
    //SFINAL:next=S06;
  endcase
end
//assign ready=state[0]&state[2]&state[4];
endmodule