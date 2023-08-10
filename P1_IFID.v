
module P1_IFID(
	input wire [31:0]pc,
	input wire [31:0]inst_mem,
	input wire IFID_write,
	input wire flush,
	input wire clk,
	output wire [31:0]pc_out,
	output wire [31:0]inst_mem_out

);
	
	reg [31:0]pc_pipe;
	reg [31:0]inst_mem_pipe;
	
	
	always @(posedge clk) begin
		
		if(flush) begin
		
			inst_mem_pipe <= 0;
			pc_pipe <= 0;
		
		end
		
		else if(IFID_write) begin
		
			pc_pipe <= pc;
			inst_mem_pipe <= inst_mem;
		
		end
	
	end
	
	
	assign pc_out = pc_pipe;
	assign inst_mem_out = inst_mem_pipe;
	
	
	
endmodule 