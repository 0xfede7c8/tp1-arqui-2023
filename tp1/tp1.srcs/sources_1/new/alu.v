`timescale 1ns / 1ps

`include "alu.vh"

`define DEF_SZ_DATA 32

module ALU 
	#(parameter sz_data=`DEF_SZ_DATA)
	(input signed [sz_data-1:0]a, input signed [sz_data-1:0]b, input [`OP_MSB:0]op,
	output reg[sz_data-1:0]out);
	always@(*)
	begin
		case (op)
			`ADD: out=a+b;
			`SUB: out=a-b;
			`AND: out=a&b;
			`OR: out=a|b;
			`XOR: out=a^b;
			`NOR: out=~(a|b);
			`SRA: out=a>>>b;
			`SRL: out=a>>b;
			default: out= 0;
		endcase
	end

endmodule
