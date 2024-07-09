module CPU(
	input  reset                        , 
	input  clk                          , 
	output MemRead                      , 
	output MemWrite                     ,
	output [32 -1:0] MemBus_Address     , 
	output [32 -1:0] MemBus_Write_Data  , 
	input  [32 -1:0] Device_Read_Data 
);
	
	// IF stage
	wire [31:0] PC;
	wire [31:0] IR;
	wire [31:0] PC_plus_4;

	IF IF_main(
		.reset(reset),
		.clk(clk),
		.PC(PC),
		
		.PC_new(PC_plus_4)
		.IR(IR)
	);

	// IF_ID reg stage
	wire [31:0] PC_plus_4_IF_ID_out;
	wire [31:0] IR_IF_ID_out;

	IF_ID_Reg IF_ID_main(
		.reset(reset),
		.clk(clk),
		.PC_plus_4(PC_plus_4),
		.IR(IR),

		.PC_plus_4_IF_ID_out(PC_plus_4_IF_ID_out),
		.IR_IF_ID_out(IR_IF_ID_out)
	);

	// ID stage
	wire [2 -1:0] PCSrc;
	wire Branch;
	wire RegWrite;
	wire [2 -1:0] RegDst;
	wire MemRead;
	wire MemWrite;
	wire [2 -1:0] MemtoReg;
	wire ALUSrc1;
	wire ALUSrc2;
	wire ExtOp;
	wire LuOp;
	wire [4 -1:0] ALUOp;

	wire [31:0] Ext_out;
	wire [31:0] LU_out;

	ID ID_main(
	);
	
endmodule
