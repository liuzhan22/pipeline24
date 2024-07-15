module scan_output(
    input wire clk_1K,
    input wire [3:0] count_1, // first display number on LED 
    input wire [3:0] count_2, // second display number on LED
    input wire [3:0] count_3, // third display number on LED
    input wire [3:0] count_4, // fourth display number on LED
    output reg [3:0] sel, // scan select signal
    output reg [6:0] leds // 7-segment display
);

    reg [1:0] scan_counter = 0;
    reg [6:0] led1;
    reg [6:0] led2;
    reg [6:0] led3;
    reg [6:0] led4;

    always @(posedge clk_1K) begin
        scan_counter <= scan_counter + 1;
    end

    hex2seg hex2seg1(
        .hex(count_1),
        .seg(led1)
    );

    hex2seg hex2seg2(
        .hex(count_2),
        .seg(led2)
    );

    hex2seg hex2seg3(
        .hex(count_3),
        .seg(led3)
    );

    hex2seg hex2seg4(
        .hex(count_4),
        .seg(led4)
    );

    always @* begin
        case(scan_counter)
            2'b00: begin
                sel = 4'b1000;
                leds <= led1;
            end
            2'b01: begin
                sel = 4'b0100;
                leds <= led2;
            end
            2'b10: begin
                sel = 4'b0010;
                leds <= led3;
            end
            2'b11: begin
                sel = 4'b0001;
                leds <= led4;
            end
        endcase
    end

endmodule