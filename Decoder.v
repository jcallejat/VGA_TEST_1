//-----------------------------------------------------
// Design Name : decoder_using_case
// File Name   : decoder_using_case.v
// Function    : decoder using case
// Coder       : Deepak Kumar Tala
//-----------------------------------------------------
module decoder_using_case (
binary_in   ,
decoder_out ,
enable        //  Enable for the decoder
);
input [2:0] binary_in  ;
input  enable ;
output [7:0] decoder_out ;

reg [7:0] decoder_out ;

always @ (enable or binary_in)
begin
  decoder_out = 0;
  if (enable) begin
    case (binary_in)
      3'h0 : decoder_out = 8'h01;
      3'h1 : decoder_out = 8'h02;
      3'h2 : decoder_out = 8'h04;
      3'h3 : decoder_out = 8'h08;
      3'h4 : decoder_out = 8'h10;
      3'h5 : decoder_out = 8'h20;
      3'h6 : decoder_out = 8'h40;
      3'h7 : decoder_out = 8'h80;
    endcase
  end
end

endmodule