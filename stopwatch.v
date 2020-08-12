`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2020 11:36:13 PM
// Design Name: 
// Module Name: stopwatch
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


module stopwatch(
input rst,
	input clk_1hz,
	input  pause,
	output reg [3:0]small_second,
	output reg [2:0]big_second
    );
    //count accordingly for big and small seconds and minutes when not paused
	always@ (posedge clk_1hz or posedge rst) begin 
		if(rst == 1) begin
			small_second= 4'b0000;
			big_second =3'b000;
		end 
		else if(pause == 0) begin
			if(small_second==4'b1001)begin 
				if(big_second == 3) begin
					big_second = 3'b000;	
				end
				else begin
					big_second = big_second + 1;
					small_second = 4'b0000;
				end
			end
			else
				small_second = small_second + 1;
		end
	end
endmodule
