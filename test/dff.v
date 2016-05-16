//dff modules represents a D type flip-flop
module dff(d,clk,q,qn);
	input d,clk;
	output q,qn;
	reg q,qn;

	//Initialize flip-flop outputs
	initial begin q=0; qn=1; end

	//Change output on positive clock edge
	always @(posedge clk) 
	begin
		q <= d;
		qn <= !d;
	end
endmodule
