module WB (
    input reset,
    input clk,

    input [31:0] IR,
    input [31:0] PC_plus_4,
    input [31:0] Memory_Read_Data,
    input [31:0] ALU_out,

    // Control signals
    input RegWrite,
    input [2 -1:0] RegDst,
    input [2 -1:0] MemtoReg,
    
    output [31:0] WriteBackData,
    output [4:0] WriteBackReg
);

    wire [31:0] _RegA, _RegB;
    assign WriteBackData = (MemtoReg == 2'b00)? ALU_out: (MemtoReg == 2'b01)? Memory_Read_Data: PC_plus_4;
    assign WriteBackReg = (RegDst == 2'b00)? IR[20:16]: (RegDst == 2'b01)? IR[15:11]: 5'b11111;

    RegisterFile RegisterFile_of_WB (
        .reset(reset),
        .clk(clk),
        .RegWrite(RegWrite),
        .Read_register1(IR[25:21]),
        .Read_register2(IR[20:16]),
        .Write_register(WriteBackReg),
        .Write_data(WriteBackData),
        .Read_data1(_RegA),
        .Read_data2(_RegB)
    )

endmodule