
`include "riscv_defs.v"

//immediates
`define UIMM20 {inst[31:12], 12'b0}
`define IIMM12 {{20{inst[31]}}, inst[31:20]}
`define BIMM   {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0}
`define JIMM20 {{12{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21], 1'b0}
`define STIMM  {{20{inst[31]}}, inst[31:25], inst[11:7]}
`define SHAMT  inst[24:20] 



module decoder(
	input wire [31:0] inst,
	input wire clock,
	output reg [119:0] inst_str,
	output reg [31:0] imm
);


	reg [6:0]opcode;
	reg [8*3-1:0]rd;
	reg [8*3-1:0]rs1;
	reg [8*3-1:0]rs2;
	reg [8*5-1:0]get_inst_str;
	
	
	
	always @(posedge clock) begin
		opcode = inst[6:0];
		rd = get_regname_str(inst[11:7]);
		rs1 = get_regname_str(inst[19:15]);
		rs2 = get_regname_str(inst[24:20]);
		
		case(opcode)
			7'b0110011 : begin
								//R-inst
									if ((inst[31:0] & `INST_ADD_MASK) == `INST_ADD) 
										begin get_inst_str = "ADD"; end
									if ((inst[31:0] & `INST_SUB_MASK) == `INST_SUB) 
										begin get_inst_str = "SUB"; end
									if ((inst[31:0] & `INST_XOR_MASK) == `INST_XOR)
										begin get_inst_str = "XOR"; end
									if ((inst[31:0] & `INST_OR_MASK) == `INST_OR)
										begin get_inst_str = "OR"; end
									if ((inst[31:0] & `INST_AND_MASK) == `INST_AND)
										begin get_inst_str = "AND"; end
									if ((inst[31:0] & `INST_SLL_MASK) == `INST_SLL)
										begin get_inst_str = "SLL"; end
									if ((inst[31:0] & `INST_SRL_MASK) == `INST_SRL)
										begin get_inst_str = "SRL"; end
									if ((inst[31:0] & `INST_SRA_MASK) == `INST_SRA)
										begin get_inst_str = "SRA"; end
									if ((inst[31:0] & `INST_SLT_MASK) == `INST_SLT)
										begin get_inst_str = "SLT"; end
									if ((inst[31:0] & `INST_SLTU_MASK) == `INST_SLTU)
										begin get_inst_str = "SLTU"; end
									inst_str = {get_inst_str,rd,rs1,rs2};
							 end
			7'b0010011 : begin
								//I-type
									if ((inst[31:0] & `INST_ADDI_MASK) == `INST_ADDI)
										begin get_inst_str = "ADDI"; end
									if ((inst[31:0] & `INST_XORI_MASK) == `INST_XORI)
										begin get_inst_str = "XORI"; end
									if ((inst[31:0] & `INST_ORI_MASK) == `INST_ORI)
										begin get_inst_str = "ORI"; end
									if ((inst[31:0] & `INST_ANDI_MASK) == `INST_ANDI)
										begin get_inst_str = "ANDI"; end
									if ((inst[31:0] & `INST_SLLI_MASK) == `INST_SLLI)
										begin get_inst_str = "SLLI"; end
									if ((inst[31:0] & `INST_SRLI_MASK) == `INST_SRLI)
										begin get_inst_str = "SRLI"; end
									if ((inst[31:0] & `INST_SRAI_MASK) == `INST_SRAI)
										begin get_inst_str = "SRAI"; end
									if ((inst[31:0] & `INST_SLTI_MASK) == `INST_SLTI)
										begin get_inst_str = "SLTI"; end
									if ((inst[31:0] & `INST_SLTIU_MASK) == `INST_SLTIU)
										begin get_inst_str = "SLTIU"; end
									inst_str = {get_inst_str,rd,rs1,/*`IIMM12*/"IMM"};
									imm = `IIMM12;
							 end
			7'b0000011 : begin
								//I-type Load
									if ((inst[31:0] & `INST_LB_MASK) == `INST_LB)
										begin get_inst_str = "LB"; end
									if ((inst[31:0] & `INST_LH_MASK) == `INST_LH)
										begin get_inst_str = "LH"; end
									if ((inst[31:0] & `INST_LW_MASK) == `INST_LW)
										begin get_inst_str = "LW"; end
									if ((inst[31:0] & `INST_LBU_MASK) == `INST_LBU)
										begin get_inst_str = "LBU"; end
									if ((inst[31:0] & `INST_LHU_MASK) == `INST_LHU)
										begin get_inst_str = "LHU"; end
									inst_str = {get_inst_str,rd,/*`IIMM12*/"IMM",":",rs1,":"};
									imm = `IIMM12;
							 end
			7'b0100011 : begin
								//S-type
									if ((inst[31:0] & `INST_SB_MASK) == `INST_SB)
										begin get_inst_str = "SB"; end
									if ((inst[31:0] & `INST_SH_MASK) == `INST_SH)
										begin get_inst_str = "SH"; end
									if ((inst[31:0] & `INST_SW_MASK) == `INST_SW)
										begin get_inst_str = "SW"; end
									inst_str = {get_inst_str,rs2,/*`STIMM*/"IMM",":",rs1,":"};
									imm = `STIMM;
							 end
			7'b1100011 : begin
								//B-type
									if ((inst[31:0] & `INST_BEQ_MASK) == `INST_BEQ)
										begin get_inst_str = "BEQ"; end
									if ((inst[31:0] & `INST_BNE_MASK) == `INST_BNE)
										begin get_inst_str = "BNE"; end
									if ((inst[31:0] & `INST_BLT_MASK) == `INST_BLT)
										begin get_inst_str = "BLT"; end
									if ((inst[31:0] & `INST_BGE_MASK) == `INST_BGE)
										begin get_inst_str = "BGE"; end
									if ((inst[31:0] & `INST_BLTU_MASK) == `INST_BLTU)
										begin get_inst_str = "BLTU"; end
									if ((inst[31:0] & `INST_BGEU_MASK) == `INST_BGEU)
										begin get_inst_str = "BGEU"; end
									inst_str = {get_inst_str,rs1,rs2,/*`BIMM*/"IMM"};
									imm = `BIMM;
							 end
			7'b1101111 : begin
								//JAL
									if ((inst[31:0] & `INST_JAL_MASK) == `INST_JAL)
										begin get_inst_str = "JAL"; end
									inst_str = {get_inst_str,rd,/*`JIMM20*/"IMM",};
									imm = `JIMM20;
							 end
			7'b1100111 : begin
								//JALR
									if ((inst[31:0] & `INST_JALR_MASK) == `INST_JALR)
										begin get_inst_str = "JALR"; end
									inst_str = {get_inst_str,rd,rs1,/*`IIMM12*/"IMM"};
									imm = `IIMM12;
							 end
			7'b0110111 : begin
								//U-type
									if ((inst[31:0] & `INST_LUI_MASK) == `INST_LUI)
										begin get_inst_str = "LUI"; end
									inst_str = {get_inst_str,rd,/*`UIMM20*/"IMM"};
									imm = inst[31:12];
							 end
			7'b0010111 : begin
								if ((inst[31:0] & `INST_AUIPC_MASK) == `INST_AUIPC)
										begin get_inst_str = "AUIPC"; end
									inst_str = {get_inst_str,rd,/*`UIMM20*/"IMM"};
									imm = inst[31:12];
							 end
		endcase
		
	end


	function [79:0] get_regname_str;
		input  [4:0] regnum;
	begin
		case (regnum)
			  5'd0:  get_regname_str = "ZERO";
			  5'd1:  get_regname_str = "RA";
			  5'd2:  get_regname_str = "SP";
			  5'd3:  get_regname_str = "GP";
			  5'd4:  get_regname_str = "TP";
			  5'd5:  get_regname_str = "T0";
			  5'd6:  get_regname_str = "T1";
			  5'd7:  get_regname_str = "T2";
			  5'd8:  get_regname_str = "S0";
			  5'd9:  get_regname_str = "S1";
			  5'd10: get_regname_str = "A0";
			  5'd11: get_regname_str = "A1";
			  5'd12: get_regname_str = "A2";
			  5'd13: get_regname_str = "A3";
			  5'd14: get_regname_str = "A4";
			  5'd15: get_regname_str = "A5";
			  5'd16: get_regname_str = "A6";
			  5'd17: get_regname_str = "A7";
			  5'd18: get_regname_str = "S2";
			  5'd19: get_regname_str = "S3";
			  5'd20: get_regname_str = "S4";
			  5'd21: get_regname_str = "S5";
			  5'd22: get_regname_str = "S6";
			  5'd23: get_regname_str = "S7";
			  5'd24: get_regname_str = "S8";
			  5'd25: get_regname_str = "S9";
			  5'd26: get_regname_str = "S10";
			  5'd27: get_regname_str = "S11";
			  5'd28: get_regname_str = "T3";
			  5'd29: get_regname_str = "T4";
			  5'd30: get_regname_str = "T5";
			  5'd31: get_regname_str = "T6";
		 endcase
	end
	endfunction
	
endmodule
