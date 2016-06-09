`timescale 1ns / 1ps

module rom(
	//input wire clk,
	input wire [3:0] dir,
	output reg [7:0] data
    );
always @*
	case (dir)
	// CERO
		4'h0: data = 8'h02;
		4'h1: data = 8'h02;
		4'h2: data = 8'h10;
		4'h3: data = 8'hf1;
		4'h4: data = 8'h21;
		4'h5: data = 8'h22;
		4'h6: data = 8'h23;
		4'h7: data = 8'h24;
		4'h8: data = 8'h25;
		4'h9: data = 8'h26;
		4'ha: data = 8'h00;
		4'hb: data = 8'h00;
		4'hc: data = 8'h00;
		4'hd: data = 8'h00;
		4'he: data = 8'h00;
		4'hf: data = 8'h00;
	default: data = 8'h00;
	endcase
endmodule