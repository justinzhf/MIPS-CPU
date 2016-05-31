module IFID(addr4,ins,out,clk,rst);
	input[31:0] addr4,ins;
	output[63:0] out;
	input clk,rst;
	reg[63:0] out;

	initial
	begin
		out<=0;
	end

	always @(posedge clk or rst) begin
		if (rst) begin
			// reset
			out<=0;
		end
		else begin
		out={addr4,ins};
		end
	end

endmodule