`timescale 1ns / 1ps

module Control_Unit(
	input clk,
	input [3:0] opcode,
	output reg readInst_flag,
	output reg memRead,
	output reg memWrite,
	output reg memReadWrite,
	output reg WBSrc,
	output reg isALUOP,
	output reg isLoadStore,
	input fetchNextInst,
	input decodedInst
);

// your logic
initial
	begin
		readInst_flag=1;
	end
	
always @(posedge fetchNextInst)
	begin
		memRead = 0;
		memWrite = 0;
		memReadWrite = 0;
		WBSrc = 0;
		isALUOP = 0;
		isLoadStore = 0;
		$display("reset all flags in control unit before next instruction.");
		readInst_flag = 1;
	end
	
always @(posedge decodedInst)
	begin
		readInst_flag = 0;
		case(opcode)
			0: begin
					memRead=1;
					memWrite=0;
					memReadWrite=0;
					WBSrc=1;
					isLoadStore=1;
					isALUOP = 0;
				end
			1: begin
					memRead=0;
					memWrite=1;
					memReadWrite=0;
					WBSrc=0;
					isLoadStore=1;
					isALUOP = 0;
				end
			2: begin
					memRead=0;
					memWrite=0;
					memReadWrite=1;
					WBSrc=1;
					isLoadStore=0;
					isALUOP = 1;
				end
			3: begin
					memRead=0;
					memWrite=0;
					memReadWrite=1;
					WBSrc=1;
					isLoadStore=0;
					isALUOP = 1;
				end
			4: begin
					memRead=0;
					memWrite=0;
					memReadWrite=1;
					WBSrc=1;
					isLoadStore=0;
					isALUOP = 1;
				end
			5: begin
					memRead=0;
					memWrite=0;
					memReadWrite=1;
					WBSrc=1;
					isLoadStore=0;
					isALUOP = 1;
				end
			6: begin
					memRead=0;
					memWrite=0;
					memReadWrite=1;
					WBSrc=1;
					isLoadStore=0;
					isALUOP = 1;
				end
			7: begin
					memRead=0;
					memWrite=0;
					memReadWrite=1;
					WBSrc=1;
					isLoadStore=0;
					isALUOP = 1;
				end
			8: begin
					memRead=0;
					memWrite=0;
					memReadWrite=1;
					WBSrc=1;
					isLoadStore=0;
					isALUOP = 1;
				end
			9: begin
					memRead=0;
					memWrite=0;
					memReadWrite=1;
					WBSrc=1;
					isLoadStore=0;
					isALUOP = 1;
				end
			10: begin
					memRead=0;
					memWrite=0;
					memReadWrite=1;
					WBSrc=0;
					isLoadStore=0;
					isALUOP = 1;
				end
			11: begin
					memRead=0;
					memWrite=0;
					memReadWrite=1;
					WBSrc=0;
					isLoadStore=0;
					isALUOP = 1;
				end
			12: begin
					memRead=0;
					memWrite=0;
					memReadWrite=0;
					WBSrc=0;
					isLoadStore=0;
					isALUOP = 1;
				end		
		endcase
	end
endmodule
