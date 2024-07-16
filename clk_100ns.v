module clk_100ns (
    input reset,
    input clk,
    output clk_100ns
);

    reg clk_100ns;
    parameter CNT = 16'd5;
    reg [15:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            clk_100ns <= 1'b0;
            count <= 16'd0;
        end else begin
            count <= (count == CNT - 16'd1) ? 16'd0 : count + 16'd1;
            clk_100ns <= (count == 16'd0) ? ~clk_100ns : clk_100ns;
        end
    end

endmodule