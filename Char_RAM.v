`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:09:38 03/29/2016 
// Design Name: 
// Module Name:    ROM1 
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
module Char_RAM(
	//input wire clk,
	input wire [7:0] dir,
	output reg [7:0] data
    );

always @*
	case (dir)
	// CERO
		8'h00: data = 8'b00000000;
		8'h01: data = 8'b11111110;
		8'h02: data = 8'b11111110;
		8'h03: data = 8'b11000110;
		8'h04: data = 8'b11000110;
		8'h05: data = 8'b11000110;
		8'h06: data = 8'b11000110;
		8'h07: data = 8'b11000110;
		8'h08: data = 8'b11000110;
		8'h09: data = 8'b11000110;
		8'h0a: data = 8'b11000110;
		8'h0b: data = 8'b11111110;
		8'h0c: data = 8'b11111110;
		8'h0d: data = 8'b00000000;
		8'h0e: data = 8'b00000000;
		8'h0f: data = 8'b00000000;
	// UNO	
		8'h10: data = 8'b00000000;
		8'h11: data = 8'b00000110;
		8'h12: data = 8'b00000110;
		8'h13: data = 8'b00000110;
		8'h14: data = 8'b00000110;
		8'h15: data = 8'b00000110;
		8'h16: data = 8'b00000110;
		8'h17: data = 8'b00000110;
		8'h18: data = 8'b00000110;
		8'h19: data = 8'b00000110;
		8'h1a: data = 8'b00000110;
		8'h1b: data = 8'b00000110;
		8'h1c: data = 8'b00000110;
		8'h1d: data = 8'b00000000;
		8'h1e: data = 8'b00000000;
		8'h1f: data = 8'b00000000;
	// DOS	
		8'h20: data = 8'b00000000;
		8'h21: data = 8'b11111110;
		8'h22: data = 8'b11111110;
		8'h23: data = 8'b00000110;
		8'h24: data = 8'b00000110;
		8'h25: data = 8'b00000110;
		8'h26: data = 8'b11111110;
		8'h27: data = 8'b11111110;
		8'h28: data = 8'b11000000;
		8'h29: data = 8'b11000000;
		8'h2a: data = 8'b11000000;
		8'h2b: data = 8'b11111110;
		8'h2c: data = 8'b11111110;
		8'h2d: data = 8'b00000000;
		8'h2e: data = 8'b00000000;
		8'h2f: data = 8'b00000000;
	// TRES	
		8'h30: data = 8'b00000000;
		8'h31: data = 8'b11111110;
		8'h32: data = 8'b11111110;
		8'h33: data = 8'b00000110;
		8'h34: data = 8'b00000110;
		8'h35: data = 8'b00000110;
		8'h36: data = 8'b11111110;
		8'h37: data = 8'b11111110;
		8'h38: data = 8'b00000110;
		8'h39: data = 8'b00000110;
		8'h3a: data = 8'b00000110;
		8'h3b: data = 8'b11111110;
		8'h3c: data = 8'b11111110;
		8'h3d: data = 8'b00000000;
		8'h3e: data = 8'b00000000;
		8'h3f: data = 8'b00000000;
	// CUATRO	
		8'h40: data = 8'b00000000;
		8'h41: data = 8'b11000110;
		8'h42: data = 8'b11000110;
		8'h43: data = 8'b11000110;
		8'h44: data = 8'b11000110;
		8'h45: data = 8'b11000110;
		8'h46: data = 8'b11111110;
		8'h47: data = 8'b11111110;
		8'h48: data = 8'b00000110;
		8'h49: data = 8'b00000110;
		8'h4a: data = 8'b00000110;
		8'h4b: data = 8'b00000110;
		8'h4c: data = 8'b00000110;
		8'h4d: data = 8'b00000000;
		8'h4e: data = 8'b00000000;
		8'h4f: data = 8'b00000000;
	// CINCO	
		8'h50: data = 8'b00000000;
		8'h51: data = 8'b11111110;
		8'h52: data = 8'b11111110;
		8'h53: data = 8'b11000000;
		8'h54: data = 8'b11000000;
		8'h55: data = 8'b11000000;
		8'h56: data = 8'b11111110;
		8'h57: data = 8'b11111110;
		8'h58: data = 8'b00000110;
		8'h59: data = 8'b00000110;
		8'h5a: data = 8'b00000110;
		8'h5b: data = 8'b11111110;
		8'h5c: data = 8'b11111110;
		8'h5d: data = 8'b00000000;
		8'h5e: data = 8'b00000000;
		8'h5f: data = 8'b00000000;
	//	SEIS
		8'h60: data = 8'b00000000;
		8'h61: data = 8'b11111110;
		8'h62: data = 8'b11111110;
		8'h63: data = 8'b11000000;
		8'h64: data = 8'b11000000;
		8'h65: data = 8'b11000000;
		8'h66: data = 8'b11111110;
		8'h67: data = 8'b11111110;
		8'h68: data = 8'b11000110;
		8'h69: data = 8'b11000110;
		8'h6a: data = 8'b11000110;
		8'h6b: data = 8'b11111110;
		8'h6c: data = 8'b11111110;
		8'h6d: data = 8'b00000000;
		8'h6e: data = 8'b00000000;
		8'h6f: data = 8'b00000000;
	// SIETE	
		8'h70: data = 8'b00000000;
		8'h71: data = 8'b11111110;
		8'h72: data = 8'b11111110;
		8'h73: data = 8'b00000110;
		8'h74: data = 8'b00000110;
		8'h75: data = 8'b00001100;
		8'h76: data = 8'b00001100;
		8'h77: data = 8'b00011000;
		8'h78: data = 8'b00011000;
		8'h79: data = 8'b00110000;
		8'h7a: data = 8'b00110000;
		8'h7b: data = 8'b01100000;
		8'h7c: data = 8'b01100000;
		8'h7d: data = 8'b00000000;
		8'h7e: data = 8'b00000000;
		8'h7f: data = 8'b00000000;
	// OCHO	
		8'h80: data = 8'b00000000;
		8'h81: data = 8'b11111110;
		8'h82: data = 8'b11111110;
		8'h83: data = 8'b11000110;
		8'h84: data = 8'b11000110;
		8'h85: data = 8'b11000110;
		8'h86: data = 8'b11111110;
		8'h87: data = 8'b11111110;
		8'h88: data = 8'b11000110;
		8'h89: data = 8'b11000110;
		8'h8a: data = 8'b11000110;
		8'h8b: data = 8'b11111110;
		8'h8c: data = 8'b11111110;
		8'h8d: data = 8'b00000000;
		8'h8e: data = 8'b00000000;
		8'h8f: data = 8'b00000000;
	// NUEVE	
		8'h90: data = 8'b00000000;
		8'h91: data = 8'b11111110;
		8'h92: data = 8'b11111110;
		8'h93: data = 8'b11000110;
		8'h94: data = 8'b11000110;
		8'h95: data = 8'b11000110;
		8'h96: data = 8'b11111110;
		8'h97: data = 8'b11111110;
		8'h98: data = 8'b00000110;
		8'h99: data = 8'b00000110;
		8'h9a: data = 8'b00000110;
		8'h9b: data = 8'b11111110;
		8'h9c: data = 8'b11111110;
		8'h9d: data = 8'b00000000;
		8'h9e: data = 8'b00000000;
		8'h9f: data = 8'b00000000;
	// VACIO
		8'ha0: data = 8'b00000000;
		8'ha1: data = 8'b00000000;
		8'ha2: data = 8'b00000000;
		8'ha3: data = 8'b00000000;
		8'ha4: data = 8'b00000000;
		8'ha5: data = 8'b00000000;
		8'ha6: data = 8'b00000000;
		8'ha7: data = 8'b00000000;
		8'ha8: data = 8'b00000000;
		8'ha9: data = 8'b00000000;
		8'haa: data = 8'b00000000;
		8'hab: data = 8'b00000000;
		8'hac: data = 8'b00000000;
		8'had: data = 8'b00000000;
		8'hae: data = 8'b00000000;
		8'haf: data = 8'b00000000;
	// : (DOS PUNTOS)
		8'hb0: data = 8'b00000000;
		8'hb1: data = 8'b00000000;
		8'hb2: data = 8'b00000000;
		8'hb3: data = 8'b00111000;
		8'hb4: data = 8'b00111000;
		8'hb5: data = 8'b00111000;
		8'hb6: data = 8'b00000000;
		8'hb7: data = 8'b00000000;
		8'hb8: data = 8'b00111000;
		8'hb9: data = 8'b00111000;
		8'hba: data = 8'b00111000;
		8'hbb: data = 8'b00000000;
		8'hbc: data = 8'b00000000;
		8'hbd: data = 8'b00000000;
		8'hbe: data = 8'b00000000;
		8'hbf: data = 8'b00000000;
		// / (SLASH)
		8'hc0: data = 8'b00000000;
		8'hc1: data = 8'b00000110;
		8'hc2: data = 8'b00000110;
		8'hc3: data = 8'b00001100;
		8'hc4: data = 8'b00001100;
		8'hc5: data = 8'b00011000;
		8'hc6: data = 8'b00011000;
		8'hc7: data = 8'b00011000;
		8'hc8: data = 8'b00110000;
		8'hc9: data = 8'b00110000;
		8'hca: data = 8'b00110000;
		8'hcb: data = 8'b01100000;
		8'hcc: data = 8'b01100000;
		8'hcd: data = 8'b01100000;
		8'hce: data = 8'b11000000;
		8'hcf: data = 8'b11000000;
		
		// CORCHETE
		8'hd0: data = 8'b10000001;
		8'hd1: data = 8'b11111111;
		
		8'hff: data = 8'b10011001;
		
	default: data = 8'b00000000;
	endcase

endmodule