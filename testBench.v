`include"CPU.v"
module testBench();
	reg clk;

	initial begin
		$dumpfile("test2.vcd");
		$dumpvars;
		//inAddr=0;
		clk=1;
		#500 $finish;
	end
	always  begin
		#10 clk<=~clk;
	end
	CPU cpu(.clk(clk));
endmodule