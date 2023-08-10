module mux3to1(
	input wire[31:0]in1,
	input wire[31:0]in2,
	input wire[31:0]in3,
	input wire[1:0]sel,
	output reg[31:0]out
);


	 always @(in1,in2,in3,sel) begin
    if(sel == 0)
        out = in1;
    else if(sel == 1)
        out = in2;
	 else if (sel == 2)
			out = in3;
    end   


endmodule