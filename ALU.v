
module ALU(
	input wire clock,
	input wire [31:0]rs1,
	input wire [31:0]rs2,
	input wire [6:0]opcode,
	input wire [3:0]funct,
	input wire [31:0]pc,
	output reg zero,
	output reg [31:0]rd
);
	
	reg [31:0]sub;
	
	always @(rs1,rs2,opcode,funct) begin
	
	sub = rs1-rs2;
	zero = 0;
		
		case(opcode)
			7'b0110011 : begin
							//R-inst
							if(funct[2:0] == 3'b000) begin	
								if(funct[3] == 1'b0) begin		//add
									rd <= rs1 + rs2;
								end else if(funct[3] == 1'b1) begin //sub
									rd <= rs1 - rs2;
								end
							end else if(funct[2:0] == 3'b100) begin 		//xor
								rd <= rs1 ^ rs2;
							end else if(funct[2:0] == 3'b110) begin   		//or
								rd <= rs1 | rs2;
							end else if(funct[2:0] == 3'b111) begin 		//and
								rd <= rs1 & rs2;
							end else if(funct[2:0] == 3'b001) begin 		//sll
								rd <= rs1 << rs2;
							end else if(funct[2:0] == 3'b101) begin
								if(funct[3] == 1'b0) begin 		//srl
									rd <= rs1 >> rs2;
								end else if(funct[3] == 1'b1) begin //sra
									rd <= rs1 >>> rs2;
								end
							end else if (funct[2:0] == 3'b010) begin 	//slt
								if (rs1[31] != rs2[31]) begin
										rd  <= rs1[31] ? 1'b1 : 1'b0;
								 end else begin
										rd  <= sub[31] ? 1'b1 : 1'b0; 
								 end 
							end else if(funct[2:0] == 3'b011) begin 		//sltu
								rd <= (rs1<rs2)?1:0;
							end

							end
			7'b0010011 : begin
							//I-type
							if(funct[2:0] == 3'b000) begin			//addi
									rd <= rs1 + rs2;
							end else if(funct[2:0] == 3'b100) begin 		//xori
								rd <= rs1 ^ rs2;
							end else if(funct[2:0] == 3'b110) begin   		//ori
								rd <= rs1 | rs2;
							end else if(funct[2:0] == 3'b111) begin 		//andi
								rd <= rs1 & rs2;
							end else if(funct[2:0] == 3'b001) begin 		//slli
								rd <= rs1 << rs2[4:0];
							end else if(funct[2:0] == 3'b101) begin 
								if(rs2[11:5] == 1'b0) begin
									rd <= rs1 >> rs2[4:0];
								end else if(rs2[11:5] == 1'b1) begin 	
									rd <= rs1 >>> rs2[4:0];
								end
							end else if (funct[2:0] == 3'b010) begin 	//slti
								 if (rs1[31] != rs2[31]) begin
										rd  <= rs1[31] ? 1'b1 : 1'b0;
								 end else begin
										rd  <= sub[31] ? 1'b1 : 1'b0; 
									  end 
							end else if(funct[2:0] == 3'b011) begin 		//sltui
								rd <= (rs1<rs2)?1:0;
							end
							 end
			7'b0000011 : begin
								//I-type Load
									rd <= (rs1/4) + (rs2/4);
							 end
			7'b0100011 : begin
								//S-type
									rd <= (rs1/4) + (rs2/4);
							 end
			7'b0010111 : begin
								//U-type (auipc)
									rd <= pc + rs2;
							 end
			7'b1100011 : begin
								//B-type
									if ((funct[2:0] == 3'b000) && (rs1 == rs2)) begin //beq
										zero <= 1;
									end
									else if ((funct[2:0] == 3'b001) && (rs1 != rs2)) begin //bne
										zero <= 1;
									end
									else if (funct[2:0] == 3'b100) begin //blt
										if (rs1[31] != rs2[31]) begin
											zero  <= rs1[31] ? 1'b1 : 1'b0;
										end else begin
											zero  <= sub[31] ? 1'b1 : 1'b0; 
										end 
									end
									else if (funct[2:0] == 3'b101) begin //bge
										if (rs1 == rs2) begin
											zero = 1;
										end
										else if (rs1[31] != rs2[31]) begin
											zero  <= rs1[31] ? 1'b0 : 1'b1;
										end else begin
											zero  <= sub[31] ? 1'b0 : 1'b1; 
										end 
									end
									else if ((funct[2:0] == 3'b110) && (rs1 < rs2)) begin //bltu (unsigned)
										zero <= 1;
									end
									else if ((funct[2:0] == 3'b111) && (rs1 >= rs2)) begin //bgeu (unsigned)
										zero <= 1;
									end
									
							 end
		7'b1101111 : begin
							//J-type (jal)
								rd = pc + 4;
								zero = 1;
						 end
		7'b1100111 : begin
							//I-type (jalr)
								rd = pc + 4;
								zero = 1;
						 end
		7'b0110111 : begin
							//U-Type (lui)
								rd = rs2;
						 end
		endcase
		
	end
	
	
endmodule