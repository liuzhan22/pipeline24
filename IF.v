module IF (
    input reset,
    input clk,
    
    input [31:0] PC,
    output reg [31:0] PC_plus_4, // calculate PC+4 in IF stage
    output reg [31:0] PC_keep, // keep PC for load-use hazard
    output [31:0] IR // Instruction fetched
);

    reg [31:0] PC_now; 
    always @(posedge reset or posedge clk) begin
        if(reset) begin
            PC_now <= 32'h00400000;
            PC_keep <= 32'h00400000;
            PC_plus_4 <= 32'h00400004;
        end
        else begin
            PC_now <= PC;
            PC_keep <= PC;
            PC_plus_4 <= PC + 32'h00000004;
        end
    end

    InstructionMemory instruction_fetch(
        .Address(PC_now),
        .Instruction(IR)
    );

endmodule