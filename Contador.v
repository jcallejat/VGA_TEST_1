`timescale 1ns / 1ps

module Contador(
    input wire clk,
    input wire reset,
    output reg [4:0] count_out
    );
//-------------Code Starts Here-------
always @(negedge clk)
if (reset) begin
  count_out <= 5'b0 ;
end else begin
  count_out <= count_out + 1;
end


endmodule