`include"CPU.v"
module testBench();
	reg clk;
	reg rst;
	initial begin
		$dumpfile("test2.vcd");
		$dumpvars;
		//inAddr=0;
		clk<=1;
		rst=1;

		#20 rst=0;
		#500 $finish;
	end
	always  begin
		#10 clk<=~clk;
	end
	
	
	CPU cpu(.clk(clk),.rst(rst));
endmodule