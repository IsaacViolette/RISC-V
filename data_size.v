//immediates
`define BYTE_SIGNED	{{24{data[7]}}, data[7:0]}
`define HALF_SIGNED	{{16{data[15]}}, data[15:0]}
`define WORD			data[31:0]
`define BYTE			{{24{1'b0}}, data[7:0]}
`define HALF			{{16{1'b0}}, data[15:0]}


module data_size(
	input wire [31:0]data,
	input wire [2:0]funct3,
	output reg [31:0]dataOut
);

always @(data, funct3) begin
	
	case(funct3)
	
		3'b000 : dataOut = `BYTE_SIGNED;
		
		3'b001 : dataOut = `HALF_SIGNED;
		
		3'b010 : dataOut = `WORD;
	
		3'b100 : dataOut = `BYTE;
		
		3'b101 : dataOut = `HALF;
		
	endcase
	
end



endmodule 