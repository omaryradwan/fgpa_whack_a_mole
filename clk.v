`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2020 11:36:13 PM
// Design Name: 
// Module Name: clk
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk(
input clk_orig,
	 input rst,
    output reg clk_1hz,
    output  reg clk_lev,
    output reg clk_screen, 
	 output reg clk_small,
	 input lev
    );
    
     reg [27:0] clk_cntr_1hz;
	// reg [25:0] clk_cntr_lev1;
	 reg [25:0] clk_cntr_screen;
	 reg [27:0] clk_cntr_small;



	//lev2 clk output
	//assign clk_lev2 = clk_orig;
	//assign clk_lev1 = clk_orig;
	//assign clk_lev3 = clk_orig;
	//////change this!
	
	 //1HZ clk output
	always @(posedge clk_orig) 
	begin
		if(rst) begin
			clk_cntr_1hz <= 0;
			clk_1hz <= 0;
		end
		else if(clk_cntr_1hz == 	(100000000 - 1))
		begin
			clk_1hz <= 1;
			clk_cntr_1hz <= 0;
		end
		else begin 
			clk_cntr_1hz <= clk_cntr_1hz + 1;
		   clk_1hz <= 0;
		end
	end

		//small clk counter: 100MHZ
	always @(posedge clk_orig) 
	begin
		if(rst) begin
			clk_cntr_small <= 0;
			clk_small <= 0;
		end
		else if(clk_cntr_small == 	(50000 - 1))
		begin
			clk_small <= ~clk_small;
			clk_cntr_small <= 0;
		end
		else clk_cntr_small <= clk_cntr_small + 1;
	end
	
	//clk for screen, .1Hz
	always @(posedge clk_orig) 
	begin
		if(rst) begin
			clk_cntr_screen <= 0;
			clk_screen <= 0;
		end
		else if(clk_cntr_screen == 	(500000000 - 1))
		begin
			clk_screen <= ~clk_screen;
			clk_cntr_screen <= 0;
		end
		else clk_cntr_screen <= clk_cntr_screen + 1;

	end
	
	reg [28:0] lev1_val = 300000000;
	reg [28:0] lev2_val = 200000000;
	reg [28:0] lev3_val = 100000000;
	reg [1:0] lev_toggle;
	initial lev_toggle = 0;
	reg [28:0] clk_cntr;
	initial clk_cntr = lev1_val;
	always @(posedge lev) begin
	   if(lev_toggle != 2) lev_toggle = lev_toggle + 1;
	   else lev_toggle = 0;
	   if(lev_toggle == 0) clk_cntr = lev1_val;
	   if(lev_toggle == 1) clk_cntr = lev2_val;
	   if(lev_toggle == 2) clk_cntr = lev3_val;
	end
	   
	reg [28:0] clk_cntr_lev;
	always @(posedge clk_orig) 
	begin
		if(rst) begin
			clk_cntr_lev <= 0;
			clk_lev <= 0;
		end
		else if(clk_cntr_lev == 	(clk_cntr - 1))
		begin
			clk_lev <= ~clk_lev;
			clk_cntr_lev <= 0;
		end
		else clk_cntr_lev <= clk_cntr_lev + 1;

	end
	

endmodule
