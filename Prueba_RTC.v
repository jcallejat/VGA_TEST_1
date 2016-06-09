`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:23:12 05/24/2016
// Design Name:   NERP_demo_top
// Module Name:   C:/Users/Juan/Desktop/VGA_TEST/Prueba_RTC.v
// Project Name:  VGA_TEST
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: NERP_demo_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Prueba_RTC;

	// Inputs
	reg clk;
	reg clr;
	reg cuadro;
	reg tap_up;
	reg tap_down;
	reg tap_right;
	reg tap_left;

	// Outputs
	wire [2:0] red;
	wire [2:0] green;
	wire [1:0] blue;
	wire hsync;
	wire vsync;
	wire CS;
	wire WR;
	wire RD;
	wire AD;
	wire clk_out;

	// Bidirs
	wire [7:0] dato_rtc;

	// Instantiate the Unit Under Test (UUT)
	NERP_demo_top uut (
		.clk(clk), 
		.clr(clr), 
		.cuadro(cuadro), 
		.tap_up(tap_up), 
		.tap_down(tap_down), 
		.tap_right(tap_right), 
		.tap_left(tap_left), 
		.red(red), 
		.green(green), 
		.blue(blue), 
		.hsync(hsync), 
		.vsync(vsync), 
		.CS(CS), 
		.WR(WR), 
		.RD(RD), 
		.AD(AD), 
		.clk_out(clk_out), 
		.dato_rtc(dato_rtc)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 0;
		cuadro = 0;
		tap_up = 0;
		tap_down = 0;
		tap_right = 0;
		tap_left = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
	end
	
		
	always begin
		#5 clk = ~clk;
	end
      
      
endmodule

