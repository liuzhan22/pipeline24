module CPU(
	input  reset                        , 
	input  clk                          , 
	output MemRead                      , 
	output MemWrite_origin              ,
	output [32 -1:0] MemBus_Address     , 
	output [32 -1:0] MemBus_Write_Data  , 
	input  [32 -1:0] Device_Read_Data 
);
	
	assign MemWrite_origin = MemWrite;

	// IF stage
	wire [31:0] PC;
	wire [31:0] IR;
	wire [31:0] PC_plus_4;

	IF IF_main(
		.reset(reset),
		.clk(clk),
		.PC(PC),
		
		.PC_plus_4(PC_plus_4),
		.IR(IR)
	);

	// IF_ID reg stage
	wire [31:0] PC_plus_4_IF_ID_out;
	wire [31:0] IR_IF_ID_out;
	wire IF_ID_flush;

	IF_ID IF_ID_main(
		.reset(reset),
		.clk(clk),

		.IF_ID_flush(IF_ID_flush),

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

	wire [31:0] RegA;
	wire [31:0] RegB;

	wire [31:0] Ext_out;
	wire [31:0] LU_out;

	// declare what used in WB.v ahead
	wire RegWrite_MEM_WB_out;
	wire [31:0] WriteBackData;
	wire [4:0] WriteBackReg;

	ID ID_main(
		.reset(reset),
		.clk(clk),
		.IR(IR_IF_ID_out),

		.PCSrc(PCSrc),
		.Branch(Branch),
		.RegWrite(RegWrite),
		.RegDst(RegDst),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.MemtoReg(MemtoReg),
		.ALUSrc1(ALUSrc1),
		.ALUSrc2(ALUSrc2),
		.ExtOp(ExtOp),
		.LuOp(LuOp),
		.ALUOp(ALUOp),

		.Ext_out(Ext_out),
		.LU_out(LU_out)
	);

	// ID_EX reg stage
	wire ID_EX_flush;
	wire [31:0] IR_ID_EX_out;

	wire [31:0] PC_plus_4_ID_EX_out;
	wire [31:0] LU_out_ID_EX_out;

	wire [31:0] RegA_ID_EX_out;
	wire [31:0] RegB_ID_EX_out;

	wire [2 -1:0] PCSrc_ID_EX_out;
	wire Branch_ID_EX_out;
	wire RegWrite_ID_EX_out;
	wire [2 -1:0] RegDst_ID_EX_out;
	wire MemRead_ID_EX_out;
	wire MemWrite_ID_EX_out;
	wire [2 -1:0] MemtoReg_ID_EX_out;
	wire ALUSrc1_ID_EX_out;
	wire ALUSrc2_ID_EX_out;
	wire [4 -1:0] ALUOp_ID_EX_out;

	ID_EX ID_EX_main(
		.reset(reset),
		.clk(clk),

		.ID_EX_flush(ID_EX_flush),

		.IR_ID_EX_in(IR_IF_ID_out),

		.LU_out_ID_EX_in(LU_out),
		.PC_plus_4_ID_EX_in(PC_plus_4_IF_ID_out),

		.RegA_ID_EX_in(RegA),
		.RegB_ID_EX_in(RegB),

		.PCSrc_ID_EX_in(PCSrc),
		.Branch_ID_EX_in(Branch),
		.RegWrite_ID_EX_in(RegWrite),
		.RegDst_ID_EX_in(RegDst),
		.MemRead_ID_EX_in(MemRead),
		.MemWrite_ID_EX_in(MemWrite),
		.MemtoReg_ID_EX_in(MemtoReg),
		.ALUSrc1_ID_EX_in(ALUSrc1),
		.ALUSrc2_ID_EX_in(ALUSrc2),
		.ALUOp_ID_EX_in(ALUOp),

		.IR_ID_EX_out(IR_ID_EX_out),

		.PC_plus_4_ID_EX_out(PC_plus_4_ID_EX_out),
		.LU_out_ID_EX_out(LU_out_ID_EX_out),

		.RegA_ID_EX_out(RegA_ID_EX_out),
		.RegB_ID_EX_out(RegB_ID_EX_out),

		.PCSrc_ID_EX_out(PCSrc_ID_EX_out),
		.Branch_ID_EX_out(Branch_ID_EX_out),
		.RegWrite_ID_EX_out(RegWrite_ID_EX_out),
		.RegDst_ID_EX_out(RegDst_ID_EX_out),
		.MemRead_ID_EX_out(MemRead_ID_EX_out),
		.MemWrite_ID_EX_out(MemWrite_ID_EX_out),
		.MemtoReg_ID_EX_out(MemtoReg_ID_EX_out),
		.ALUSrc1_ID_EX_out(ALUSrc1_ID_EX_out),
		.ALUSrc2_ID_EX_out(ALUSrc2_ID_EX_out),
		.ALUOp_ID_EX_out(ALUOp_ID_EX_out)
	);

	// EX stage
	wire [31:0] PC_Add;
	wire [31:0] ALUout;
	wire Zero;

	EX EX_main(
		.reset(reset),
		.clk(clk),

		.IR(IR_ID_EX_out),
		.RegA(RegA_ID_EX_out),
		.RegB(RegB_ID_EX_out),
		.PC_plus_4(PC_plus_4_ID_EX_out),

		.ALUSrc1(ALUSrc1_ID_EX_out),
		.ALUSrc2(ALUSrc2_ID_EX_out),

		.LU_out(LU_out_ID_EX_out),
		.ALUOp(ALUOp_ID_EX_out),

		.PC_Add(PC_Add),
		.ALUout(ALUout),
		.Zero(Zero)
	);

	// EX_MEM reg stage
	wire [31:0] IR_EX_MEM_out;
	wire [31:0] PC_plus_4_EX_MEM_out;

	wire [31:0] RegB_EX_MEM_out;
	wire [31:0] PC_Add_EX_MEM_out;
	wire Zero_EX_MEM_out;
	wire [31:0] ALUout_EX_MEM_out;

	wire [2 -1:0] PCSrc_EX_MEM_out;
	wire Branch_EX_MEM_out;
	wire RegWrite_EX_MEM_out;
	wire [2 -1:0] RegDst_EX_MEM_out;
	wire MemRead_EX_MEM_out;
	wire MemWrite_EX_MEM_out;
	wire [2 -1:0] MemtoReg_EX_MEM_out;

	EX_MEM EX_MEM_main(
		.reset(reset),
		.clk(clk),

		.IR_EX_MEM_in(IR_ID_EX_out),
		.PC_plus_4_EX_MEM_in(PC_plus_4_ID_EX_out),

		.RegB_EX_MEM_in(RegB_ID_EX_out),
		.PC_Add_EX_MEM_in(PC_Add),
		.Zero_EX_MEM_in(Zero),
		.ALUout_EX_MEM_in(ALUout),

		.PCSrc_EX_MEM_in(PCSrc_ID_EX_out),
		.Branch_EX_MEM_in(Branch_ID_EX_out),
		.RegWrite_EX_MEM_in(RegWrite_ID_EX_out),
		.RegDst_EX_MEM_in(RegDst_ID_EX_out),
		.MemRead_EX_MEM_in(MemRead_ID_EX_out),
		.MemWrite_EX_MEM_in(MemWrite_ID_EX_out),
		.MemtoReg_EX_MEM_in(MemtoReg_ID_EX_out),

		.IR_EX_MEM_out(IR_EX_MEM_out),
		.PC_plus_4_EX_MEM_out(PC_plus_4_EX_MEM_out),

		.RegB_EX_MEM_out(RegB_EX_MEM_out),
		.PC_Add_EX_MEM_out(PC_Add_EX_MEM_out),
		.Zero_EX_MEM_out(Zero_EX_MEM_out),
		.ALUout_EX_MEM_out(ALUout_EX_MEM_out),

		.PCSrc_EX_MEM_out(PCSrc_EX_MEM_out),
		.Branch_EX_MEM_out(Branch_EX_MEM_out),
		.RegWrite_EX_MEM_out(RegWrite_EX_MEM_out),
		.RegDst_EX_MEM_out(RegDst_EX_MEM_out),
		.MemRead_EX_MEM_out(MemRead_EX_MEM_out),
		.MemWrite_EX_MEM_out(MemWrite_EX_MEM_out),
		.MemtoReg_EX_MEM_out(MemtoReg_EX_MEM_out)
	);

	// MEM stage
	wire [31:0] Memory_Read_Data;

	MEM MEM_main(
		.reset(reset),
		.clk(clk),

		.ALU_out(ALUout_EX_MEM_out),
		.RegB(RegB_EX_MEM_out),

		.MemRead(MemRead_EX_MEM_out),
		.MemWrite(MemWrite_EX_MEM_out),

		.Memory_Read_Data(Memory_Read_Data)
	);

	// MEM_WB reg stage
	wire [31:0] IR_MEM_WB_out;
	wire [31:0] PC_plus_4_MEM_WB_out;
	wire [31:0] Memory_Read_Data_MEM_WB_out;
	wire [31:0] ALU_out_MEM_WB_out;

	wire [2 -1:0] PCSrc_MEM_WB_out;
	wire Branch_MEM_WB_out;
	wire [2 -1:0] RegDst_MEM_WB_out;
	wire [2 -1:0] MemtoReg_MEM_WB_out;

	MEM_WB MEM_WB_main(
		.reset(reset),
		.clk(clk),

		.IR_MEM_WB_in(IR_EX_MEM_out),
		.PC_plus_4_MEM_WB_in(PC_plus_4_EX_MEM_out),

		.Memory_Read_Data_MEM_WB_in(Memory_Read_Data),
		.ALU_out_MEM_WB_in(ALUout_EX_MEM_out),

		.PCSrc_MEM_WB_in(PCSrc_EX_MEM_out),
		.Branch_MEM_WB_in(Branch_EX_MEM_out),
		.RegWrite_MEM_WB_in(RegWrite_EX_MEM_out),
		.RegDst_MEM_WB_in(RegDst_EX_MEM_out),
		.MemtoReg_MEM_WB_in(MemtoReg_EX_MEM_out),

		.IR_MEM_WB_out(IR_MEM_WB_out),
		.PC_plus_4_MEM_WB_out(PC_plus_4_MEM_WB_out),
		.Memory_Read_Data_MEM_WB_out(Memory_Read_Data_MEM_WB_out),
		.ALU_out_MEM_WB_out(ALU_out_MEM_WB_out),

		.PCSrc_MEM_WB_out(PCSrc_MEM_WB_out),
		.Branch_MEM_WB_out(Branch_MEM_WB_out),
		.RegWrite_MEM_WB_out(RegWrite_MEM_WB_out),
		.RegDst_MEM_WB_out(RegDst_MEM_WB_out),
		.MemtoReg_MEM_WB_out(MemtoReg_MEM_WB_out)
	);

	// WB stage

	WB WB_main(
		.reset(reset),
		.clk(clk),

		.IR(IR_MEM_WB_out),
		.PC_plus_4(PC_plus_4_MEM_WB_out),
		.Memory_Read_Data(Memory_Read_Data_MEM_WB_out),
		.ALU_out(ALU_out_MEM_WB_out),

		.RegWrite(RegWrite_MEM_WB_out),
		.RegDst(RegDst_MEM_WB_out),
		.MemtoReg(MemtoReg_MEM_WB_out), 

		.WriteBackData(WriteBackData),
		.WriteBackReg(WriteBackReg)
	);

	RegisterFile RegisterFile_main(
		.reset(reset),
		.clk(clk),
		.RegWrite(RegWrite_MEM_WB_out),
		.Read_register1(IR_IF_ID_out[25:21]),
		.Read_register2(IR_IF_ID_out[20:16]),
		.Write_register(WriteBackReg),
		.Write_data(WriteBackData),

		.Read_data1(RegA),
		.Read_data2(RegB)
	);

	// Update PC to PC + 4
	// assign PC = PC_plus_4;
	// branch instruction, execute in EX stage: compare rs and rt directly, if branch, flush instruction in IF and ID stage.
	wire Branch_true;
	wire [31:0] PC_branch;
	assign Branch_true = Branch_ID_EX_out && Zero;
	assign ID_EX_flush = Branch_true;
	assign IF_ID_flush = Branch_true;
	assign PC_branch = PC_Add; // seems no use, but syntax more clearly
	assign PC = Branch_true? PC_branch: PC_plus_4;

endmodule
