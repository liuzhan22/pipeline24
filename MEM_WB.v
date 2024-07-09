module MEM_WB (
    input reset,
    input clk,

    input [31:0] IR_MEM_WB_in,
    input [31:0] PC_plus_4_MEM_WB_in, // these two seems no use

    input [31:0] Memory_Read_Data_MEM_WB_in,
    input [31:0] ALU_out_MEM_WB_in,

    // Contorl signals
    input [2 -1:0] PCSrc_MEM_WB_in,
    input Branch_MEM_WB_in,
    input RegWrite_MEM_WB_in,
    input [2 -1:0] RegDst_MEM_WB_in, // where to write
    input [2 -1:0] MemtoReg_MEM_WB_in, // what to write

    output reg [31:0] IR_MEM_WB_out,
    output reg [31:0] PC_plus_4_MEM_WB_out,
    output reg [31:0] Memory_Read_Data_MEM_WB_out,
    output reg [31:0] ALU_out_MEM_WB_out,

    output reg [2 -1:0] PCSrc_MEM_WB_out,
    output reg Branch_MEM_WB_out,
    output reg RegWrite_MEM_WB_out,
    output reg [2 -1:0] RegDst_MEM_WB_out,
    output reg [2 -1:0] MemtoReg_MEM_WB_out

);

    always @(posedge reset or posedge clk) begin
        if (reset) begin
            IR_MEM_WB_out <= 32'd0;
            PC_plus_4_MEM_WB_out <= 32'd0;
            Memory_Read_Data_MEM_WB_out <= 32'd0;
            ALU_out_MEM_WB_out <= 32'd0;
            PCSrc_MEM_WB_out <= 2'd0;
            Branch_MEM_WB_out <= 1'd0;
            RegWrite_MEM_WB_out <= 1'd0;
            RegDst_MEM_WB_out <= 2'd0;
            MemtoReg_MEM_WB_out <= 2'd0;
        end
        else begin
            IR_MEM_WB_out <= IR_MEM_WB_in;
            PC_plus_4_MEM_WB_out <= PC_plus_4_MEM_WB_in;
            Memory_Read_Data_MEM_WB_out <= Memory_Read_Data_MEM_WB_in;
            ALU_out_MEM_WB_out <= ALU_out_MEM_WB_in;
            PCSrc_MEM_WB_out <= PCSrc_MEM_WB_in;
            Branch_MEM_WB_out <= Branch_MEM_WB_in;
            RegWrite_MEM_WB_out <= RegWrite_MEM_WB_in;
            RegDst_MEM_WB_out <= RegDst_MEM_WB_in;
            MemtoReg_MEM_WB_out <= MemtoReg_MEM_WB_in;
        end
    end

endmodule