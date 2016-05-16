`include"controlUnit.v"
//module controlUnit(inCode,outCode,clk);
module controlUnit_test();
	reg clk;
	reg[5:0] inCode;
	wire[8:0] outCode;

	controlUnit c(.inCode(inCode),.outCode(outCode),.clk(clk));

	initial 
	begin
		$dumpfile("cu.vcd");
		$dumpvars;
		clk<=0;
		#10 inCode=6'b000000;
		#10 inCode<=6'b101011;
		#10 inCode=6'b100011;
		#10 $finish;
	end

	always 
	begin
		#4 clk=~clk;
	end

endmodule