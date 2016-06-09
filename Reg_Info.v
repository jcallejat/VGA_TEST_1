`timescale 1ns / 1ps

module Reg_info(
	 input wire clk,
	 input wire clr,
	 input wire estado,
    input wire [47:0] dato_user,
	 input wire [47:0] dato_rtc,
    output reg [47:0] almacenamiento
    );

always @ (posedge clk) begin
	if (clr) begin
		almacenamiento <= 48'b0;
	end
	
	else if (estado) begin
		almacenamiento <= dato_user;
	end
	
	else begin
		almacenamiento <= dato_rtc;
	end
	
end

endmodule