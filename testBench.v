`include"CPU.v"
module testBench();
	reg[31:0] inAddr;
	reg clk;

	initial begin
		$dumpfile("test1.vcd");
		$dumpvars;
		//inAddr=0;
		clk=0;
		#100 $finish;
	end
	always  begin
		#10 clk<=~clk;
	end
	CPU cpu(.pcInputAddr(inAddr),.clk(clk));
endmodule