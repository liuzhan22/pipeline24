module ID (
    input reset,
    input clk,
    input [31:0] IR,

    output [2 -1:0] PCSrc    ,
	output Branch            ,
	output RegWrite          ,
	output [2 -1:0] RegDst   ,
	output MemRead           ,
	output MemWrite          ,
	output [2 -1:0] MemtoReg ,
	output ALUSrc1           ,
	output ALUSrc2           ,
	output ExtOp             ,
	output LuOp              ,
	output [4 -1:0] ALUOp    ,

    output [31:0] Ext_out,
    output [31:0] LU_out,

    output [31:0] RegA,
    output [31:0] RegB
);


    wire [5:0] OpCode;
    assign OpCode = IR[31:26];

    wire [5:0] Funct;
    assign Funct = IR[5:0];
    // Your code below (for question 1) This part is copied from Control.v

    assign Ext_out = { ExtOp? {16{Instruction[15]}}: 16'h0000, Instruction[15:0]};
	assign LU_out = LuOp? {Instruction[15:0], 16'h0000}: Ext_out;

	// set PCSrc
	assign PCSrc[1:0] = 
		(OpCode == 6'h02 || OpCode == 6'h03)? 2'b01: // j, jal
		(OpCode == 6'h00 && Funct == 6'h08)? 2'b10: // jr
		2'b00;

	// set Branch
	assign Branch = 
		(OpCode == 6'h04)? 1'b1: // beq
		1'b0;

	// set RegWrite
	assign RegWrite = 
		(OpCode == 6'h2b)? 1'b0: // sw
		(OpCode == 6'h04)? 1'b0: // beq
		(OpCode == 6'h02)? 1'b0: // j
		(OpCode == 6'h00 && Funct == 6'h08)? 1'b0: // jr
		1'b1;

	// set RegDst
	assign RegDst[1:0] = 
		(OpCode == 6'h00 && Funct == 6'h08)? 2'b10: // jr
		(OpCode == 6'h00)? 2'b01: // R-type inst
		(OpCode == 6'h1c && Funct == 6'h02)? 2'b01: // mul
		(OpCode == 6'h2b)? 2'b10: // sw
		(OpCode == 6'h04)? 2'b10: // beq
		(OpCode == 6'h02)? 2'b10: // j
		(OpCode == 6'h03)? 2'b10: // jal
		2'b00; // other

	// set MemRead
	assign MemRead = 
		(OpCode == 6'h23)? 1'b1: // lw
		1'b0;

	// set MemWrite
	assign MemWrite = 
		(OpCode == 6'h2b)? 1'b1: // sw
		1'b0;

	// set MemtoReg
	assign MemtoReg[1:0] = 
		(OpCode == 6'h23)? 2'b01: // lw
		(OpCode == 6'h03)? 2'b10: // jal
		2'b00; 

	// set ALUSrc1
	assign ALUSrc1 = 
		(OpCode == 6'h00 && Funct == 6'h00)? 1'b1: // sll
		(OpCode == 6'h00 && Funct == 6'h02)? 1'b1: // srl
		(OpCode == 6'h00 && Funct == 6'h03)? 1'b1: // sra
		1'b0; 

	// set ALUSrc2
	assign ALUSrc2 = 
		(OpCode == 6'h1c && Funct == 6'h02)? 1'b0: // mul
		(OpCode == 6'h00)? 1'b0: // R-type
		(OpCode == 6'h04)? 1'b0: // beq
		1'b1;

	// set ExtOp (? mind bug here)
	assign ExtOp = 
		(OpCode == 6'h0f)? 1'b0: // lui
		1'b1; 

	// set LuOp
	assign LuOp = 
		(OpCode == 6'h0f)? 1'b1: // lui
		1'b0;

	// Your code above (for question 1)

	// set ALUOp
	assign ALUOp[2:0] = 
		(OpCode == 6'h00)? 3'b010: 
		(OpCode == 6'h04)? 3'b001: 
		(OpCode == 6'h0c)? 3'b100: 
		(OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101: 
		(OpCode == 6'h1c && Funct == 6'h02)? 3'b110:
		3'b000; //mul
		
	assign ALUOp[3] = OpCode[0];

    RegisterFile RegisterFile_of_ID (
        .reset(reset),
        .clk(clk),
        .RegWrite(1'b0),
        .Read_register1(IR[25:21]),
        .Read_register2(IR[20:16]),
        .Write_register(5'b00000),
        .Write_data(32'h00000000),
        .Read_data1(RegA),
        .Read_data2(RegB)
    )

endmodule