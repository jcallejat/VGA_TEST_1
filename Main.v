`timescale 1ns / 1ps

module Main(
	output CS,
	output RD,
	output WR,
	output AD,
	inout [7:0] data,
	input wire clk,
	input wire reset,
	output wire [47:0] info
);

wire escritura;
wire flag_z;
wire [2:0] state;
wire [4:0] tiempos;

Control_AD Control_IO(
    .state(state),
    .flag_z(flag_z),
    .clk(clk),
    .reset(reset),
    .data(data),
    .escritura(escritura),
	 .info(info),
	 .tiempos(tiempos)
    );

FSM FSM (
    .CS(CS), 
    .RD(RD), 
    .WR(WR), 
    .AD(AD),
    .state(state), 
    .flag_z(flag_z), 
    .reset(reset), 
    .clk(clk), 
    .escritura(escritura),
	 .tiempos(tiempos)
    );

endmodule