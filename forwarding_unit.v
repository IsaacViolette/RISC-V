module forwarding_unit(
	input wire [4:0]rs1,
	input wire [4:0]rs2,
	input wire [4:0]exMemRd,
	input wire [4:0]memWbRd,
	input wire exMemRw,
	input wire memWbRw,
	output reg [1:0]ForwardA,
	output reg [1:0]ForwardB
);

always @(rs1,rs2,exMemRd,memWbRd,exMemRw,memWbRw) begin
		ForwardA = 2'b00;
		ForwardB = 2'b00;
	if(exMemRw && (exMemRd!=0) && (exMemRd == rs1)) begin
		ForwardA = 2'b10;
	end
	
	if(exMemRw && (exMemRd!=0) && (exMemRd == rs2)) begin
		ForwardB = 2'b10;
	end
	
	if(memWbRw && (memWbRd != 0) && !(exMemRw && (exMemRd!=0) && (exMemRd == rs1)) && (memWbRd == rs1)) begin
		ForwardA = 2'b01;
	end
	
	if(memWbRw && (memWbRd != 0) && !(exMemRw && (exMemRd!=0) && (exMemRd == rs2)) && (memWbRd == rs2)) begin
		ForwardB = 2'b01;
	end
end 

endmodule