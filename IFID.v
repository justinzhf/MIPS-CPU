module IFID(addr4,ins,out,clk,rst);
	input[31:0] addr4,ins;
	output[63:0] out;
	input clk,rst;
	reg[63:0] con;

	initial
	begin
		con<=0;
	end

	always @(posedge clk or rst) begin
		if (rst) begin
			// reset
			con<=0;
		end
		else begin
		con={addr4,ins};
		end
	end
	assign out = con;

endmodule