module controlUnit(inCode,outCode,clk);
	input[5:0] inCode;
	input clk;
	output[8:0] outCode; 
	reg[8:0] result; 
//0011100000
	always @(posedge clk)
	begin
		case(inCode)
			6'b000000: result<=9'b100100010;
			6'b100011: result<=9'b011110000;
			6'b101011: result<=9'b010001000;
			6'b000100: result<=9'b000000101;
			default: result<=9'b000000000;
		endcase
	end

	assign outCode = result;

endmodule