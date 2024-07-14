module Load_use_hazard (
    input reset,
    input clk,

    input MemRead_ID_EX_out,
    input [31:0] IR_ID_EX_out,
    input [31:0] IR_IF_ID_out,

    output load_use_hazard,
    output IF_ID_stall,
    output ID_EX_stall
);

    assign load_use_hazard = (MemRead_ID_EX_out == 1) && ( (IR_ID_EX_out[20:16] == IR_IF_ID_out[25:21]) || (IR_ID_EX_out[20:16] == IR_IF_ID_out[20:16]) );
    assign IF_ID_stall = (MemRead_ID_EX_out == 1) && ( (IR_ID_EX_out[20:16] == IR_IF_ID_out[25:21]) || (IR_ID_EX_out[20:16] == IR_IF_ID_out[20:16]) );
    assign ID_EX_stall = (MemRead_ID_EX_out == 1) && ( (IR_ID_EX_out[20:16] == IR_IF_ID_out[25:21]) || (IR_ID_EX_out[20:16] == IR_IF_ID_out[20:16]) );

endmodule