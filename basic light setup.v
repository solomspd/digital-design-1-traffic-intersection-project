


/*

light index:
0 = yellow
1 = green

*/


module main_lights #(parameter tbase = 6) #(parameter tyel = 2) #(parameter text = 3) (input clk, reset, output reg light);
	reg [3:0]count
	always (posedge clk)
		if (reset) begin
			light = 0;
			count = 4'b0;
		end else begin
			count = count + 1;
			case (light)
				2'd0 : if (count == tyel) count = 4'b0; light = 2'd1;
				2'd1 : if (count == 2 * tbase) count = 4'b0; light = 0;
			endcase
		end		
	end
endmodule




module side_lights #(parameter tbase = 6) #(parameter tyel = 2) #(parameter text = 3) (input clk, reset, sensor, output reg ight);
	reg [3:0]count
	always (posedge clk)
		if (reset) begin
			light = 0;
			count = 4'b0;
		end else begin
			count = count + 1;
			case (light)
				2'd0 : if (count == tyel) count = 4'b0; light = 2'd3;
				2'd1 : if (count == tbase) count = 4'b0; light = 0;
			endcase
		end		
	end
endmodule




/*

light index:
0 = NaN (light off)
1 = red
2 = yellow
3 = green

*/


module main (input clk, reset, sensor, output reg [1:0]main_light_out,[1:0]side_light_out);
	reg main_light;
	reg side_light;
	reg main_r;
	reg side_r;
	main_light main_l (clk, main_r, main_light);
	side_light side_l (clk, side_r, sensor, side_light);
	always (posedge clk)
		main_r = 0;
		side_r = 0;
		if (reset) begin
			main_r = 1;
			side_r = 1;
			main_light_out = 2'b0;
			side_light_out = 2'b0;
		end else if (main_light) begin
			main_light_out = 2'b3;
			side_light_out = 2'b1;
		end else if (side_light) begin
			main_light_out = 2'b1;
			side_light_out = 2'b3;
		end else begin
			main_light_out = 2'b2;
			side_light_out = 2'b2;
		end
	end
endmodule
