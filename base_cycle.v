`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2019 12:26:47 PM
// Design Name: 
// Module Name: basy_cycle
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2019 02:37:27 PM
// Design Name: 
// Module Name: base_cycle
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


/*

Light index:
0 = NaN (light off)
1 = green
2 = yellow
3 = red

*/

/*

(MAIN LIGHT IS ALWAYS UPPERCASE AND SIDE LIGHT IS ALWAYS LOWERCASE)

Base cycle:
G_r -> Y_r -> R_g -> R_y -> G_r





state index:
0 = GREEN, yellow
1 = YELLOW, red
2 = RED, green
3 = RED, yellow
4 = RED, red

*/

module basic_cycle(input clk, input reset, input sensor, input walk, /*output reg [1:0]main_light, output reg [1:0]side_light,*/ output reg walk_light, output reg [6:0]to_seg, output reg [3:0]lights_on, output reg refresh);
	
	reg [2:0] cur_state;
	reg [3:0] counter;
	
	reg [1:0]main_light;
	reg [1:0]side_light;
	
	reg sen_flag;
	reg walk_req;
	reg [3:0]main_wait;
	reg [3:0]side_wait;
	
	parameter nan = 4'b0;
	parameter green = 4'b1;
	parameter yel = 4'd2;
	parameter red = 4'd3;

	parameter G_r = 4'd0;
	parameter Y_r = 4'd1;
	parameter R_g = 4'd2;
	parameter R_y = 4'd3;
	parameter R_r = 4'd4;
	
	reg [3:0]tbase;
    reg [3:0]text;
    reg [3:0]tyel;
    
    reg [6:0]main_to_seg;
    reg [6:0]side_to_seg;
    
    //reg refresh;
    wire clk_out;
    wire clk_out_2;
//    wire clk_out_2;
    clockDivider pp (clk, rst, clk_out);
    clock_div_2 qq (clk, rst, clk_out_2);
    debouncer pb(clk, en, out);
    always @(posedge clk_out_2) begin
        
//        refresh <= ~refresh;
      
        case (refresh)
                1'b0 : begin 
                        lights_on <= 4'b0111; //isnt this to seg
                        to_seg <= main_to_seg;
                        refresh <= 1'b1;
                       end
                1'b1 : begin
                        lights_on <= 4'b1110;
                        to_seg <= side_to_seg;
                        refresh <= 1'b0;
                       end
        endcase
        
        case (main_light)
            2'b00 : main_to_seg <= 7'b0000001;
            2'b01 : main_to_seg <= 7'b0010000;
            2'b10 : main_to_seg <= 7'b1011000;
            2'b11 : main_to_seg <= 7'b0111001; 
        endcase
        
        case (side_light)
            2'b00 : side_to_seg <= 7'b0000001;
            2'b01 : side_to_seg <= 7'b0010000;
            2'b10 : side_to_seg <= 7'b1011000;
            2'b11 : side_to_seg <= 7'b0001000; 
        endcase
        
    end
	always @(posedge clk_out) begin
		counter <= counter + 1;
		 
        if (reset) begin
		   tbase <= 4'd6;
		   text <= 4'd3;
		   tyel  <= 4'd2;
		   refresh <= 1'b0;
		   cur_state <= R_y;
		   main_light <= 2'b0;
		   side_light <= 2'b0;
		   counter <= 4'b0;
		   main_wait <= 2 * tbase;
		   side_wait <= tbase;
		   walk_light <= 1'b0;
		   walk_req <= 1'b0;
		end
		     
		     if (walk & ~R_r) begin
		        walk_req <= 1'b1;
		     end
		     
		    if (sensor & G_r & counter == tbase) begin
                sen_flag <= 1'b1;
                main_wait <= tbase + text;
            end
            
            if (sensor & R_g & counter == tbase) begin
                sen_flag <= 1'b1;
                side_wait <= tbase + text;
            end
            if (sen_flag) begin
                sen_flag <= 1'b0;
                main_wait <= 2 * tbase;
                side_wait <= tbase;
                end
            
            
			case(cur_state)
				G_r: 
					if (counter == main_wait) begin
						counter <= 4'b0;
						cur_state <= Y_r;
						main_light <= yel;
						side_light <= red;
					end
				Y_r:
					if (counter == tyel) begin
						counter <= 4'b0;
						if (~walk_req) begin
                            cur_state <= R_g;
                            main_light <= red;
                            side_light <= green;
						end else begin
						    cur_state <= R_r;
						    main_light <= red;
						    side_light <= red;
						    walk_req <= 1'b0;
						    walk_light <= 1'b1;
						end
					end
				R_g:
					if (counter == side_wait) begin
						counter <= 4'b0;
						cur_state <= R_y;
						main_light <= red;
						side_light <= yel;
					end
				R_y:
					if (counter == tyel) begin
						counter <= 4'b0;
						cur_state <= G_r;
						main_light <= green;
						side_light <= red;
					end
			    R_r:
			        if (counter == text) begin
			            counter <= 4'b0;
			            cur_state <= R_g;
			            walk_req <= 1'b0;
			            main_light <= red;
			            side_light <= green;
			            walk_light <= 1'b0;
			        end
			endcase 
	end
endmodule
