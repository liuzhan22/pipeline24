module EX (
    input reset,
    input clk,

    input [1:0] ForwardA,
    input [1:0] ForwardB,
    input [31:0] ALUout_EX_MEM_out,
    input [31:0] WriteBackData,

    input [31:0] IR,
    input [31:0] RegA,
    input [31:0] RegB,
    input [31:0] PC_plus_4,

    input ALUSrc1,
    input ALUSrc2,

    input [31:0] LU_out,
    input [3:0] ALUOp,
    
    output [31:0] PC_Add,
    output [31:0] ALUout,
    output Zero
);

    // PC add output, which may be used by beq, etc.
    assign PC_Add = PC_plus_4 + {LU_out[29:0], 2'b00};

    // ALU control
    wire [4:0] ALUCtl;
    wire Sign;

    wire [31:0] ALU_in1;
    wire [31:0] ALU_in2;

    // assign ALU_in1 = ALUSrc1? {27'h00000, IR[10:6]}: RegA;
    assign ALU_in1 = ALUSrc1? {27'h00000, IR[10:6]}: 
                     (ForwardA == 2'b00) ? RegA :
                     (ForwardA == 2'b01) ? WriteBackData :
                     (ForwardA == 2'b10) ? ALUout_EX_MEM_out : 32'd0;
	assign ALU_in2 = ALUSrc2? LU_out: 
                     (ForwardB == 2'b00) ? RegB :
                     (ForwardB == 2'b01) ? WriteBackData :
                     (ForwardB == 2'b10) ? ALUout_EX_MEM_out : 32'd0;

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
        .zero(Zero)
    );

endmodule