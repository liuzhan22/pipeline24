module IF_ID (
    input reset, 
    input clk, 

    input IF_ID_flush,

    input [31:0] PC_plus_4, // this may be used by beq, when calculating PC+4+BranchAddr
    input [31:0] IR,

    output reg [31:0] PC_plus_4_IF_ID_out,
    output reg [31:0] IR_IF_ID_out
);

    always @(posedge reset or posedge clk) begin
        if(reset) begin
            PC_plus_4_IF_ID_out <= 32'd0;
            IR_IF_ID_out <= 32'd0;
        end
        else if (IF_ID_flush) begin
            PC_plus_4_IF_ID_out <= 32'd0;
            IR_IF_ID_out <= 32'd0;
        end
        else begin
            PC_plus_4_IF_ID_out <= PC_plus_4;
            IR_IF_ID_out <= IR;
        end
    end

endmodule