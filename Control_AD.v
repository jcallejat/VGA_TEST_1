`timescale 1ns / 1ps

module Control_AD(
    input wire [2:0] state,
	 input wire flag_z,
	 input wire clk,
	 input wire reset,
	 input wire [4:0] tiempos,
    inout [7:0] data,
	 output reg escritura,
	 output reg [47:0] info
    );

parameter 	init = 4'b0000;
parameter 	tran_Z_E = 3'b000, alta_imp  = 3'b001, envio_dir = 3'b010, tran_E_Z = 3'b011,
				leer = 3'b100, escribir = 3'b101, alta_imp_final = 3'b111;

wire [7:0] rom_data;

//flag_z;  direction (read=1 or 0=write)
reg [7:0] WriteData;  // output latch for data write
reg [7:0] dato_ent;
reg [3:0] num_paso;
reg state_reg;

assign data = (flag_z) ? 8'bz : WriteData;

//now you write to this bi-port:
always@(posedge clk) begin   // output
dato_ent <= data;
case(state)
		tran_Z_E:
			begin
				WriteData <= rom_data;
			end
		envio_dir:
			begin
				WriteData <= rom_data;
			end
		tran_E_Z:
			begin
				WriteData <= rom_data;
			end
		alta_imp:
			begin
				WriteData <= rom_data;
			end
		leer:
			begin
				WriteData <= rom_data;
				if ((num_paso == 4)&&(tiempos == 25)) begin
					info[31:24] <= dato_ent;
				end
				else if ((num_paso == 5)&&(tiempos == 25)) begin
					info[39:32] <= dato_ent;
				end
				else if ((num_paso == 6)&&(tiempos == 25)) begin
					info[47:40] <= dato_ent;
				end
				else if ((num_paso == 7)&&(tiempos == 25)) begin
					info[23:16] <= dato_ent;
				end
				else if ((num_paso == 8)&&(tiempos == 25)) begin
					info[15:8] <= dato_ent;
				end
				else if ((num_paso == 9)&&(tiempos == 25)) begin
					info[7:0] <= dato_ent;
				end
				else begin
					info <= info;
				end
			end
		escribir:
			begin 	
				if (num_paso == 0) begin
					WriteData <= 8'h10;
				end
				else if (num_paso == 1) begin
					WriteData <= 8'h00;
				end
				else begin
					WriteData <= 8'hd2;
				end
			end
		alta_imp_final:
			begin
				if (num_paso == 0) begin
					WriteData <= 8'h10;
				end
				else if (num_paso == 1) begin
					WriteData <= 8'h00;
				end
				else if (num_paso == 2) begin
					WriteData <= 8'hd2;
				end
				else if (num_paso == 8)begin
					WriteData <= rom_data;
				end
				else begin
					WriteData <= rom_data;
				end
			end

		default:
			begin
				WriteData <= rom_data;
			end
	endcase



if ((num_paso == 0)||(num_paso == 1)||(num_paso == 2)) begin
	escritura <= 1;
end
else begin
	escritura <= 0;
end

if (state == 0) begin
	state_reg <= 1;
end
else begin
	state_reg <= 0;
end

	/*if (flag_z == 1'b0)begin
		WriteData <= 8'h5A;   // write 5A to port
		outp <= 8'b11111111;
	end
	//this will read the port:
	else begin
		outp <= data;
	end*/
end

always @(posedge state_reg or posedge reset) begin
	if (reset == 1'b1) begin
		num_paso <= 4'b1111;
	end
	else if (num_paso == 9)begin
		num_paso <= 4'b0011;
	end
	else begin
		num_paso <= num_paso + 1;
	end
end

rom ROM (
    .dir(num_paso), 
    .data(rom_data)
    );

endmodule