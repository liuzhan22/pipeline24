module EX_MEM (
    input reset,
    input clk,

    input [31:0] IR_EX_MEM_in,
    input [31:0] PC_plus_4_EX_MEM_in, // IR, PC+4 seems no use

    input [31:0] RegB_EX_MEM_in, // write data ($rt) for sw rt, offset(rs)
    input [31:0] PC_Add_EX_MEM_in,
    input Zero_EX_MEM_in,
    input [31:0] ALUout_EX_MEM_in,

    // Control signals used in the future
    input [2 -1:0] PCSrc_EX_MEM_in,
    input Branch_EX_MEM_in,
    input RegWrite_EX_MEM_in,
    input [2 -1:0] RegDst_EX_MEM_in,
    input MemRead_EX_MEM_in,
    input MemWrite_EX_MEM_in,
    input [2 -1:0] MemtoReg_EX_MEM_in,

    output reg [31:0] IR_EX_MEM_out,
    output reg [31:0] PC_plus_4_EX_MEM_out,

    output reg [31:0] RegB_EX_MEM_out,
    output reg [31:0] PC_Add_EX_MEM_out,
    output reg Zero_EX_MEM_out,
    output reg [31:0] ALUout_EX_MEM_out,

    output reg [2 -1:0] PCSrc_EX_MEM_out,
    output reg Branch_EX_MEM_out,
    output reg RegWrite_EX_MEM_out,
    output reg [2 -1:0] RegDst_EX_MEM_out,
    output reg MemRead_EX_MEM_out,
    output reg MemWrite_EX_MEM_out,
    output reg [2 -1:0] MemtoReg_EX_MEM_out
    
);

    always @(posedge reset or posedge clk) begin
        if (reset) begin
            IR_EX_MEM_out <= 32'd0;
            PC_plus_4_EX_MEM_out <= 32'd0;
            RegB_EX_MEM_out <= 32'd0;
            PC_Add_EX_MEM_out <= 32'd0;
            Zero_EX_MEM_out <= 1'd0;
            ALUout_EX_MEM_out <= 32'd0;
            PCSrc_EX_MEM_out <= 2'd0;
            Branch_EX_MEM_out <= 1'd0;
            RegWrite_EX_MEM_out <= 1'd0;
            RegDst_EX_MEM_out <= 2'd0;
            MemRead_EX_MEM_out <= 1'd0;
            MemWrite_EX_MEM_out <= 1'd0;
            MemtoReg_EX_MEM_out <= 2'd0;
        end else begin
            IR_EX_MEM_out <= IR_EX_MEM_in;
            PC_plus_4_EX_MEM_out <= PC_plus_4_EX_MEM_in;
            RegB_EX_MEM_out <= RegB_EX_MEM_in;
            PC_Add_EX_MEM_out <= PC_Add_EX_MEM_in;
            Zero_EX_MEM_out <= Zero_EX_MEM_in;
            ALUout_EX_MEM_out <= ALUout_EX_MEM_in;
            PCSrc_EX_MEM_out <= PCSrc_EX_MEM_in;
            Branch_EX_MEM_out <= Branch_EX_MEM_in;
            RegWrite_EX_MEM_out <= RegWrite_EX_MEM_in;
            RegDst_EX_MEM_out <= RegDst_EX_MEM_in;
            MemRead_EX_MEM_out <= MemRead_EX_MEM_in;
            MemWrite_EX_MEM_out <= MemWrite_EX_MEM_in;
            MemtoReg_EX_MEM_out <= MemtoReg_EX_MEM_in;
        end
    end

endmodule