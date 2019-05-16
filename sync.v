`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2019 01:14:44 PM
// Design Name: 
// Module Name: sync
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


module sync(input sig, input clk, input rst, output reg sig2);
reg meta;
always @(posedge clk or negedge rst) begin
if(rst)
begin
meta <= 1'b0;
sig2 <= 1'b0;
end
else
begin
meta <= sig;
sig2 <= meta;
end 
end
endmodule
