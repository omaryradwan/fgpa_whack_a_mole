`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2020 11:01:18 PM
// Design Name: 
// Module Name: testbench
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


module testbench();
    reg clk;
    reg lev;
    reg [7:0] sw;
    reg rst;
    reg pause;
    wire [7:0] seg;
    wire [3:0] an;
    wire [7:0] led;
   
    main main_(
        .clk(clk),
        .sw(sw),
        .rst(rst),
        .pause(pause),
        .seg(seg),
        .an(an),
        .led(led),
        .lev(lev)
    );
    initial begin
        clk = 0;
        sw = 0;
        pause = 0;
        lev = 0;
        rst = 1;
        #200 rst = 0;
        
    end
    always begin
        #01
        clk <= ~clk;
    end
    reg  [3:0] cntr;
    initial cntr = 0;
    always @(*) begin
        sw = 0;
        #40
        
        if(cntr == 4) sw = 0;
        else if(cntr != 0) sw = led;        
        else sw = 00001000;
        
        cntr = cntr + 1;
        #40
        sw = 0;
      
    end
        
   /* always begin
        #20000000
        lev = ~lev;
        #1
        lev = ~lev;
    end*/
endmodule
