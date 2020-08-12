`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2020 11:36:13 PM
// Design Name: 
// Module Name: display
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


module display(
input clk_orig,
    input clk_small,
    input clk_1hz,
	 input rst,
	 input pause,
	 output reg[7:0]seg,
	 output reg [3:0]an,
	 input clk_lev,
	 input [7:0] switch,
	input [7:0] led,
	output check_switch
    );
    
     wire [3:0] small_second;
	 wire [2:0] big_second;
	 wire [3:0] small_score;
	 wire [3:0] big_score; 
	 

		
stopwatch stopwatch_ (
	.rst(rst),
	.clk_1hz(clk_1hz), 
	.pause(pause),
	.small_second(small_second),
	.big_second(big_second)
);

score score_(
	.small_score(small_score),
	.big_score(big_score),
	.clk_lev(clk_lev),
	.rst(rst),
	.pause (pause),
	.led(led),
	.switch(switch),
	.clk(clk_orig),
	.check_switch(check_switch)
);
	
	reg [3:0] display;
	
	
	
	//toggles through all led spots quickly - also implement blinking
	always @(posedge clk_small) begin
		if(pause == 0) begin
			if(rst) begin
				an <= 4'b1110;
				display <=small_second;
			end
			else if(an == 4'b1110)begin
				an <= 4'b1101;
				display <= {1'b0,big_second};
			end
			else if (an==4'b1101)begin
				an <= 4'b1011;
				display <= small_score;
			end
			else if (an==4'b1011)begin
				an <= 4'b0111;
				display <= big_score;					
			end
			else begin
				an <= 4'b1110;
				display <= small_second;
			end
		end
	end

	//set output to correct number configuration
	always @(*) begin
		case (display) 
			0: seg = 8'b11000000;
			1: seg = 8'b11111001;
 			2: seg = 8'b10100100;
			3: seg = 8'b10110000;
			4: seg = 8'b10011001;
			5: seg = 8'b10010010;
			6: seg = 8'b10000010;
			7: seg = 8'b11111000;
			8: seg = 8'b10000000;
			9: seg = 8'b10010000;
			default:
				seg = 8'b11111111;
		endcase
	end
		
endmodule
