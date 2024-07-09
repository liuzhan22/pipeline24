module MEM (
    input reset,
    input clk,

    input [31:0] ALU_out, // which is the address in Data Memory
    input [31:0] RegB, // Data to be written to Data Memory

    // Control signals
    input MemRead,
    input MemWrite,

    output [31:0] Memory_Read_Data
);

    // Data Memory
    wire Memory_Read;
    wire Memory_Write;

    DataMemory data_memory1(
        .reset(reset),
        .clk(clk),
        .MemRead(Memory_Read),
        .MemWrite(Memory_Write),
        .Address(ALU_out),
        .Write_data(RegB),
        .Read_data(Memory_Read_Data)
    );

    assign Memory_Read = MemRead;
    assign Memory_Write = MemWrite;

endmodule