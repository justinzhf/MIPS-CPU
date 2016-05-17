module ALUControl(func,aluop,aluctrl);
	input[5:0] func;
	input[1:0] aluop;
	input clk;
	output[3:0] aluctrl;

	reg[3:0] aluctrl;

	always @(func or aluop or aluctrl) begin
		if(aluop==2'b00)
			aluctrl<=4'b0010;
		else if(aluop==2'b01)
			aluctrl<=4'b0110;
		else if(aluop==2'b10)
			begin
				case(func)
					6'b100000: aluctrl<=4'b0010;
					6'b100010: aluctrl<=4'b0110;
					6'b100100: aluctrl<=4'b0000;
					6'b100101: aluctrl<=4'b0001;
					6'b101010: aluctrl<=4'b0111;
					default: aluctrl<=4'b0000;
				endcase
			end
		else 
			aluctrl<=0;
	end

endmodule