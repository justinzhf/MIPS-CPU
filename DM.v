module DM(inAddr,writeData,memRead,memWrite,outData,clk);
	input[31:0] inAddr;
	input[31:0] writeData;
	input memRead;
	input memWrite;
	output[31:0] outData;
	input clk;

	reg[31:0] mem[255:0];

	initial begin
		$readmemh("DMData.data",mem);
	end

	always @(posedge clk) begin
		if(memWrite)mem[inAddr]=writeData;
		else;
	end

	assign outData = (memRead==1)?mem[inAddr]:0;

endmodule
