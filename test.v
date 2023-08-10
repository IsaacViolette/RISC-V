module test(
	input wire clock,
	output reg [31:0]out
	//output reg [5:0]out
);

initial begin
	out = 8'h0;
end


always @(posedge clock) begin
	out = out + 1;
	if(out == 8'h3f) begin
		out = 0;
	end
end


//THIS WORKS
//initial begin
	//out[31:0] = 32'h00000001;
//end

//reg [31:0] register [2:0];
//reg [2:0] count;
//
//initial begin
//	register[0] = 32'h01c38333;
//	register[1] = 32'h41c38333;
//	register[2] = 32'h01c3c333;
//end
//
//always @(posedge clock) begin
//	
//	if(count == 1'b0) begin
//		out = register[0];
//	end
//	
//	if(count == 1'b1) begin
//		out = register[1];
//	end
//	
//	if(count == 2'b10) begin
//		out = register[2];
//	end
//	
//	count = count+1;
//	
//end



endmodule