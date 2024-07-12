module ForwardingUnit (
    input reset, 
    input clk,

    input [31:0] IR_ID_EX_out,

    input [31:0] RegA_ID_EX_out,
    input [31:0] RegB_ID_EX_out,

    input [31:0] IR_EX_MEM_out,
    input [31:0] IR_MEM_WB_out,

    input RegWrite_EX_MEM_out,
    input [2 -1:0] RegDst_EX_MEM_out,

    input RegWrite_MEM_WB_out,
    input [2 -1:0] RegDst_MEM_WB_out,

    output [1:0] ForwardA,
    output [1:0] ForwardB
);

    wire [4:0] EX_MEM_RegWrAddr;
    wire [4:0] MEM_WB_RegWrAddr;

    assign EX_MEM_RegWrAddr = (RegDst_EX_MEM_out == 2'b00) ? IR_EX_MEM_out[20:16] : (RegDst_EX_MEM_out == 2'b01) ? IR_EX_MEM_out[15:11] : 5'b11111;
    assign MEM_WB_RegWrAddr = (RegDst_MEM_WB_out == 2'b00) ? IR_MEM_WB_out[20:16] : (RegDst_MEM_WB_out == 2'b01) ? IR_MEM_WB_out[15:11] : 5'b11111;

    wire [4:0] ID_EX_RegisterRs;
    wire [4:0] ID_EX_RegisterRt;

    assign ID_EX_RegisterRs = IR_ID_EX_out[25:21];
    assign ID_EX_RegisterRt = IR_ID_EX_out[20:16];

    assign ForwardA = (RegWrite_EX_MEM_out && (EX_MEM_RegWrAddr != 5'd0) && (EX_MEM_RegWrAddr == ID_EX_RegisterRs)) ? 2'b10 : 
                      (RegWrite_MEM_WB_out && (MEM_WB_RegWrAddr != 5'd0) && (MEM_WB_RegWrAddr == ID_EX_RegisterRs) && ((EX_MEM_RegWrAddr != ID_EX_RegisterRs) || ~RegWrite_EX_MEM_out)) ? 2'b01 : 2'b00;

    assign ForwardB = (RegWrite_EX_MEM_out && (EX_MEM_RegWrAddr != 5'd0) && (EX_MEM_RegWrAddr == ID_EX_RegisterRt)) ? 2'b10 :
                      (RegWrite_MEM_WB_out && (MEM_WB_RegWrAddr != 5'd0) && (MEM_WB_RegWrAddr == ID_EX_RegisterRt) && ((EX_MEM_RegWrAddr != ID_EX_RegisterRt) || ~RegWrite_EX_MEM_out)) ? 2'b01 : 2'b00;

endmodule