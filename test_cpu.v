`timescale 1ns/1ps

module test_cpu();

	reg reset;
	reg clk;
	reg finishExecution;

	wire [6:0] leds;
	wire [3:0] sel;

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
	reg MemReadforDisplay;
	reg [31:0] MemBus_Address_reg;
	
	CPU cpu1(  
		.reset              (reset              ), 
		.clk                (clk                ), 
		.Device_Read_Data   (Device_Read_Data   ), 

		.MemRead            (MemRead            ), 
		.MemWrite_origin    (MemWrite_origin    ),
		.MemBus_Address     (MemBus_Address     ),
		.MemBus_Write_Data  (MemBus_Write_Data  )
	);

	DataMemory data_memory1(
		.reset(reset),
		.clk(clk),
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

	initial begin
		reset   = 1;
		clk     = 1;
		MemReadforDisplay = 1'b0;
		finishExecution = 1'b0;
				
		#100 reset = 0;

	end
	
	always begin
		#50 clk = ~clk;
	end	

	initial begin
		#118600;
		finishExecution = 1'b1;
		MemReadforDisplay = 1'b1;
		MemBus_Address_reg = 32'h00000004;
		forever begin
			#1000000000 MemBus_Address_reg = MemBus_Address_reg + 32'h00000004;
		end
	end
endmodule
