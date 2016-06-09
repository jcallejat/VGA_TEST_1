`timescale 1ns / 1ps

module Contador_ajuste(
    input wire clk,
    input wire reset,
	 input wire enable,
	 output reg f
    );

reg [25:0] out;

//-------------Code Starts Here-------
always @(posedge clk) begin
	if (reset) begin
		out <= 26'b0;
		f <= 0;
	end
	else if (enable) begin
		out <= out + 1;
		
		if (out == 26'b10011000000000000000000000) begin
			f <= ~f;
			out <= 26'b0;
		end
		
	end
end

endmodule