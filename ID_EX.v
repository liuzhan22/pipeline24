module ID_EX (
    input reset,
    input clk,

    input [31:0] IR_ID_EX_in,

    input [31:0] LU_out_ID_EX_in,
    input [31:0] PC_plus_4_ID_EX_in,

    // Reg read data that should be generated in ID stage
    input [31:0] RegA_ID_EX_in,
    input [31:0] RegB_ID_EX_in,

    // Control signals generated in ID stage
    input [2 -1:0] PCSrc_ID_EX_in,
    input Branch_ID_EX_in,
    input RegWrite_ID_EX_in,
    input [2 -1:0] RegDst_ID_EX_in,
    input MemRead_ID_EX_in,
    input MemWrite_ID_EX_in,
    input [2 -1:0] MemtoReg_ID_EX_in,
    input ALUSrc1_ID_EX_in,
    input ALUSrc2_ID_EX_in,
    input [4 -1:0] ALUOp_ID_EX_in,

    output reg [31:0] IR_ID_EX_out,

    output reg [31:0] PC_plus_4_ID_EX_out,
    output reg [31:0] LU_out_ID_EX_out,

    // Reg read data given to EX stage
    output reg [31:0] RegA_ID_EX_out,
    output reg [31:0] RegB_ID_EX_out,

    output reg [2 -1:0] PCSrc_ID_EX_out,
    output reg Branch_ID_EX_out,
    output reg RegWrite_ID_EX_out,
    output reg [2 -1:0] RegDst_ID_EX_out,
    output reg MemRead_ID_EX_out,
    output reg MemWrite_ID_EX_out,
    output reg [2 -1:0] MemtoReg_ID_EX_out,
    output reg ALUSrc1_ID_EX_out,
    output reg ALUSrc2_ID_EX_out,
    output reg [4 -1:0] ALUOp_ID_EX_out 


);

    always @(posedge reset or posedge clk) begin
        if(reset) begin
            PC_plus_4_ID_EX_out <= 32'd0;
            IR_ID_EX_out <= 32'd0;
            LU_out_ID_EX_out <= 32'd0;

            PCSrc_ID_EX_out <= 2'd0;
            Branch_ID_EX_out <= 1'd0;
            RegWrite_ID_EX_out <= 1'd0;
            RegDst_ID_EX_out <= 2'd0;
            MemRead_ID_EX_out <= 1'd0;
            MemWrite_ID_EX_out <= 1'd0;
            MemtoReg_ID_EX_out <= 2'd0;
            ALUSrc1_ID_EX_out <= 1'd0;
            ALUSrc2_ID_EX_out <= 1'd0;
            ALUOp_ID_EX_out <= 4'd0;
        end
        else begin
            PC_plus_4_ID_EX_out <= PC_plus_4_ID_EX_in;
            IR_ID_EX_out <= IR_ID_EX_in;
            LU_out_ID_EX_out <= LU_out_ID_EX_in;

            PCSrc_ID_EX_out <= PCSrc_ID_EX_in;
            Branch_ID_EX_out <= Branch_ID_EX_in;
            RegWrite_ID_EX_out <= RegWrite_ID_EX_in;
            RegDst_ID_EX_out <= RegDst_ID_EX_in;
            MemRead_ID_EX_out <= MemRead_ID_EX_in;
            MemWrite_ID_EX_out <= MemWrite_ID_EX_in;
            MemtoReg_ID_EX_out <= MemtoReg_ID_EX_in;
            ALUSrc1_ID_EX_out <= ALUSrc1_ID_EX_in;
            ALUSrc2_ID_EX_out <= ALUSrc2_ID_EX_in;
            ALUOp_ID_EX_out <= ALUOp_ID_EX_in;
        end
    end

endmodule