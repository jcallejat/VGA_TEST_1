`timescale 1ns / 1ps

module NERP_demo_top(
	input wire clk,			//master clock = 50MHz
	input wire clr,			//right-most pushbutton for reset
	input wire cuadro,
	input wire tap_up,
	input wire tap_down,
	input wire tap_right,
	input wire tap_left,
	
	//input wire [6:0]letra,
	
	output wire [2:0] red,	//red vga output - 3 bits
	output wire [2:0] green,//green vga output - 3 bits
	output wire [1:0] blue,	//blue vga output - 2 bits
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output wire CS, WR, RD, AD,
	output reg clk_out,
	inout [7:0] dato_rtc
	);


// VGA display clock interconnect
wire clk_wire;
wire [47:0] valor_deseado;
wire [7:0] dir;
wire [7:0] data;
wire [2:0] sel_posicion_wire;
wire tap_up_estable, tap_down_estable, tap_right_estable, tap_left_estable;
wire [47:0] almacenamiento;
wire [7:0]decoder_out;
wire f;

// RTC cables
wire new_clk;
wire [7:0] seg_b, min_b, h_b, dia_b, mes_b, anno_b;
wire [47:0] info;

always begin
	clk_out <= clk_wire;
end


// generate 7-segment clock & display clock
clockdiv U1(
	.original_clk(clk),
	.reset(clr),
	.new_clk(clk_wire)
	);

// VGA controller
vga640x480 U3(
	.dclk(clk_wire),
	.posicion(sel_posicion_wire),
	.clr(clr),
	.data(data),
	.dir(dir),
	.hsync(hsync),
	.vsync(vsync),
	.red(red),
	.green(green),
	.blue(blue),
	.cuadro(cuadro),
	.almacenamiento(almacenamiento),
	.parpadeo(f)
	);

Char_RAM ROM (
    .dir(dir), 
    .data(data)
    );
	 
Up_Down_Counter sel_posicion (
    .out(sel_posicion_wire),
    .up(tap_right_estable),
    .down(tap_left_estable),
    .clk(clk_wire),
    .reset(~cuadro),
    .enable(cuadro)
    );
	 
Counter_24 hora (
    .out(valor_deseado[47:40]),
    .up(tap_up_estable),
    .down(tap_down_estable),
    .clk(clk_wire),
    .reset(clr),
    .enable(decoder_out[0]),
	 .dato_rtc(almacenamiento[47:40])
    );

Counter_60 minuto (
    .out(valor_deseado[39:32]),
    .up(tap_up_estable),
    .down(tap_down_estable),
    .clk(clk_wire),
    .reset(clr),
    .enable(decoder_out[1]),
	 .dato_rtc(almacenamiento[39:32])
    );
	 
Counter_60 segundo (
    .out(valor_deseado[31:24]),
    .up(tap_up_estable),
    .down(tap_down_estable),
    .clk(clk_wire),
    .reset(clr),
    .enable(decoder_out[2]),
	 .dato_rtc(almacenamiento[31:24])
    );

Counter_31 dia (
    .out(valor_deseado[23:16]),
    .up(tap_up_estable),
    .down(tap_down_estable),
    .clk(clk_wire),
    .reset(clr),
    .enable(decoder_out[3]),
	 .dato_rtc(almacenamiento[23:16])
    );
	 
Counter_12 mes (
    .out(valor_deseado[15:8]),
    .up(tap_up_estable),
    .down(tap_down_estable),
    .clk(clk_wire),
    .reset(clr),
    .enable(decoder_out[4]),
	 .dato_rtc(almacenamiento[15:8])
    );
	 
Up_Down_Counter_8bit ano (
    .out(valor_deseado[7:0]),
    .up(tap_up_estable),
    .down(tap_down_estable),
    .clk(clk_wire),
    .reset(clr),
    .enable(decoder_out[5]),
	 .dato_rtc(almacenamiento[7:0])
    );

decoder_using_case deco (
    .binary_in(sel_posicion_wire), 
    .decoder_out(decoder_out), 
    .enable(cuadro)
    );

Antirrebotes antirrebotes_up (
    .dato_entrada(tap_up),
    .clk(clk_wire),
    .reset(clr),
    .dato_salida(tap_up_estable)
    );
	 
Antirrebotes antirrebotes_down (
    .dato_entrada(tap_down),
    .clk(clk_wire),
    .reset(clr),
    .dato_salida(tap_down_estable)
    );
	 
Antirrebotes antirrebotes_right (
    .dato_entrada(tap_right),
    .clk(clk_wire),
    .reset(clr),
    .dato_salida(tap_right_estable)
    );
	 
Antirrebotes antirrebotes_left (
    .dato_entrada(tap_left),
    .clk(clk_wire),
    .reset(clr),
    .dato_salida(tap_left_estable)
    );
	 
Reg_info reg_info (
    .clk(clk_wire),
    .clr(clr),
    .estado(cuadro),
    .dato_user(valor_deseado),
    .dato_rtc(info),
    .almacenamiento(almacenamiento)
    );
	 
Contador_ajuste parpadeo(
    .clk(clk),
    .reset(clr),
    .enable(cuadro),
    .f(f)
    );

// RTC
/*
Divisor_clk_rtc Clk_rtc (
    .original_clk(clk), 
    .reset(clr), 
    .new_clk(new_clk)
    );
RTC rtc (
    .clk(clk_wire), 
    .rst(clr), 
    .SW_escritura(cuadro), 
    .CS(CS), 
    .RD(RD), 
    .WR(WR), 
    .AD(AD), 
    .seg_fecha(seg_b), 
    .min_fecha(min_b), 
    .h_fecha(h_b), 
    .dia(dia_b), 
    .mes(mes_b), 
    .anno(anno_b), 
    .dato_rtc(dato_rtc)
    );
*/

Main main_rtc(
    .CS(CS),
    .RD(RD),
    .WR(WR),
    .AD(AD),
    .data(dato_rtc),
    .clk(clk),
    .reset(clr),
    .info(info)
    );

endmodule 