`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 04:36:57 PM
// Design Name: 
// Module Name: simulation
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


module simulation();
 reg clk;
 reg reset; 
 reg sensor; 
 reg walk;
 wire  [1:0]main_light; 
 wire  [1:0]side_light; 
 wire  walk_light;


 basic_cycle sim( clk,  reset,  sensor,  walk,  main_light,  side_light,  walk_light);
  
  initial begin 
 clk=0;
 forever #5 clk=~clk;
 end
 initial begin
 reset=1;
 sensor = 1;
 walk = 0;
 #20;
 reset=0;
 sensor = 0;
 walk = 1;
 end
endmodule
  

