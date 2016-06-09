`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:49:36 03/19/2013 
// Design Name: 
// Module Name:    clockdiv 
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
module clockdiv(
	input wire original_clk,		//master clock: 50MHz
	input wire reset,		//asynchronous reset
	output wire new_clk		//pixel clock: 25MHz
	);

// 17-bit counter variable
reg [1:0] counter;

// Clock divider --
// Each bit in q is a clock signal that is
// only a fraction of the master clock.
always @(posedge original_clk or posedge reset)
begin
	// reset condition
	if (reset == 1) begin
		counter <= 0;
	end
	// increment counter by one
	else
		counter <= counter + 1;
end

// 50Mhz ÷ 2^1 = 25MHz
assign new_clk = counter[1];

endmodule