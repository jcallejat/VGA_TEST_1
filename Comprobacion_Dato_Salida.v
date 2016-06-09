`timescale 1ns / 1ps

module Comprobacion_Dato_Salida( 
	input wire dato_entrada,q1,q2,q3,q4,q5,q6,clk,
	output reg dato_salida
    );

always@ (posedge clk) begin
	if ((!dato_entrada && !q1 && !q2 && !q3 && !q4 && q5 && q6) == 1'b1)
		dato_salida <= 1'b1;
	else
		dato_salida <= 1'b0;
end
endmodule