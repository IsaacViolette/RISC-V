
module PC(
	input wire clock,
	input wire [31:0]pc_inc,
	input wire pc_write,
	output wire [31:0]pc_out
);


	reg [31:0]pc_inc_pipe;

initial begin
	pc_inc_pipe = 4194304; //8'h00400000
end

always @(posedge clock) begin
	if(pc_write) begin
		pc_inc_pipe = pc_inc;
	end 

end

assign pc_out = pc_inc_pipe;

endmodule 