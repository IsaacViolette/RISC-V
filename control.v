
module control(
	input wire [6:0]opcode,
	input wire clk,
	output reg Branch,
	output reg MemRead,
	output reg MemtoReg,
	output reg [6:0]ALUOp,
	output reg MemWrite,
	output reg ALUSrc,
	output reg RegWrite,
	output reg JALR
);

	always @(opcode) begin
	
		case(opcode)
	
			7'b0110011 : begin //R-Type
			
				Branch = 0;
				MemRead = 0;
				MemtoReg = 0;
				ALUOp = opcode;
				MemWrite = 0;
				ALUSrc = 0;
				RegWrite = 1;
				JALR = 0;
			
			end
			
			
			7'b0010011 : begin //I-Type
			
				Branch = 0;
				MemRead = 0;
				MemtoReg = 0;
				ALUOp = opcode;
				MemWrite = 0;
				ALUSrc = 1;
				RegWrite = 1;
				JALR = 0;
			
			end
			
			
			7'b0000011 : begin //Load I-Type 
			
				Branch = 0;
				MemRead = 1;
				MemtoReg = 1;
				ALUOp = opcode;
				MemWrite = 0;
				ALUSrc = 1;
				RegWrite = 1;
				JALR = 0;
			
			end
			
			
			7'b0100011 : begin //S-Type
			
				Branch = 0;
				MemRead = 0;
				MemtoReg = 0;
				ALUOp = opcode;
				MemWrite = 1;
				ALUSrc = 1;
				RegWrite = 0;
				JALR = 0;
			
			end
			
			7'b0110111 : begin //U-Type
			
				Branch = 0;
				MemRead = 0;
				MemtoReg = 0;
				ALUOp = opcode;
				MemWrite = 0;
				ALUSrc = 1;
				RegWrite = 1;
				JALR = 0;
				
			end
			
			7'b0010111 : begin //U-Type (AUIPC)
			
				Branch = 0;
				MemRead = 0;
				MemtoReg = 0;
				ALUOp = opcode;
				MemWrite = 0;
				ALUSrc = 1;
				RegWrite = 1;
				JALR = 0;
				
			end
			
			7'b1100011 : begin //B-Type
			
				Branch = 1;
				MemRead = 0;
				MemtoReg = 0;
				ALUOp = opcode;
				MemWrite = 0;
				ALUSrc = 0;
				RegWrite = 0;
				JALR = 0;
			
			end
			
			7'b1101111 : begin //J-Type (JAL)
			
				Branch = 1;
				MemRead = 0;
				MemtoReg = 0;
				ALUOp = opcode;
				MemWrite = 0;
				ALUSrc = 0;
				RegWrite = 1;
				JALR = 0;
			
			end
			
			7'b1100111 : begin //JALR
			
				Branch = 1;
				MemRead = 0;
				MemtoReg = 0;
				ALUOp = opcode;
				MemWrite = 0;
				ALUSrc = 0;
				RegWrite = 1;
				JALR = 1;
			
			end
			
			
			7'b0000000 : begin //nop
			
				Branch = 0;
				MemRead = 0;
				MemtoReg = 0;
				ALUOp = 7'b0000000;
				MemWrite = 0;
				ALUSrc = 0;
				RegWrite = 0;
				JALR = 0;
			
			end
			
			
		
		endcase
	
	end
	
endmodule
	