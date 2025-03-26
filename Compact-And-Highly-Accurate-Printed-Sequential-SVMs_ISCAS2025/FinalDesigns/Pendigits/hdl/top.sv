module top#(
	`include "./hdl/params.vh"
)
(
  input wire [inputWidth * N_features - 1 : 0] in,
  input wire clk,
  input wire rst_n,
  output wire ready,
  output wire[3 : 0] w_class
);
wire class_o;
wire[5 :0] next_svm;
wire [weightWidth*N_features-1:0] w;
wire [biasWidth-1:0] b;
wire svmready;

binarySVM DUT_SVM(
	.clk(clk),
	.rst_n(rst_n),
	.ready(svmready),
	.svmbias(b),
	.inputs(in),
	.svmweights(w),
	.class_o(class_o)
);
SVM_PICKER_10_CLASS DUT_PICKER(
  .w_class(class_o),
  .clk(clk),
  .rst_n(rst_n),
  .svmready(svmready),
  .ready(ready),
  .winner(w_class),
  .weight(w),
  .bia(b)
);
endmodule