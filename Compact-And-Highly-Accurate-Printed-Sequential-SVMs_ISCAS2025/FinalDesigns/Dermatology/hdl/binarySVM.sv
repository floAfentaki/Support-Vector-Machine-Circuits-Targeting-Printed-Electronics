module binarySVM #(
	`include "./hdl/params.vh",
	parameter DATA_WIDTH = weightWidth + inputWidth + feature_bits
)(
	input  clk,
	input  rst_n,
	input [weightWidth*N_features-1: 0] svmweights,
	input [biasWidth-1:0] svmbias,
	input [inputWidth * N_features - 1 : 0] inputs,
	output class_o,
	output ready
);
	logic [$clog2(N_features/1+1):0] index;
	reg signed [DATA_WIDTH-1:0] running_sum;
	wire signed [weightWidth + inputWidth - 1 : 0] sum0;

	assign sum0=$signed(svmweights[index*1*weightWidth+: weightWidth]) * $signed({1'b0, inputs[index*1*inputWidth+: inputWidth]});

	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			index <= N_features/1+1;
			running_sum <= 0;
		end else begin
			if (index < N_features/1) begin
				running_sum <= running_sum + sum0;
			end else begin
				running_sum <= $signed({svmbias, 4'b0000});
			end
			if (index == N_features/1+1) index <= 0;
			else index <= index + 1;
		end
	end
	assign class_o = running_sum[DATA_WIDTH -1];
	assign ready = (index == N_features/1);

endmodule