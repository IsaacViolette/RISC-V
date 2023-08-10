module P4_MEMWB(
	input wire RegWrite,
	input wire MemtoReg,
	input wire [31:0]readData,
	input wire [31:0]ALU,
	input wire [4:0]inst3,
	input clk,
	output wire MemtoReg_out,
	output wire RegWrite_out,
	output wire [31:0] readData_out,
	output wire [31:0]ALU_out,
	output wire [4:0]inst3_out
	
);
	
	 reg RegWrite_pipe;
	 reg MemtoReg_pipe;
	 reg [31:0]readData_pipe;
	 reg [31:0]ALU_pipe;
	 reg [4:0]inst3_pipe;

always @(posedge clk) begin
	
	RegWrite_pipe <= RegWrite;
	MemtoReg_pipe <= MemtoReg;
	readData_pipe <= readData;
	ALU_pipe <= ALU;
	inst3_pipe <= inst3;
	
	end
	
	assign MemtoReg_out = MemtoReg_pipe;
	assign RegWrite_out = RegWrite_pipe;
	assign readData_out = readData_pipe;
	assign ALU_out = ALU_pipe;
	assign inst3_out = inst3_pipe;
	
endmodule 