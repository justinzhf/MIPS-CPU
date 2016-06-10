module DM(inAddr,writeData,memRead,memWrite,outData,clk);
	input[31:0] inAddr;
	input[31:0] writeData;
	input memRead;
	input memWrite;
	output[31:0] outData;
	input clk;

	reg[7:0] mem[1023:0];
	initial begin
		$readmemh("DMData.data",mem);
	end

	always @(inAddr) begin
		if(memWrite) begin
			mem[inAddr]=writeData[7:0];
			mem[inAddr+1]=writeData[15:8];
			mem[inAddr+2]=writeData[23:15];
			mem[inAddr+3]=writeData[31:24];
		end
		else;
	end

	assign outData = (memRead==1)?{mem[inAddr+3],mem[inAddr+2],mem[inAddr+1],mem[inAddr]}:0;

endmodule
