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


module sync(input w, input clk, input rst, output z);
    reg [1:0] state, nextState;
    
    parameter [1:0] zero=2'b00, edg=2'b01, one=2'b10; // States Encoding
    // Next state generation
    always @ (w or state)
        case (state)
            zero: if (w) nextState = edg;
             else nextState = zero;
            edg: if (w) nextState = one;
             else nextState = zero;
            one: if (w) nextState = one;
             else nextState = zero;
        endcase
    // Update state FF's with the triggering edge of the clock
    always @ (posedge clk or negedge rst) begin
        if(rst)
            state <= zero;
        else
            state <= nextState;
    end
    assign z = (state == edg); // output generation
endmodule
