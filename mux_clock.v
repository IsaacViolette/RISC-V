
module mux_clock(
    input wire in1,
    input wire in2,
    input wire sel,
    output reg out
    );
     
    always @(in1,in2,sel)
    begin
    if(sel == 0)
        out = in1;
    else
        out = in2;
    end   
	 
endmodule 