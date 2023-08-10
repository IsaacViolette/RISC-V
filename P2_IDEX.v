

module P2_IDEX(
	input wire Branch,
	input wire MemRead,
	input wire MemtoReg,
	input wire [6:0]ALUOp,
	input wire MemWrite,
	input wire ALUSrc,
	input wire RegWrite,
	input wire [31:0]pc,
	input wire [31:0]rd1,
	input wire [31:0]rd2,
	input wire [31:0]inst1,
	input wire [3:0]inst2,
	input wire [4:0]inst3,
	input wire [4:0]IFIDrs1,
	input wire [4:0]IFIDrs2,
	input wire JALR,
	input flush,
	input clk,
	output wire Branch_out,
	output wire MemRead_out,
	output wire MemtoReg_out,
	output wire [6:0]ALUOp_out,
	output wire MemWrite_out,
	output wire ALUSrc_out,
	output wire RegWrite_out,
	output wire [31:0]pc_out,
	output wire [31:0]rd1_out,
	output wire [31:0]rd2_out,
	output wire [31:0]inst1_out,
	output wire [3:0]inst2_out,
	output wire [4:0]inst3_out,
	output wire [4:0]IFIDrs1_out,
	output wire [4:0]IFIDrs2_out,
	output wire JALR_out
	
);

	reg Branch_pipe;
	reg MemRead_pipe;
	reg MemtoReg_pipe;
	reg [6:0]ALUOp_pipe;
	reg MemWrite_pipe;
	reg ALUSrc_pipe;
	reg RegWrite_pipe;
	reg [31:0]pc_pipe;
	reg [31:0]rd1_pipe;
	reg [31:0]rd2_pipe;
	reg [31:0]inst1_pipe;
	reg [3:0]inst2_pipe;
	reg [4:0]inst3_pipe;
	reg [4:0]IFIDrs1_pipe;
	reg [4:0]IFIDrs2_pipe;
	reg JALR_pipe;

always @(posedge clk) begin

	if(flush) begin
	
		Branch_pipe <= 0;
		MemRead_pipe <= 0;
		MemtoReg_pipe <= 0;
		ALUOp_pipe[6:0] <= 0;
		MemWrite_pipe <= 0;
		ALUSrc_pipe <= 0;
		RegWrite_pipe <= 0;
		pc_pipe <= 0;
		rd1_pipe <= 0;
		rd2_pipe <= 0;
		inst1_pipe <= 0;
		inst2_pipe <= 0;
		inst3_pipe <= 0;
		IFIDrs1_pipe <= 0;
		IFIDrs2_pipe <= 0;
		JALR_pipe <= 0;
	
	end
	
	else begin
		Branch_pipe <= Branch;
		MemRead_pipe <= MemRead;
		MemtoReg_pipe <= MemtoReg;
		ALUOp_pipe[6:0] <= ALUOp[6:0];
		MemWrite_pipe <=MemWrite;
		ALUSrc_pipe <= ALUSrc;
		RegWrite_pipe <= RegWrite;
		pc_pipe <= pc;
		rd1_pipe <= rd1;
		rd2_pipe <= rd2;
		inst1_pipe <= inst1;
		inst2_pipe <= inst2;
		inst3_pipe <= inst3;
		IFIDrs1_pipe <= IFIDrs1;
		IFIDrs2_pipe <= IFIDrs2;
		JALR_pipe <= JALR;
	end
	end
	
	assign  Branch_out = Branch_pipe;
	assign  MemRead_out = MemRead_pipe;
	assign  MemtoReg_out=MemtoReg_pipe;
	assign  ALUOp_out=ALUOp_pipe;
	assign  MemWrite_out = MemWrite_pipe;
	assign  ALUSrc_out=ALUSrc_pipe;
	assign  RegWrite_out=RegWrite_pipe;
	assign  pc_out=pc_pipe;
	assign  rd1_out=rd1_pipe;
	assign  rd2_out=rd2_pipe;
	assign  inst1_out=inst1_pipe;
	assign  inst2_out=inst2_pipe;
	assign  inst3_out=inst3_pipe;
	assign IFIDrs1_out = IFIDrs1_pipe;
	assign IFIDrs2_out = IFIDrs2_pipe;
	assign JALR_out = JALR_pipe;
	
	
endmodule 