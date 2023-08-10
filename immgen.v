//immediates
`define UIMM20 {inst[31:12], 12'b0}
`define IIMM12 {{20{inst[31]}}, inst[31:20]}
`define BIMM   {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0}
`define JIMM20 {{12{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21], 1'b0}
`define STIMM  {{20{inst[31]}}, inst[31:25], inst[11:7]}
`define SHAMT  inst[24:20] 



module immgen(
	input wire [31:0]inst,
	output reg [31:0]immOut
);

	reg [6:0]opcode;
	
	always @(inst) begin
		
		opcode = inst[6:0];
		
		case(opcode)

			7'b0010011 : begin
								//I-type
								immOut = `IIMM12;
							 end
			7'b0000011 : begin
								//I-type Load
								immOut = `IIMM12;
							 end
			7'b0100011 : begin
								//S-type
								immOut = `STIMM;
							 end
			7'b0110111 : begin
								//U-Type
								immOut = `UIMM20;
							 end
			7'b0010111 : begin
							   //U-Type (AUIPC)
								immOut = `UIMM20;
							 end
			7'b1101111 : begin
								//J-Type
								immOut = `JIMM20;
							 end
			7'b1100111 : begin
								//I-Type (JALR)
								immOut = `IIMM12;
							 end
			7'b1100011 : begin
								//B-Type
								immOut = `BIMM;
							 end
			7'b0100011 : begin
								//S-Type
								immOut = `STIMM;
							 end
		endcase
		
	end





endmodule 