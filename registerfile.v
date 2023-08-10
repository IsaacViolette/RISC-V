// file registerfile.v

module registerfile(
	input wire [4:0] read_address_1,
	input wire [4:0] read_address_2,
	input wire [31:0] write_data_in,
	input wire [4:0] write_address,
	input wire WriteEnable,
	input wire reset,
	input wire clock,
	input wire [4:0] read_address_debug,
	input wire clock_debug,
	output reg [31:0] data_out_1,
	output reg [31:0] data_out_2,
	output reg [31:0] data_out_debug);
	
	reg [31:0] register [31:0];
	integer i;
	
	initial begin
		for(i = 0; i < 32; i=i+1) begin
			register[i] = 0;
		end
		
		register[2] = 2147479548;
	end
	
	always @(posedge clock) begin
	
		data_out_1[31:0] <= register[read_address_1];
		data_out_2[31:0] <= register[read_address_2];
		
		if(reset == 1'b1) begin
			for(i = 0; i < 32; i=i+1) begin
			register[i] = i;
			end
		end
		
		if((WriteEnable == 1'b1) && (write_address != 0)) begin
			register[write_address] <= write_data_in;
		end
		
	end
	
	always @(posedge clock_debug) begin
		data_out_debug[31:0] <= register[read_address_debug];
	end

endmodule
