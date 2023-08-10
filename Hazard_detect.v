
module hazard_detect(
		input wire IDEXMemRead,
		input wire [4:0]IFIDrs1,
		input wire [4:0]IFIDrs2,
		input wire [4:0]IDEXrd,
		
		output reg mux_control,
		output reg IFIDWrite,
		output reg PCWrite
);


always @(IDEXMemRead,IFIDrs1,IFIDrs2,IDEXrd) begin
	
	if(IDEXMemRead && ((IDEXrd == IFIDrs1) || (IDEXrd == IFIDrs2))) begin
	
		IFIDWrite = 0;
		mux_control = 0;
		PCWrite = 0;
	
	end
	else begin
	
		IFIDWrite = 1;
		mux_control = 1;
		PCWrite = 1;
	
	end
	
	
end

endmodule