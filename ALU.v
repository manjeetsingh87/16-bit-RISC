`timescale 1ns / 1ps

module ALU(
	input clk,
	input isALUOP,
	input memRead,
	input memWrite,
	input memReadWrite,
	input isLoadStore,
	input [3:0] opcode,
	input [15:0] rd1,
	input [15:0] rd2,
	input [5:0] offset,
	input fetchNextInst,
	output reg [15:0] result,
	output reg isALUFinished,
	output reg execute_branch,
	output reg jump_flag
);

initial 
	begin
		result = 16'b0;
		isALUFinished = 0;
		execute_branch = 0;
		jump_flag = 0;
	end
	
always @(posedge isLoadStore) // is a load/store operation
	begin
		case(opcode)
			0: begin
					$display("This is a load instruction");
					result = rd1 + offset;
					$display("Result in ALU is %b",result);
					isALUFinished = 1;
				end
			1: begin
					$display("This is a store instruction");
					result = rd1 + offset;
					$display("Result in ALU is %b",result);
					isALUFinished = 1;
				end		
		endcase
	end
	
always @(posedge isALUOP) //is an ALU operation
	begin
		case(opcode)
			2: begin
					$display("This is an add instruction");
					result = rd1 + rd2;
					$display("Result in ALU is %b",result);
					isALUFinished = 1;
				end
			3: begin
					$display("This is a subtract instruction");
					result = rd1 - rd2;
					$display("Result in ALU is %b",result);
					isALUFinished = 1;
				end
			4: begin
					$display("This is an invert instruction");
					result = ~rd1;
					$display("Result in ALU is %b",result);
					isALUFinished = 1;
				end
			5: begin
					$display("This is a shift left instruction");
					result = rd1 << rd2;
					$display("Result in ALU is %b",result);
					isALUFinished = 1;
				end
			6: begin
					$display("This is a shift right instruction");
					result = rd1 >> rd2;
					$display("Result in ALU is %b",result);
					isALUFinished = 1;
				end
			7: begin
					$display("This is a bitwise AND instruction");
					result = rd1 & rd2;
					$display("Result in ALU is %b",result);
					isALUFinished = 1;
				end
			8: begin
					$display("This is a bitwise OR instruction");
					result = rd1 | rd2;
					$display("Result in ALU is %b",result);
					isALUFinished = 1;
				end
			9: begin
					$display("This is a comparison instruction");
					if(rd1<rd2)
						result = 1;
					else
						result = 0;	
					$display("Result in ALU is %b",result);
					isALUFinished = 1;
				end
			10: begin
					$display("This is a BEQZ instruction");
					if(rd1 == rd2) begin
						$display("Branch is taken");
						execute_branch = 1;
					end
					else begin
						$display("Branch is not taken");
						isALUFinished = 1;
					end	
				end
			11: begin
					$display("This is a BENQ instruction");
					if(rd1 == rd2) begin
						$display("Branch is taken");
						isALUFinished = 1;
					end
					else begin
						$display("Branch is not taken");
						execute_branch = 1;
					end
				end
			12: begin
					$display("This is a JUMP instruction");
					$display("Jump instruction");
					jump_flag = 1;
				end 	
		endcase
	end
	
always @(posedge fetchNextInst)
	begin
		$display("Reset isALUFinished flag before next instruction\n");
		isALUFinished = 0;
		execute_branch = 0;
		jump_flag = 0;
	end
endmodule
