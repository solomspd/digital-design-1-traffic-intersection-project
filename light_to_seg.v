`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2019 01:58:05 PM
// Design Name: 
// Module Name: light_to_seg
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


module light_to_seg(input [1:0]in, output reg [6:0]out);

always @(in) begin
    case (in) 
        2'b00 : out <= 7'b0000001;
        2'b01 : out <= 7'b0010000;
        2'b10 : out <= 7'b0001000;
        2'b11 : out <= 7'b1011000; 
    endcase
end

endmodule
