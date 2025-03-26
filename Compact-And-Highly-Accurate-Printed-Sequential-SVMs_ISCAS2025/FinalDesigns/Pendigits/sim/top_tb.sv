`timescale 100ms/1ms
module top_tb;

parameter num_feats =17;
parameter feature_bits=5;
parameter biasWidth= 8;
parameter w_width = 8;
parameter inputWidth = 4;
`define NULL 0
localparam period = 20;
localparam halfperiod= period/2;
localparam doubleperiod=period*2;
localparam tripleperiod=period*18;
localparam quadroperiod=doubleperiod*2;
reg [67:0]sample;
reg [3:0] out;
reg [3:0] class_p;
integer in, f, r;
real count, correct,accuracy;
reg test;
reg clk,rst_n;
reg ready;

top #(.weightWidth(w_width),.feature_bits(feature_bits),.N_features(num_feats),.biasWidth(biasWidth),.inputWidth(inputWidth)) DUT (
	.in(sample),
	.clk(clk),
	.rst_n(rst_n),
	.ready(ready),
	.w_class(out)
);

always #halfperiod clk = ~clk;
initial
begin
	test=1'b1;
	rst_n=1'b0;
	clk = 1'b0;
	count=0;
	correct=0;
	#period rst_n=1'b1;
	$display($time, " << Starting the Simulation >>");
		in = $fopen("./sim/inputs.txt","r");
		if (in == `NULL) begin
			$display($time, " file not found");
			$finish;
		end
		f = $fopen("./sim/output.txt");
	while (!$feof(in)) begin
		r = $fscanf(in,"%b %d\n",sample,class_p);
		count=count+1;
		@(posedge ready) #0.2 $fwrite(f,"%t %d %d\n",$time, class_p,out);
		if(class_p==out)correct=correct+1;
		rst_n=1'b0;
		@(negedge clk) rst_n=1'b1;
	end
	accuracy= (correct*100)/count;
	$display($time, " Accuracy %0f", accuracy);
	$fwrite(f,"%0f \n",accuracy);
	$display($time, " << Finishing the Simulation >>");
	$fclose(in);
	$fclose(f);
	$finish;
end
endmodule
