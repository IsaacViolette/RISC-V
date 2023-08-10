//immediates
`define BYTE_SIGNED	{old_data[31:8], data[7:0]}
`define HALF_SIGNED	{old_data[31:16], data[15:0]}
`define WORD			data[31:0]


module store_data_size(
	input wire [31:0]data,
	input wire [2:0]funct3,
	input wire [31:0] old_data,
	input wire clock,
	output reg [31:0]dataOut
);

always @(clock) begin
	
	case(funct3)
	
		3'b000 : dataOut = `BYTE_SIGNED;
		
		3'b001 : dataOut = `HALF_SIGNED;
		
		3'b010 : dataOut = `WORD;
		
	endcase
	
end



endmodule 