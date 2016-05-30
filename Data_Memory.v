`timescale 1ns / 1ps
`include "Parameter.v"

module Data_Memory(
	input clk,
	input memRead,
	input memWrite,
	input memReadWrite,
	input [15:0] result,
	input [15:0] rd2,
	input isALUFinished,
	output reg [15:0] rdata,
	output reg rdata_flag,
	input fetchNextInst
);

reg [`col - 1:0] memory [`row_d - 1:0];
integer f;

initial
	begin
	
		$readmemb("test\\test.data", memory);
		f = $fopen(`filename);
		$fmonitor(f, "time = %d\n", $time, 
		"\tmemory[0] = %b\n", memory[0],			
		"\tmemory[1] = %b\n", memory[1],
		"\tmemory[2] = %b\n", memory[2],
		"\tmemory[3] = %b\n", memory[3],
		"\tmemory[4] = %b\n", memory[4],
		"\tmemory[5] = %b\n", memory[5],
		"\tmemory[6] = %b\n", memory[6],
		"\tmemory[7] = %b\n", memory[7]);
		`simulation_time;
		 $fclose(f);
	end
		
	always @(posedge isALUFinished)
	begin
		if (memRead == 1)
			 begin
				rdata=memory[result];
				$display("Load complete. Rdata = %b",rdata);
				rdata_flag = 1;
			 end
		 else if(memWrite == 1)
			 begin
				@(posedge clk)
				begin
					memory[result] = rd2;
					$display("Store complete.");
					if(rdata == 0)
						rdata=1;
					else 
						rdata=0;	
						
					rdata_flag = 1;
				end
			 end
		 else if(memReadWrite == 1)
			 begin
				$display("Inside Data Memory - No memory operation required");
				rdata=result;
				rdata_flag = 1;
			 end
	end
	
	always @(posedge fetchNextInst)
	begin
		$display("Reset rdata flag before next instruction");
		rdata_flag = 0;
	end
endmodule
