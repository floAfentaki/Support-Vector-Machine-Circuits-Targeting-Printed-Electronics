module SVM_PICKER_3_CLASS#(
	`include "./hdl/params.vh"
)(
	input w_class,
	output reg ready,
	input clk,
	input rst_n,
	input svmready,
	output reg signed[weightWidth*N_features-1:0] weight,
	output reg signed [biasWidth-1:0] bia,
	output reg [1:0] winner
);
parameter[1:0] S01= 4'b00, S02= 4'b01, S12= 4'b10, SFINAL = 4'b11 ;
reg[1:0] next;
reg[1:0] state;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
    state<=S02;
     end
    else state <= next; 
end

always@(posedge clk or negedge rst_n)begin
	if (!rst_n) begin
		winner<=4'b00000;
		ready<=1'b0;
	end else begin
	if(state==S01 && w_class==0 && svmready == 1)begin
		winner<=4'b00;
		ready <= 1'b1;
	end
	else if(state==S01 && w_class==1 && svmready == 1)begin
		winner<=4'b01;
		ready <= 1'b1;
	end
	else if(state==S12 && w_class==0 && svmready == 1)begin
		winner<=4'b01;
		ready <= 1'b1;
	end
	else if(state==S12 && w_class==1 && svmready == 1)begin
		winner<=4'b10;
		ready <= 1'b1;
	end
	else begin 
		winner<=4'b00000;
		ready <= 1'b0;
	end
end
end

always@*begin
	next=state;
	weight <= weights[0];
	bia <= bias[0];

	case(state)
    S02:begin
    weight<=weights[0];
    bia<=bias[0];
    if(w_class==0 && svmready) next=S01;
    else if(w_class==1 && svmready == 1)next=S12;
    end
    S01:begin
    weight<=weights[1];
    bia<=bias[1];
    if(svmready) next=SFINAL;
  end
    S12:begin
    weight<=weights[2];
    bia<=bias[2];
    if(svmready) next=SFINAL;
  end
    //SFINAL:next=S02;
  endcase
end
//assign ready=state[0]&state[1];
endmodule