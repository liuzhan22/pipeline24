module IF (
    input reset,
    input clk,
    input [31:0] PC,
    output reg [31:0] PC_plus_4, // calculate PC+4 in IF stage
    output [31:0] IR // Instruction fetched
);
    reg [31:0] PC_now; 
    always @(posedge reset or posedge clk)
        if(reset) begin
            PC_now <= 32'h00000000;
            PC_plus_4 <= 32'h00000004;
        end
        else begin
            PC_now <= PC;
            PC_plus_4 <= PC + 32'h00000004;
        end

    InstructionMemory instruction_fetch(
        .Address(PC_now),
        .Instruction(IR)
    )

endmodule