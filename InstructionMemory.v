module InstructionMemory(
	input      [32 -1:0] Address, 
	output reg [32 -1:0] Instruction
);
	
	always @(*)
		case (Address[9:2])

			// -------- Paste Binary Instruction Below (Inst-q1-1/Inst-q1-2.txt)
8'd0:	Instruction <= 32'h20100000;
8'd1:	Instruction <= 32'h8c110000;
8'd2:	Instruction <= 32'h00005020;
8'd3:	Instruction <= 32'h22080004;
8'd4:	Instruction <= 32'h01005820;
8'd5:	Instruction <= 32'h21080004;
8'd6:	Instruction <= 32'h21290001;
8'd7:	Instruction <= 32'h1131000a;
8'd8:	Instruction <= 32'h8d120000;
8'd9:	Instruction <= 32'h214a0001;
8'd10:	Instruction <= 32'h8d730000;
8'd11:	Instruction <= 32'h0253a02a;
8'd12:	Instruction <= 32'h1280fff7;
8'd13:	Instruction <= 32'had730004;
8'd14:	Instruction <= 32'had720000;
8'd15:	Instruction <= 32'h216bfffc;
8'd16:	Instruction <= 32'h1170fff3;
8'd17:	Instruction <= 32'h08100009;
8'd18:	Instruction <= 32'hae0a0000;
8'd19:	Instruction <= 32'h22f70001;
8'd20:	Instruction <= 32'h08100014;




			// -------- Paste Binary Instruction Above
			
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule
