module tester(q,qn,clk,d);
	input q,qn;
	output clk,d;
	reg clk,d;

	//Run the test once
	initial
	begin
		clk=0;
		//Dump results of the simulation to ff.cvd
		$dumpfile("dff.vcd");
		$dumpvars;
		//Generate input signal d
		   d=0; #9 d=1; #1 d=0; #1 d=1; #2 d=0; #1 d=1; #12 d=0;
		#1 d=1; #2 d=0; #1 d=1; #1 d=0; #1 d=1; #1 d=0; # 7 d=1;
		#8 $finish;
	end

	//Generate periodic clock signal
	always
	begin
		#4 clk=!clk;
	end
endmodule
