##在Windows上使用Sublime Text编写Verilog代码##
####前言####
Verilog是一种硬件描述语言（HDL），该语言在Windows上有集成开发环境可以使用，如ModelSim，但ModelSim的编辑器不太好用因此笔者萌生了用ST来编写Verilog的想法。我将尽量把步骤写的细致一点，这将会导致较多的步骤，但这是值得的。

####原材料####
* [Sublime Text 3](https://yunpan.cn/cSyqx8mK8wDju)（访问密码：a7c6）
* [icarus-verilog-on-windows](https://yunpan.cn/cSyqjbsVHfMfa) （访问密码：7528）

**说明：**Sublime Text是一款功能强大的编辑器，可扩展性非常强；而icarus-verilog是一款Verilog的编译器，在这里我们使用的版本是iverilog-0.9.7_setup.exe (latest stable release)，在[Icarus Verilog](http://bleyer.org/icarus/)这个网站上有关于该编译器的更多信息 。
***
####开始搭建####
#####后端#####
这些步骤枯燥乏味，但我们必须这样做

1.   安装icarus-verilog-on-windows。请记下安装目录，例如我的安装目录为F:\iverilog\，（下面我也将以此目录为例）。注意安装过程中会有可选择的项，**请勾选上所有项**，尤其	是和**gtkwave**相关的项
2.   打开控制台，输入命令iverilog，若显示'iverilog: no source files.'字样，则执行第**4**步；否则执行第**3**步
3.   配置系统变量。将F:\iverilog\bin\这一路径加到系统的Path变量中,执行第三步，观察输出是否为'iverilog: no source files.'
4.   当iverilog命令输出正常后，我们就可以用它来编译运行verilog源文件了，编写如下三个文件
>***文件名：dff.v***
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
<br/>
***文件名：tester.v***
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
<br/>
***文件名：testbench.v***
`include "tester.v"
`include "dff.v"
//Test bench connects the flip-flop to the tester module
module testbench;
	wire clk,d,q,qn;
	dff ff1(d,clk,q,qn);
	tester tst1(q,qn,clk,d);
endmodule
5.   将上述三个文件放在同一个文件夹下，打开控制台，进入该目录，输入iverilog testbench.v，此时应当没有任何输出，再次进入该文件夹，发现多出了一个名为a.out的文件，这个文件就是我们编译testbench.v得到的目标文件
6.   在控制台输入vvp a.out,输出'VCD info: dumpfile dff.vcd opened for output.'字样，此命令是执行我们刚刚编译生成的a.out
7.   再次进入该文件夹，发现多出来了一个名为dff.vcd的文件，这个文件是我们执行a.out后生成的波形文件
8.   在控制台输入gtkwave dff.vcd观察波形。如果发现没有波形，不要惊慌，在窗口右侧上选择某一个module，然后在右下选择某一个变量，再点击insert就可以看到输出的波形了

到这里，我们已经完成了这个简陋的编译器的后端的操作
#####前端#####
前端的搭建将会比较简单有趣。

1.   安装Sublime Text 3，***后面我将其简称为ST***，就像安装QQ一样，一路点next就好了
2.   用ST打开我们之前编写的三个verilog文件中的任一个，发现是没有高亮显示的，按ctrl+shift+p，调出ST的包管理窗口，输入install package，再输入verilog后找到对应的项，回车，等待安装完成
