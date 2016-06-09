`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:40:33 05/10/2016 
// Module Name:    FSM 
// Description: 
//
//////////////////////////////////////////////////////////////////////////////////
module FSM(
	output reg CS,
	output reg RD,
	output reg WR,
	output reg AD,
   output reg [2:0] state,
	output reg flag_z,
	output wire [4:0] tiempos,
   input wire reset,
   input wire clk,
   input wire escritura
    );

parameter 	SIZE = 3, t_dir = 25, t_z = 25, t_leer = 25, t_escribir = 25, t_tran = 5;
parameter 	tran_Z_E = 3'b000, alta_imp  = 3'b001, envio_dir = 3'b010, tran_E_Z = 3'b011,
				leer = 3'b100, escribir = 3'b101, alta_imp_final = 3'b111;

//wire [4:0] tiempos;
reg reset_tiempos;

//=============Internal Variables======================
//reg [SIZE-1:0] state        ;// Seq part of the FSM
//==========Code startes Here==========================
always @ (posedge clk)
begin : FSM

if (reset == 1'b1) begin
	state <= #1 alta_imp_final;
	reset_tiempos <= 1;
	CS <= 1;
	RD <= 1;
	WR <= 1;
	AD <= 1;
end else
	case(state)
		tran_Z_E: if (tiempos == t_tran) begin
							state <= #1 envio_dir;
							flag_z <= 1;
							reset_tiempos <= 1;
							
							CS <= 0;
							RD <= 1;
							WR <= 0;
							AD <= 0;
						end
						else begin
							state <= #1 tran_Z_E;
							flag_z <= 1;
							reset_tiempos <= 0;
							CS <= 1;
							RD <= 1;
							WR <= 1;
							AD <= 0;
						end
	
		envio_dir: if (tiempos == t_dir-1) begin
							state <= #1 tran_E_Z;
							flag_z <= 0;
							reset_tiempos <= 1;
							
							CS <= 1;
							RD <= 1;
							WR <= 1;
							AD <= 0;
						end
						
						else begin
							state <= #1 envio_dir;
							flag_z <= 0;
							reset_tiempos <= 0;
						end
						
		tran_E_Z: if (tiempos == t_tran) begin
							state <= #1 alta_imp;
							flag_z <= 0;
							reset_tiempos <= 1;
							
							CS <= 1;
							RD <= 1;
							WR <= 1;
							AD <= 1;
						end
						else begin
							state <= #1 tran_E_Z;
							flag_z <= 0;
							reset_tiempos <= 0;
							CS <= 1;
							RD <= 1;
							WR <= 1;
							AD <= 0;
						end

		alta_imp : 	
						begin
						if ((tiempos == t_z)&&(escritura)) begin
							state <= #1 escribir;
							flag_z <= 1;
							reset_tiempos <= 1;
							
							CS <= 0;
							RD <= 1;
							WR <= 0;
							AD <= 1;
						end
						else if ((tiempos == t_z)&&(~escritura)) begin
							state <= #1 leer;
							flag_z <= 1;
							reset_tiempos <= 1;
							
							CS <= 0;
							RD <= 0;
							WR <= 1;
							AD <= 1;
						end
						else begin
							state <= #1 alta_imp;
							reset_tiempos <= 0;
						end
						
						if (tiempos < t_z-15) begin
							flag_z <= 0;
						end
						else begin
							flag_z <= 1;
						end
						
						end
		leer : 		if (tiempos == t_leer) begin
							state <= #1 alta_imp_final;
							flag_z <= 1;
							reset_tiempos <= 1;
							
							CS <= 1;
							RD <= 1;
							WR <= 1;
							AD <= 1;
						end else begin
							state <= #1 leer;
							reset_tiempos <= 0;
							flag_z <= 1;
						end
		escribir : 	if (tiempos == t_escribir) begin
							state <= #1 alta_imp_final;
							flag_z <= 0;
							reset_tiempos <= 1;
							
							CS <= 1;
							RD <= 1;
							WR <= 1;
							AD <= 1;
						end else begin
							state <= #1 escribir;
							reset_tiempos <= 0;
							flag_z <= 0;
						end
						
		alta_imp_final: 
						begin
						if (tiempos == t_z-1) begin
							state <= #1 tran_Z_E;
							reset_tiempos <= 1;
							
							CS <= 1;
							RD <= 1;
							WR <= 1;
							AD <= 0;
						end
						else begin
							state <= #1 alta_imp_final;
							flag_z <= 1;
							reset_tiempos <= 0;
							CS <= 1;
							RD <= 1;
							WR <= 1;
							AD <= 1;
						end
						if (tiempos < t_z-15) begin
							flag_z <= 0;
						end
						else begin
							flag_z <= 1;
						end
						end
		default : state <= #1 alta_imp_final;
endcase
end

Contador cont_tiempos(
    .clk(clk),
    .reset(reset_tiempos),
    .count_out(tiempos)
    );

endmodule