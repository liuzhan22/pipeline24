module EX (
    input reset,
    input clk,

    input [31:0] IR,
    input [31:0] RegA,
    input [31:0] RegB,
    input [31:0] PC_plus_4,
    input [31:0] Ext_out,

    input ALUSrc1,
    input ALUSrc2,

    input [31:0] LU_out,
    input [3:0] ALUOp,
    
    output [31:0] PC_Add,
    output [31:0] ALUout,
    output Zero
);

    // PC add output, which may be used by beq, etc.
    assign PC_Add = PC_plus_4 + Ext_out;

    // ALU control
    wire [4:0] AltCtl;
    wire Sign;

    wire [31:0] ALU_in1;
    wire [31:0] ALU_in2;

    assign ALU_in1 = ALUSrc1? {27'h00000, IR[10:6]}: RegA;
	assign ALU_in2 = ALUSrc2? LU_out: RegB;

    ALUControl ALUControl_EX(
        .ALUOp(ALUOp),
        .Funct(IR[5:0]),
        .ALUCtl(ALUCtl),
        .Sign(Sign)
    );

    ALU ALU_EX(
        .in1(ALU_in1),
        .in2(ALU_in2),
        .ALUCtl(ALUCtl),
        .Sign(Sign),
        .out(ALUout),
        .Zero(Zero)
    );

endmodule