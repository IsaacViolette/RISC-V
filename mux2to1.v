
module mux2to1(
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire sel,
    output reg [31:0] out,
    input clk
    );
     
    always @(in1,in2,sel)
    begin
    if(sel == 0)
        out = in1;
    else
        out = in2;
    end   
	 
endmodule