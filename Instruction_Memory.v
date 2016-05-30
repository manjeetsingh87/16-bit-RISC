`timescale 1ns / 1ps
`include "Parameter.v"

  module Instruction_Memory(
	input clk,
	input readInst_flag,
	output reg [`col - 1:0] instruction,
	output reg decode_current_inst,
	input decodedInst,
	input offset,
	output reg branchInst_flag,
	input execute_branch,
	input jump_flag,
	input [11:0] offsetJump
);

reg [`col - 1:0] memory [`row_i - 1:0];
reg [15:0] counter;

initial 
	begin
		$readmemb("test\\test.prog", memory);
		instruction[`col - 1:0] = 16'bXXXXXXXXXXXXXXXX; //set to empty instruction
		counter = 0;
		decode_current_inst = 0;
		branchInst_flag = 0;
	end

always @(posedge readInst_flag)
	begin
		branchInst_flag = 0;
		$display("fetching instruction with counter at %d %b",counter,memory[counter]);
		if(16'bXXXXXXXXXXXXXXXX !== memory[counter]) //check if instruction is valid
		begin
			instruction = memory[counter];			
			$display("current instruction is: %b",instruction);
			counter = counter+1; //increment program counter
			decode_current_inst = 1;
			$display("current value of decode_current_inst is %b",decode_current_inst);
		end
	end

always @(posedge decodedInst)
	begin
		decode_current_inst = 0;
		$display("reset decode_current_inst flag here %b",decode_current_inst);
	end
	
always @(posedge execute_branch)
	begin
		counter = counter + offset<<1;
		$display("program counter updated to new value: %b",counter);
		branchInst_flag=1;
	end

reg[12:0] temp_reg;
always @(posedge jump_flag)
	begin
		temp_reg = offsetJump<<1;
		counter[12:0] = temp_reg;
		$display("program counter updated to new value: %b",counter);
		branchInst_flag=1;
	end
endmodule
