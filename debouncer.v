`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2019 01:06:06 PM
// Design Name: 
// Module Name: debouncer
// Project Name: 
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


module debouncer(en, clk, out);
input clk, en;
output reg out;
reg a, b, c;
always@(posedge clk)
begin
a <= en;
b <= a;
c <= b;
out <= a & b & c;
end
endmodule
