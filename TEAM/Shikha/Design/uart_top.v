`include "tx_top.v"
`include "RX_top.v"
`include "baud_gen.v"
module  uart_top(clk,rstn,sel,tx_start,tx_data_in,parity_bit_error ,stop_bit_error,rx_data_out);
input clk , rstn ,tx_start ;
input  [7:0] tx_data_in ;
input[1:0] sel ;
output parity_bit_error ,stop_bit_error ;
output [7:0] rx_data_out ;
wire tx_busy,tx_data_out;
wire clk_out;
  

tx_top tx(.clk(clk_out) , .rstn(rstn) ,.tx_start(tx_start) , .tx_data_in(tx_data_in)  ,.tx_data_out(tx_data_out) ,  .tx_busy(tx_busy) ) ;
RX_top rx( .clk(clk_out) , .rstn(rstn), .rx_in(tx_data_out) , .parity_bit_error(parity_bit_error) ,.stop_bit_error(stop_bit_error) , .rx_data_out(rx_data_out));
baud_gen gen (.clk_in(clk),.rstn(rstn),.sel(sel),.clk_out(clk_out));
  
  

endmodule
