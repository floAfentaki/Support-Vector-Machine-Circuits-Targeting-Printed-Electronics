module SVM_PICKER_6_CLASS#(
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
parameter[3:0] S01= 16'b0000, S02= 16'b0001, S03= 16'b0010, S04= 16'b0011, S05= 16'b0100, S12= 16'b0101, S13= 16'b0110, S14= 16'b0111, S15= 16'b1000, S23= 16'b1001, S24= 16'b1010, S25= 16'b1011, S34= 16'b1100, S35= 16'b1101, S45= 16'b1110, SFINAL = 16'b1111 ;
reg[3:0] next;
reg[3:0] state;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
    state<=S05;
     end
    else state <= next; 
end

always@(*)begin
	winner<=8'b111;
	ready=1'b1;
	if(state==S01 && w_class==0 && svmready == 1) winner<=8'b000;
	else if(state==S01 && w_class==1 && svmready == 1) winner<=8'b001;
	else if(state==S12 && w_class==0 && svmready == 1) winner<=8'b001;
	else if(state==S12 && w_class==1 && svmready == 1) winner<=8'b010;
	else if(state==S23 && w_class==0 && svmready == 1) winner<=8'b010;
	else if(state==S23 && w_class==1 && svmready == 1) winner<=8'b011;
	else if(state==S34 && w_class==0 && svmready == 1) winner<=8'b011;
	else if(state==S34 && w_class==1 && svmready == 1) winner<=8'b100;
	else if(state==S45 && w_class==0 && svmready == 1) winner<=8'b100;
	else if(state==S45 && w_class==1 && svmready == 1) winner<=8'b101;
	else ready=1'b0;
end

always@*begin
	next=state;
	weight <= weights[0];
	bia <= bias[0];

	case(state)
    S05:begin
    weight<=weights[0];
    bia<=bias[0];
    if(w_class==0 && svmready) next=S04;
    else if(w_class==1 && svmready == 1)next=S15;
    end
    S04:begin
    weight<=weights[1];
    bia<=bias[1];
    if(w_class==0 && svmready) next=S03;
    else if(w_class==1 && svmready == 1)next=S14;
    end
    S03:begin
    weight<=weights[2];
    bia<=bias[2];
    if(w_class==0 && svmready) next=S02;
    else if(w_class==1 && svmready == 1)next=S13;
    end
    S02:begin
    weight<=weights[3];
    bia<=bias[3];
    if(w_class==0 && svmready) next=S01;
    else if(w_class==1 && svmready == 1)next=S12;
    end
    S01:begin
    weight<=weights[4];
    bia<=bias[4];
    if(svmready) next=SFINAL;
  end
    S15:begin
    weight<=weights[5];
    bia<=bias[5];
    if(w_class==0 && svmready) next=S14;
    else if(w_class==1 && svmready == 1)next=S25;
    end
    S14:begin
    weight<=weights[6];
    bia<=bias[6];
    if(w_class==0 && svmready) next=S13;
    else if(w_class==1 && svmready == 1)next=S24;
    end
    S13:begin
    weight<=weights[7];
    bia<=bias[7];
    if(w_class==0 && svmready) next=S12;
    else if(w_class==1 && svmready == 1)next=S23;
    end
    S12:begin
    weight<=weights[8];
    bia<=bias[8];
    if(svmready) next=SFINAL;
  end
    S25:begin
    weight<=weights[9];
    bia<=bias[9];
    if(w_class==0 && svmready) next=S24;
    else if(w_class==1 && svmready == 1)next=S35;
    end
    S24:begin
    weight<=weights[10];
    bia<=bias[10];
    if(w_class==0 && svmready) next=S23;
    else if(w_class==1 && svmready == 1)next=S34;
    end
    S23:begin
    weight<=weights[11];
    bia<=bias[11];
    if(svmready) next=SFINAL;
  end
    S35:begin
    weight<=weights[12];
    bia<=bias[12];
    if(w_class==0 && svmready) next=S34;
    else if(w_class==1 && svmready == 1)next=S45;
    end
    S34:begin
    weight<=weights[13];
    bia<=bias[13];
    if(svmready) next=SFINAL;
  end
    S45:begin
    weight<=weights[14];
    bia<=bias[14];
    if(svmready) next=SFINAL;
  end
    SFINAL:next=S05;
  endcase
end
endmodule
