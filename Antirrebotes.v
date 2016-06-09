`timescale 1ns / 1ps

module Antirrebotes(
	input wire dato_entrada, clk, reset,
	output wire dato_salida
    );

wire q1, q2, q3, q4, q5, q6;

// FF-D
FF_D uno (
    .data(dato_entrada), 
    .clk(clk), 
    .reset(reset), 
    .q(q1)
    );
	 
FF_D dos (
    .data(q1), 
    .clk(clk), 
    .reset(reset), 
    .q(q2)
    );
	 
FF_D tres (
    .data(q2), 
    .clk(clk), 
    .reset(reset), 
    .q(q3)
    );
	 
FF_D cuatro (
    .data(q3), 
    .clk(clk), 
    .reset(reset), 
    .q(q4)
    );

FF_D cinco (
    .data(q4), 
    .clk(clk), 
    .reset(reset), 
    .q(q5)
    );
	 
FF_D seis (
    .data(q5), 
    .clk(clk), 
    .reset(reset), 
    .q(q6)
    );


// Comprobacion
Comprobacion_Dato_Salida comprobacion (
    .q1(q1),
    .q2(q2),
    .q3(q3),
	 .q4(q4),
    .q5(q5),
    .q6(q6),
	 .dato_entrada(dato_entrada),
	 .clk(clk),
    .dato_salida(dato_salida)
    );
endmodule