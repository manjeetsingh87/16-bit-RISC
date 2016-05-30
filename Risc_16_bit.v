`timescale 1ns / 1ps

// only clk is the input, no other signals can be there.
module Risc_16_bit(
	input clk
);

wire readInst_flag;
wire [15:0] instruction;
wire memRead;
wire memWrite;
wire memReadWrite;
wire WBSrc;
wire isALUOP;
wire isLoadStore;
wire [3:0] opcode;
wire fetchNextInst;
wire decodedInst;
	
Datapath_Unit DU(
	clk,
	readInst_flag,
	instruction, //16 bit instruction
	memRead,
	memWrite,
	memReadWrite,
	WBSrc,
	isALUOP,
	isLoadStore,		
	opcode,					// 4 bit opcode
	rd1,
	rd2,
	offset,
	fetchNextInst,
	decodedInst,
	branchInst_flag,
	offsetJump
);

Control_Unit CU(
	clk,
	opcode,
	readInst_flag,
	memRead,
	memWrite,
	memReadWrite,
	WBSrc,
	isALUOP,
	isLoadStore,
	fetchNextInst,
	decodedInst
);

initial
	begin
		//$display("Inside Risc_16_bit");
	end

endmodule
