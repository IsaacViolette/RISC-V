module P3_EXMEM(
	input wire Branch,
	input wire MemRead,
	input wire MemtoReg,
	input wire MemWrite,
	input wire RegWrite,
	input wire [31:0]pc_sum,
	input wire [31:0]ALU,
	input wire zero,
	input wire [31:0]rd2,
	input wire [4:0]inst3,
	input wire [2:0]funct3,
	input flush,
	input clk,
	output wire Branch_out,
	output wire MemRead_out,
	output wire MemtoReg_out,
	output wire MemWrite_out,
	output wire RegWrite_out,
	output wire [31:0]pc_sum_out,
	output wire [31:0]ALU_out,
	output wire zero_out,
	output wire [31:0]rd2_out,
	output wire [4:0]inst3_out,
	output wire [2:0]funct3_out
	
);

	 reg Branch_pipe;
	 reg MemRead_pipe;
	 reg MemtoReg_pipe;
	 reg MemWrite_pipe;
	 reg RegWrite_pipe;
	 reg [31:0]pc_sum_pipe;
	 reg [31:0]ALU_pipe;
	 reg zero_pipe;
	 reg [31:0]rd2_pipe;
	 reg [4:0]inst3_pipe;
	 reg [2:0]funct3_pipe;

always @(posedge clk) begin
	
	if(flush) begin
	
		Branch_pipe <= 0;
		MemRead_pipe <= 0;
		MemtoReg_pipe <= 0;
		MemWrite_pipe <= 0;
		RegWrite_pipe <= 0;
		pc_sum_pipe <= 0;
		rd2_pipe <= 0;
		inst3_pipe <= 0;
		ALU_pipe <= 0;
		funct3_pipe <= 0;
		zero_pipe <= 0;
	
	end
	
	
	else begin
	
		Branch_pipe <= Branch;
		MemRead_pipe <= MemRead;
		MemtoReg_pipe <= MemtoReg;
		MemWrite_pipe <=MemWrite;
		RegWrite_pipe <= RegWrite;
		pc_sum_pipe <= pc_sum;
		rd2_pipe <= rd2;
		inst3_pipe <= inst3;
		ALU_pipe <= ALU;
		funct3_pipe <= funct3;
		zero_pipe <= zero;
	end
	end
	
	assign  Branch_out = Branch_pipe;
	assign  MemRead_out = MemRead_pipe;
	assign  MemtoReg_out = MemtoReg_pipe;
	assign  MemWrite_out = MemWrite_pipe;
	assign  RegWrite_out = RegWrite_pipe;
	assign  pc_sum_out = pc_sum_pipe;
	assign  ALU_out = ALU_pipe;
	assign  zero_out = zero_pipe;
	assign  rd2_out = rd2_pipe;
	assign  inst3_out = inst3_pipe;
	assign funct3_out = funct3_pipe;
	
endmodule 