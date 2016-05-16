##��Windows��ʹ��Sublime Text��дVerilog����##
####ǰ��####
Verilog��һ��Ӳ���������ԣ�HDL������������Windows���м��ɿ�����������ʹ�ã���ModelSim����ModelSim�ı༭����̫������˱�����������ST����дVerilog���뷨���ҽ������Ѳ���д��ϸ��һ�㣬�⽫�ᵼ�½϶�Ĳ��裬������ֵ�õġ�

####ԭ����####
* [Sublime Text 3](https://yunpan.cn/cSyqx8mK8wDju)���������룺a7c6��
* [icarus-verilog-on-windows](https://yunpan.cn/cSyqjbsVHfMfa) ���������룺7528��

**˵����**Sublime Text��һ���ǿ��ı༭��������չ�Էǳ�ǿ����icarus-verilog��һ��Verilog�ı�����������������ʹ�õİ汾��iverilog-0.9.7_setup.exe (latest stable release)����[Icarus Verilog](http://bleyer.org/icarus/)�����վ���й��ڸñ������ĸ�����Ϣ ��
***
####��ʼ�####
#####���#####
��Щ������﷦ζ�������Ǳ���������

1.   ��װicarus-verilog-on-windows������°�װĿ¼�������ҵİ�װĿ¼ΪF:\iverilog\����������Ҳ���Դ�Ŀ¼Ϊ������ע�ⰲװ�����л��п�ѡ����**�빴ѡ��������**������	�Ǻ�**gtkwave**��ص���
2.   �򿪿���̨����������iverilog������ʾ'iverilog: no source files.'��������ִ�е�**4**��������ִ�е�**3**��
3.   ����ϵͳ��������F:\iverilog\bin\��һ·���ӵ�ϵͳ��Path������,ִ�е��������۲�����Ƿ�Ϊ'iverilog: no source files.'
4.   ��iverilog����������������ǾͿ�����������������verilogԴ�ļ��ˣ���д���������ļ�
>***�ļ�����dff.v***
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
***�ļ�����tester.v***
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
***�ļ�����testbench.v***
`include "tester.v"
`include "dff.v"
//Test bench connects the flip-flop to the tester module
module testbench;
	wire clk,d,q,qn;
	dff ff1(d,clk,q,qn);
	tester tst1(q,qn,clk,d);
endmodule
5.   �����������ļ�����ͬһ���ļ����£��򿪿���̨�������Ŀ¼������iverilog testbench.v����ʱӦ��û���κ�������ٴν�����ļ��У����ֶ����һ����Ϊa.out���ļ�������ļ��������Ǳ���testbench.v�õ���Ŀ���ļ�
6.   �ڿ���̨����vvp a.out,���'VCD info: dumpfile dff.vcd opened for output.'��������������ִ�����Ǹոձ������ɵ�a.out
7.   �ٴν�����ļ��У����ֶ������һ����Ϊdff.vcd���ļ�������ļ�������ִ��a.out�����ɵĲ����ļ�
8.   �ڿ���̨����gtkwave dff.vcd�۲첨�Ρ��������û�в��Σ���Ҫ���ţ��ڴ����Ҳ���ѡ��ĳһ��module��Ȼ��������ѡ��ĳһ���������ٵ��insert�Ϳ��Կ�������Ĳ�����

����������Ѿ�����������ª�ı������ĺ�˵Ĳ���
#####ǰ��#####
ǰ�˵Ĵ����Ƚϼ���Ȥ��

1.   ��װSublime Text 3��***�����ҽ�����ΪST***������װQQһ����һ·��next�ͺ���
2.   ��ST������֮ǰ��д������verilog�ļ��е���һ����������û�и�����ʾ�ģ���ctrl+shift+p������ST�İ������ڣ�����install package��������verilog���ҵ���Ӧ����س����ȴ���װ���
