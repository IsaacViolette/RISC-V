module pc_counter(
	input wire clock,
	input wire [31:0]pc_inc,
	input wire pc_write,
	output reg [31:0]out,
	output reg [31:0]prog_count
);

initial begin
	out = 0;
	prog_count = 4194304; //8'h00400000
end


always @(posedge clock) begin
	if(pc_write) begin
		out = pc_inc;
		prog_count = prog_count + 4;
	end

end


endmodule 