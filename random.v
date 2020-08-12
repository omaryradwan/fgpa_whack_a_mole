`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:55 03/06/2020 
// Design Name: 
// Module Name:    random 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module random(
    input clk_lev,
	 output reg[7:0] led
    );

	reg [2:0] random = 0;
	reg tmp;
	
	always @(posedge clk_lev) begin
		tmp = ((random[0] & random[1]) ^ ~(random[2]^ random[1]));
		random = {random[1:0], tmp};
		//else random =0;
	end
	
	always @(*) begin
		case(random)
			0: led = 8'b00000001;
			1: led = 8'b00000010;
			2: led = 8'b00000100;
			3: led = 8'b00001000;
			4: led = 8'b00010000;
			5: led = 8'b00100000;
			6: led = 8'b01000000;
			7: led = 8'b10000000;
			8: led = 8'b00000000;
		endcase
	end
	
	

endmodule
