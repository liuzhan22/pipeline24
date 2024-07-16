module top(
    input clk,
    output [3:0] sel,
    output [6:0] leds
);

	reg reset;
	reg finishExecution;
    reg ShowNext;

	wire [31:0] Device_Read_Data;

	wire MemRead;
	wire MemWrite_origin;
	wire [31:0] MemBus_Address;
	wire [31:0] MemBus_Write_Data;
	wire [31:0] MemRead_Data;
	wire [3:0] count1;
	wire [3:0] count2;
	wire [3:0] count3;
	wire [3:0] count4;
	wire clk_1k;
    wire clk_100ns;
	reg MemReadforDisplay;
	reg [31:0] MemBus_Address_reg;
	
	CPU cpu1(  
		.reset              (reset              ), 
		.clk                (clk_100ns          ), 
		.Device_Read_Data   (Device_Read_Data   ), 

		.MemRead            (MemRead            ), 
		.MemWrite_origin    (MemWrite_origin    ),
		.MemBus_Address     (MemBus_Address     ),
		.MemBus_Write_Data  (MemBus_Write_Data  )
	);

	DataMemory data_memory1(
		.reset(reset),
		.clk(clk_100ns),
		.MemRead(MemReadforDisplay),
		.MemWrite(MemWrite_origin),
		.Address(finishExecution ? MemBus_Address_reg : MemBus_Address),
		.Write_data(MemBus_Write_Data),
		.Read_data(MemRead_Data)
	);

	clk_1k clk_1k1(
		.reset(reset),
		.clk(clk),
		.clk_1K(clk_1k)
	);

    clk_100ns clk_100ns1(
        .reset(reset),
        .clk(clk),
        .clk_100ns(clk_100ns)
    );
	
	assign count1 = MemRead_Data[15:12];
	assign count2 = MemRead_Data[11:8];
	assign count3 = MemRead_Data[7:4];
	assign count4 = MemRead_Data[3:0];

	scan_output scan_output1(
	    .clk_1K(clk_1k),
		.count_1(count1),
		.count_2(count2),
		.count_3(count3),
		.count_4(count4),
		.sel(sel),
		.leds(leds)
	);

    always @(posedge clk or posedge reset or posedge ShowNext) begin
        if (reset) begin
            reset <= 1;
            MemReadforDisplay <= 0;
            finishExecution <= 0;
        end else if (finishExecution) begin
            MemReadforDisplay <= 1;
            MemBus_Address_reg <= 32'h00000004;
        end else if (ShowNext) begin
            MemBus_Address_reg <= MemBus_Address_reg + 32'h00000004;
        end
    end

endmodule