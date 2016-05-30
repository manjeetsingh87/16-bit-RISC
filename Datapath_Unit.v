`timescale 1ns / 1ps

module Datapath_Unit(
	input clk,
	input readInst_flag,
	input [15:0] instruction,				// 16 bit instruction
	input memRead,
	input	memWrite,
	input memReadWrite,
	input	WBSrc,
	input isALUOP,
	input isLoadStore,
	output reg [3:0] opcode	,			// 4 bit opcode
	output reg [15:0] rd1,
	output reg [15:0] rd2,
	output reg [5:0] offset,
	output reg fetchNextInst,
	output reg decodedInst,
	input branchInst_flag,
	output reg [11:0] offsetJump
);
	wire [15:0] result;
	wire [15:0] rdata;
	wire memRead;
	wire memWrite;
	wire memReadWrite;
	wire isALUFinished;
	wire rdata_flag;
	wire decode_current_inst;
	wire execute_branch;
	wire jump_flag;
	
	//Instruction_Memory im(clk);
	Instruction_Memory im(clk,readInst_flag,instruction, decode_current_inst,decodedInst, offset, branchInst_flag,execute_branch, jump_flag, offsetJump);
	Data_Memory dm(clk,memRead,memWrite,memReadWrite,result,rd2,isALUFinished,rdata,rdata_flag,fetchNextInst);
	ALU alu(clk,isALUOP,memRead,memWrite,memReadWrite,isLoadStore,opcode, rd1, rd2,offset, fetchNextInst, result,isALUFinished,execute_branch, jump_flag);
	// other modules;
	
	//Program counter
	reg counter;
	
	// Registers
	reg [15:0] R [7:0];
		
	//
	reg [2:0] rs1;
	reg [2:0] rs2;
	reg [2:0] ws;
	
initial
	begin
		R[0]=0;
		R[1]=0;
		R[2]=0;
		R[3]=0;
		R[4]=0;
		R[5]=0;
		R[6]=0;
		R[7]=0;
		opcode=4'bxxxx;
		decodedInst=0;
		fetchNextInst=0;
	end

always @(posedge decode_current_inst)
	begin
		$display("current instruction is %b",instruction);
		rs1 = instruction[11:9];
		rs2 = instruction[8:6];
		ws = instruction[5:3];
		offset = instruction[5:0];
		offsetJump = instruction[11:0];
		rd1=R[rs1];
		rd2=R[rs2];
		opcode = instruction[15:12];
		decodedInst = 1;
		fetchNextInst = 0;
	end
	
always @(posedge rdata_flag)
	begin
		if(WBSrc==1 && memRead == 1) begin
				R[rs2]=rdata;
				$display("Write back done for load instruction.");
			end
		else if(WBSrc==1 && memRead == 0) begin
				R[ws]=rdata;
				$display("Write back done for ALU instructions.");
			end	
		fetchNextInst = 1;
		decodedInst = 0;
	end
	
always @(posedge branchInst_flag) 
	begin
		$display("End of branch jump instruction");
		fetchNextInst = 1;
		decodedInst = 0;
	end
endmodule
