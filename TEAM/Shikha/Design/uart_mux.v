
module uart_mux(  start_bit , parity_bit ,stop_bit ,data_bit ,data_bit ,select_bit ,tx_data_out);

 input start_bit  , parity_bit ,stop_bit ;
 input  data_bit ;
 
 input [1:0] select_bit ; 

 output reg tx_data_out ;


 always@(*)
 begin

 case(select_bit)
  2'b00: tx_data_out = start_bit ;
  2'b01: tx_data_out= data_bit ;
  2'b10: tx_data_out= parity_bit;
  2'b11: tx_data_out=stop_bit;
  default: tx_data_out = 0 ;
 endcase
 end

endmodule

   

