`timescale 1ns / 1ps

module vga640x480(
	input wire dclk,			//pixel clock: 25MHz
	input wire clr,			//asynchronous reset
	input wire [7:0] data,
	input wire cuadro,
	input wire [2:0] posicion,
	input wire [47:0] almacenamiento,
	input wire parpadeo,
	output reg [7:0] dir,
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [1:0] blue //blue vga output
	);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch
// active horizontal video is therefore: 784 - 144 = 640
// active vertical video is therefore: 511 - 31 = 480

parameter hora_x = 368;
parameter minuto_x = 464;
parameter seg_x = 560;
parameter dia_x = 368;
parameter mes_x = 416;
parameter ano_x = 464;
parameter hora_y = 95;
parameter minuto_y = 95;
parameter seg_y = 95;
parameter dia_y = 223;
parameter mes_y = 223;
parameter ano_y = 223;

// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;
reg [3:0] dir_linea; //dir_letra;
reg [9:0] pos_actual_x, pos_actual_y;
reg [4:0]encender;

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge dclk or posedge clr)
begin
	// reset condition
	if (clr == 1)
	begin
		hc <= 0;
		vc <= 0;
		dir_linea <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

always begin
	case(posicion)
	3'b000: 	begin
				pos_actual_x = hora_x;
				pos_actual_y = hora_y;
				end
	3'b001: 	begin
				pos_actual_x = minuto_x;
				pos_actual_y = minuto_y;
				end
	3'b010: 	begin
				pos_actual_x = seg_x;
				pos_actual_y = seg_y;
				end
	3'b011: 	begin
				pos_actual_x = dia_x;
				pos_actual_y = dia_y;
				end
	3'b100: 	begin
				pos_actual_x = mes_x;
				pos_actual_y = mes_y;
				end
	3'b101: 	begin
				pos_actual_x = ano_x;
				pos_actual_y = ano_y;
				end
	default: begin
				pos_actual_x = hora_x;
				pos_actual_y = hora_y;
				end
	endcase
end

// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =
always @(*)
begin
	encender = {cuadro,parpadeo,posicion};
	
	if (vc >= vbp && vc < vfp)
	begin
		
		// DECENAS HORA
		if ((hc >= hora_x && hc < (hora_x + 32))&&(vc >= hora_y && vc < (hora_y+64))&&(encender != 5'b10000))
		begin
			green[2]=data[7-hc[9:2]+4];
			green[1]=data[7-hc[9:2]+4];
			green[0]=data[7-hc[9:2]+4];
			red = 3'b000;
			blue[1] = data[7-hc[9:2]+4];
			blue[0] = data[7-hc[9:2]+4];			
			//dir_letra = ;
			dir_linea = vc[9:2]+8;
			dir={almacenamiento[47:44],dir_linea};
		end
		// UNIDADES HORA
		else if ((hc >= (hora_x+32) && hc < (hora_x+64))&&(vc >= hora_y && vc < (hora_y+64))&&(encender != 5'b10000))
		begin
			green[2]=data[7-hc[9:2]+4];
			green[1]=data[7-hc[9:2]+4];
			green[0]=data[7-hc[9:2]+4];
			red = 3'b000;
			blue[1] = data[7-hc[9:2]+4];
			blue[0] = data[7-hc[9:2]+4];
			
			//dir_letra = ;
			dir_linea = vc[9:2]+8;
			dir={almacenamiento[43:40],dir_linea};
		end
		// DOS PUNTOS
		else if ((hc >= (hora_x+64) && hc < (hora_x+96))&&(vc >= 95 && vc < 159))
		begin
			green[2]=data[7-hc[9:2]+4];
			green[1]=data[7-hc[9:2]+4];
			green[0]=data[7-hc[9:2]+4];
			red = 3'b000;
			blue[1] = data[7-hc[9:2]+4];
			blue[0] = data[7-hc[9:2]+4];
			
			//dir_letra = ;
			dir_linea = vc[9:2]+8;
			dir={4'b1011,dir_linea};
		end
		//DECENAS MINUTO
		else if ((hc >= minuto_x && hc < (minuto_x+32))&&(vc >= 95 && vc < 159)&&(encender != 5'b10001))
		begin
			green[2]=data[7-hc[9:2]+4];
			green[1]=data[7-hc[9:2]+4];
			green[0]=data[7-hc[9:2]+4];
			red = 3'b000;
			blue[1] = data[7-hc[9:2]+4];
			blue[0] = data[7-hc[9:2]+4];
			
			//dir_letra = ;
			dir_linea = vc[9:2]+8;
			dir={almacenamiento[39:36],dir_linea};
		end
		// UNIDADES MINUTO
		else if ((hc >= 496 && hc < 528)&&(vc >= 95 && vc < 159)&&(encender != 5'b10001))
		begin
			green[2]=data[7-hc[9:2]+4];
			green[1]=data[7-hc[9:2]+4];
			green[0]=data[7-hc[9:2]+4];
			red = 3'b000;
			blue[1] = data[7-hc[9:2]+4];
			blue[0] = data[7-hc[9:2]+4];
			
			//dir_letra = ;
			dir_linea = vc[9:2]+8;
			dir={almacenamiento[35:32],dir_linea};
		end
		
		// DOS PUNTOS
		else if ((hc >= 528 && hc < 560)&&(vc >= 95 && vc < 159))
		begin
			green[2]=data[7-hc[9:2]+4];
			green[1]=data[7-hc[9:2]+4];
			green[0]=data[7-hc[9:2]+4];
			red = 3'b000;
			blue[1] = data[7-hc[9:2]+4];
			blue[0] = data[7-hc[9:2]+4];
			
			//dir_letra = ;
			dir_linea = vc[9:2]+8;
			dir={4'b1011,dir_linea};
		end
		
		// DECENAS SEGUNDO
		else if ((hc >= seg_x && hc < (seg_x+32))&&(vc >= seg_y && vc < (seg_y+64))&&(encender != 5'b10010))
		begin
			green[2]=data[7-hc[9:2]+4];
			green[1]=data[7-hc[9:2]+4];
			green[0]=data[7-hc[9:2]+4];
			red = 3'b000;
			blue[1] = data[7-hc[9:2]+4];
			blue[0] = data[7-hc[9:2]+4];
			
			//dir_letra = ;
			dir_linea = vc[9:2]+8;
			dir={almacenamiento[31:28],dir_linea};
		end
		// UNIDADES SEGUNDO
		else if ((hc >= (seg_x+32) && hc < (seg_x+64))&&(vc >= seg_y && vc < (seg_y+64))&&(encender != 5'b10010))
		begin
			green[2]=data[7-hc[9:2]+4];
			green[1]=data[7-hc[9:2]+4];
			green[0]=data[7-hc[9:2]+4];
			red = 3'b000;
			blue[1] = data[7-hc[9:2]+4];
			blue[0] = data[7-hc[9:2]+4];
			
			//dir_letra = ;
			dir_linea = vc[9:2]+8;
			dir={almacenamiento[27:24],dir_linea};
		end

//=========================FECHA=========================
		// DECENAS DIA
		else if ((hc >= 368 && hc < 384)&&(vc >= 223 && vc < 255)&&(encender != 5'b10011))
		begin
			green[2]=data[7-hc[9:1]];
			green[1]=data[7-hc[9:1]];
			green[0]=data[7-hc[9:1]];
			red = 3'b000;
			blue[1] = data[7-hc[9:1]];
			blue[0] = data[7-hc[9:1]];			
			//dir_letra = ;
			dir_linea = vc[9:1];
			dir={almacenamiento[23:20],dir_linea};
		end
		// UNIDADES DIA
		else if ((hc >= 384 && hc < 400)&&(vc >= 223 && vc < 255)&&(encender != 5'b10011))
		begin
			green[2]=data[7-hc[9:1]];
			green[1]=data[7-hc[9:1]];
			green[0]=data[7-hc[9:1]];
			red = 3'b000;
			blue[1] = data[7-hc[9:1]];
			blue[0] = data[7-hc[9:1]];
			
			//dir_letra = ;
			dir_linea = vc[9:1];
			dir={almacenamiento[19:16],dir_linea};
		end
		//SLASH
		else if ((hc >= 400 && hc < 416)&&(vc >= 222 && vc < 254))
		begin
			green[2]=data[7-hc[9:1]];
			green[1]=data[7-hc[9:1]];
			green[0]=data[7-hc[9:1]];
			red = 3'b000;
			blue[1] = data[7-hc[9:1]];
			blue[0] = data[7-hc[9:1]];
			
			//dir_letra = ;
			dir_linea = vc[9:1]-223;
			dir={4'b1100,dir_linea};
		end
		//MES
		else if ((hc >= 416 && hc < 432)&&(vc >= 223 && vc < 255)&&(encender != 5'b10100))
		begin
			green[2]=data[7-hc[9:1]];
			green[1]=data[7-hc[9:1]];
			green[0]=data[7-hc[9:1]];
			red = 3'b000;
			blue[1] = data[7-hc[9:1]];
			blue[0] = data[7-hc[9:1]];
			
			//dir_letra = ;
			dir_linea = vc[9:1];
			dir={almacenamiento[15:12],dir_linea};
		end
		
		else if ((hc >= 432 && hc < 448)&&(vc >= 223 && vc < 255)&&(encender != 5'b10100))
		begin
			green[2]=data[7-hc[9:1]];
			green[1]=data[7-hc[9:1]];
			green[0]=data[7-hc[9:1]];
			red = 3'b000;
			blue[1] = data[7-hc[9:1]];
			blue[0] = data[7-hc[9:1]];
			
			//dir_letra = ;
			dir_linea = vc[9:1];
			dir={almacenamiento[11:8],dir_linea};
		end
		//SLASH
		else if ((hc >= 448 && hc < 464)&&(vc >= 223 && vc < 255))
		begin
			green[2]=data[7-hc[9:1]];
			green[1]=data[7-hc[9:1]];
			green[0]=data[7-hc[9:1]];
			red = 3'b000;
			blue[1] = data[7-hc[9:1]];
			blue[0] = data[7-hc[9:1]];			
			//dir_letra = ;
			dir_linea = vc[9:1]-223;
			dir={4'b1100,dir_linea};
		end
		//AÑO
		else if ((hc >= 464 && hc < 480)&&(vc >= 223 && vc < 255)&&(encender != 5'b10101))
		begin
			green[2]=data[7-hc[9:1]];
			green[1]=data[7-hc[9:1]];
			green[0]=data[7-hc[9:1]];
			red = 3'b000;
			blue[1] = data[7-hc[9:1]];
			blue[0] = data[7-hc[9:1]];
			
			//dir_letra = ;
			dir_linea = vc[9:1];
			dir={4'b0010,dir_linea};
		end
		
		else if ((hc >= 480 && hc < 496)&&(vc >= 223 && vc < 255)&&(encender != 5'b10101))
		begin
			green[2]=data[7-hc[9:1]];
			green[1]=data[7-hc[9:1]];
			green[0]=data[7-hc[9:1]];
			red = 3'b000;
			blue[1] = data[7-hc[9:1]];
			blue[0] = data[7-hc[9:1]];
			
			//dir_letra = ;
			dir_linea = vc[9:1];
			dir={4'b0000,dir_linea};
		end
		
		else if ((hc >= 496 && hc < 512)&&(vc >= 223 && vc < 255)&&(encender != 5'b10101))
		begin
			green[2]=data[7-hc[9:1]];
			green[1]=data[7-hc[9:1]];
			green[0]=data[7-hc[9:1]];
			red = 3'b000;
			blue[1] = data[7-hc[9:1]];
			blue[0] = data[7-hc[9:1]];
			
			//dir_letra = ;
			dir_linea = vc[9:1];
			dir={almacenamiento[7:4],dir_linea};
		end
		
		else if ((hc >= 512 && hc < 528)&&(vc >= 223 && vc < 255)&&(encender != 5'b10101))
		begin
			green[2]=data[7-hc[9:1]];
			green[1]=data[7-hc[9:1]];
			green[0]=data[7-hc[9:1]];
			red = 3'b000;
			blue[1] = data[7-hc[9:1]];
			blue[0] = data[7-hc[9:1]];
			
			//dir_letra = ;
			dir_linea = vc[9:1];
			dir={almacenamiento[3:0],dir_linea};
		end
		
		
		// we're outside active horizontal range so display black
		else
		begin
			red = 3'b000;
			green = 3'b000;
			blue = 2'b00;
			dir=8'b0;
		end
	end
	// we're outside active vertical range so display black
	else
	begin
		red = 0;
		green = 0;
		blue = 0;
		dir=8'b0;
	end
end

endmodule