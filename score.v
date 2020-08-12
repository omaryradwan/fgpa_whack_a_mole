`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:04 03/06/2020 
// Design Name: 
// Module Name:    score 
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
module score(
    output reg [3:0] big_score,
    output reg [3:0]small_score,
	
	 input rst,
	 input pause,
	input [7:0] switch,
	input [7:0] led,
	input clk_lev,
	input clk,
	output check_switch

    );
		
	//assign big_score = 2;
	//assign small_score = 1;
	//wire check_switch;
	reg [7:0] temp_switch;
	reg change_detect;
	always @(*) begin
	if(rst) begin
	   change_detect = 0;
	   temp_switch = 0;
	  end
		if(temp_switch != switch) begin
			change_detect = ~change_detect;
			temp_switch = switch;
		end
		
	end
	
	

	reg led_state;
	always @(led) begin
	   if(rst) led_state = 0;
	   else begin
	       led_state = ~led_state;
	   end
	   
	end
	reg switch_state;
	always @(switch) begin
	   if(rst) switch_state = 0;
	   if(switch != 0) begin
	       switch_state = 1;
       end
	   else switch_state = 0;
	   
	   
	end

	reg clk_95;
	reg [9:0] clk_95_cntr;
	always @(posedge clk) begin
		if(rst) begin
			clk_95 <= 0;
			clk_95_cntr <= 0;
		end
		if(clk_95_cntr == 96) begin
			clk_95 <= ~clk_95;
			clk_95_cntr <= 0;
		end
		else clk_95_cntr <= clk_95_cntr + 1;
	end
	
	
	reg [7:0] inst_wd[7:0];
	reg [2:0] step_d[7:0];
	reg is_switch[7:0];
	reg inst_vld[7:0];
	reg clk_en;
	wire [17:0] clk_dv_inc;
	reg [16:0] clk_dv;
	reg clk_en_d;
	reg [7:0]   inst_cnt[7:0];
	assign clk_dv_inc = clk_dv + 1;
   
	always @ (posedge clk)
		if (rst)
		begin
         clk_dv   <= 0;
         clk_en   <= 1'b0;
         clk_en_d <= 1'b0;
		end
		else
		begin
         clk_dv   <= clk_dv_inc[16:0];
         clk_en   <= clk_dv_inc[17];
         clk_en_d <= clk_en;
		end
		reg [3:0]i;
	
	always @ (posedge clk) begin
		for( i = 0; i < 8; i = i + 1) begin
			if (rst)
			begin
          inst_wd[i] <= 8'b0;
          step_d[i]  <= 3'b0;
			end
			else if (clk_en) // Down sampling
			begin
          inst_wd[i] <= switch[7:0];
          step_d[i] <= {switch[i], step_d[i][2],step_d[i][1]};
			end
		end
	end
	
	
	always @(posedge clk) begin
		 is_switch[0] = ~ step_d[0][0] & step_d[0][1];
		 is_switch[1] = ~ step_d[1][0] & step_d[1][1];
		 is_switch[2] = ~ step_d[2][0] & step_d[2][1];
		 is_switch[3] = ~ step_d[3][0] & step_d[3][1];
		 is_switch[4] = ~ step_d[4][0] & step_d[4][1];
		 is_switch[5] = ~ step_d[5][0] & step_d[5][1];
		 is_switch[6] = ~ step_d[6][0] & step_d[6][1];
		 is_switch[7] = ~ step_d[7][0] & step_d[7][1];
	end


	always @ (posedge clk) begin
		for(reg [3:0]k = 0; k < 8; k = k + 1) begin			
			if (rst)
				inst_vld[k] <= 1'b0;
			else if (clk_en_d)
				inst_vld[k] <= is_switch[k];
			else
				inst_vld[k] <= 0;
		end
	end
	reg [3:0] l;
	always @ (posedge clk) begin
		for(l = 0; l < 8; l = l + 1) begin			
			if (rst)
				inst_cnt[l] <= 0;
			else if (inst_vld[l])
				inst_cnt[l] <= inst_cnt[l] + 1;
		end
   end
	
	 
	

	//reg [8:0]count = 95;
	reg [8:0]count1;
	initial count1 = 0;
	assign check_switch = is_switch[0] ^ is_switch[1] ^ is_switch[2] ^ is_switch[3] ^ is_switch[4] ^ is_switch[5] ^ is_switch[6] ^ is_switch[7];
	always @(posedge clk) begin ///add rst	
		
		if (rst) begin
			big_score = 0;
			small_score = 0;
		end
		if(pause == 0) begin
		//if(check_switch == 1) begin
		//////////////
			if(is_switch[0] == 1 && led[0] == 1) begin 
				if(small_score == 9) begin
					big_score = big_score+1;
					small_score = 0;
				end
				else small_score= small_score + 1;
				if(big_score == 9 && small_score == 9)begin
					big_score = 0;
					small_score =0;
				end
			end
			//////////////////
			 if(is_switch[1] == 1 && led[1] == 1) begin 
				if(small_score == 9) begin
					big_score = big_score+1;
					small_score = 0;
				end
				else small_score = small_score + 1;
				if(big_score == 9 && small_score == 9)begin
					big_score = 0;
					small_score =0;
				end
			end
			//////////////////
			 if(is_switch[2] == 1 && led[2] == 1) begin 
				if(small_score == 9) begin
					big_score = big_score+1;
					small_score = 0;
				end
				else small_score = small_score + 1;
				if(big_score == 9 && small_score == 9)begin
					big_score = 0;
					small_score =0;
				end
			end
			//////////////////
			 if(is_switch[3] == 1 && led[3] == 1) begin 
				if(small_score == 9) begin
					big_score = big_score+1;
					small_score = 0;
				end
				else small_score = small_score + 1;
				if(big_score == 9 && small_score == 9)begin
					big_score = 0;
					small_score =0;
				end
			end
			//////////////////
			 if(is_switch[4] == 1 && led[4] == 1) begin 
				if(small_score == 9) begin
					big_score = big_score+1;
					small_score = 0;
				end
				else small_score = small_score + 1;
				if(big_score == 9 && small_score == 9)begin
					big_score = 0;
					small_score =0;
				end
			end
			//////////////////
			 if(is_switch[5] == 1 && led[5] == 1) begin 
				if(small_score == 9) begin
					big_score = big_score+1;
					small_score = 0;
				end
				else small_score = small_score + 1;
				if(big_score == 9 && small_score == 9)begin
					big_score = 0;
					small_score =0;
				end
			end
			//////////////////
			 if(is_switch[6] == 1 && led[6] == 1) begin 
				if(small_score == 9) begin
					big_score = big_score+1;
					small_score = 0;
				end
				else small_score = small_score + 1;
				if(big_score == 9 && small_score == 9)begin
					big_score = 0;
					small_score =0;
				end
			end
			//////////////////
			 if(is_switch[7] == 1 && led[7] == 1) begin 
				if(small_score == 9) begin
					big_score = big_score+1;
					small_score = 0;
				end
				else small_score= small_score + 1;
				if(big_score == 9 && small_score == 9)begin
					big_score = 0;
					small_score =0;
				end
			end
			
			//////////////////
		//end
			//else  if(change_detect == 1 && check_switch == 0)begin 
			// big_score = 0;
			// small_score = 0;
			 //end
		end
		
	end
	
	
endmodule
