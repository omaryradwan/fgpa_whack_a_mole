`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2020 11:36:13 PM
// Design Name: 
// Module Name: main
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


module main(
    output [7:0] led,
    input [7:0] sw,
    output [3:0] an,
    input rst,
    input pause,
    output [7:0] seg,
    input clk,
    input lev
    );
    	 //for clock parse
    wire clk_1hz;
    wire  clk_lev;
    wire clk_screen;
	 wire clk_small;
	wire pause_state;//= 0;
	wire check_switch;
	wire pause_1;
	reg [1:0] pause_ff;
	assign pause_1 = pause;
	assign pause_state = pause_ff[0];
	always@(posedge clk or posedge pause_1) begin
		if(pause_1) pause_ff <= 2'b11;
		else pause_ff <= {1'b0,pause_ff[1]};
	end
	
	wire lev_1;
	reg [1:0] lev_ff;
	assign lev_1 = lev;
	assign lev_state = lev_ff[0];
	always@(posedge clk or posedge lev_1) begin
		if(lev_1) lev_ff <= 2'b11;
		else lev_ff <= {1'b0,lev_ff[1]};
	end

	
	
	
	
	
	
	
display display_ (
	.clk_orig(clk),
	.clk_small(clk_small),
	.clk_1hz(clk_1hz),
	.rst(rst),
	.pause(pause_state),
	.seg(seg),
	.an(an),
	
	.clk_lev(clk_lev),
.switch(sw),
.led(led),
.check_switch(check_switch)	//Hard coded change later
);

random random_ (
	.led(led),
	.clk_lev(clk_lev)
);
	 
clk clk_ (
	.clk_orig(clk), 
	.rst(rst),
	.clk_1hz(clk_1hz),
	.clk_lev(clk_lev),
	.clk_screen(clk_screen),
	.clk_small(clk_small),
	.lev(lev_state)
);

endmodule
