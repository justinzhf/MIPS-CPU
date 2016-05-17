module controlUnit(inCode,outCode);
	input[5:0] inCode;
	input clk;
	output[9:0] outCode; 
	reg[9:0] result; 
//0011100000
	always @(inCode)
	begin
		case(inCode)
			6'b000000: result<=10'b0100100010;
			6'b100011: result<=10'b0011110000;
			6'b101011: result<=10'b0010001000;
			6'b000100: result<=10'b0000000101;
			6'b000010: result<=10'b1000000000;
			default: result<=10'b0000000000;
		endcase
	end

	assign outCode = result;

endmodule