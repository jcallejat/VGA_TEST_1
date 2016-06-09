`timescale 1ns / 1ps

module Counter_24    (
out      ,  // Output of the counter
up			,
down  	, 
clk      ,  // clock input
reset		,  // reset input
dato_rtc ,
enable
);
//----------Output Ports--------------
output [7:0] out;
//------------Input Ports--------------
input up, down, clk, reset, enable;
input [7:0]dato_rtc;
//------------Internal Variables--------
reg [7:0] out;
//-------------Code Starts Here-------
   always @(posedge clk or posedge reset) begin
		if (reset) begin
         out <= 8'h00;
      end 
		else if (enable == 0) begin
			out <= dato_rtc;
		end
		else if (up) begin
         if (enable)
				if((out[7:4] == 2)&&(out[3:0] == 3))begin
					out[7:4] <= 0;
					out[3:0] <= 0;
				end			
				else if (out[3:0] == 9) begin
					out[3:0] <= 0;
					if (out[7:4] == 9)
						out[7:4] <= 0;
					else
						out[7:4] <= out[7:4] + 1;
				end 
				else begin
					out[3:0] <= out[3:0] + 1;
				end
		end
		else if (down) begin
         if (enable)
				if((out[7:4] == 0)&&(out[3:0] == 0))begin
					out[7:4] <= 2;
					out[3:0] <= 3;
				end
				else if (out[3:0] == 0) begin
					out[3:0] <= 9;
					if (out[7:4] == 0)
						out[7:4] <= 3;
					else
						out[7:4] <= out[7:4] - 1;
				end 
				else begin
					out[3:0] <= out[3:0] - 1;
				end
      end // else: !if(reset)
   end // always @ (posedge clk or posedge reset)
endmodule // bcd_count