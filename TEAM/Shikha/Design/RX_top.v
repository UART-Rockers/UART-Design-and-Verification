module RX_top (clk , rstn , rx_in , parity_bit_error ,stop_bit_error , rx_data_out);
input clk , rstn , rx_in ;

output  parity_bit_error ,stop_bit_error ;
output  [7:0] rx_data_out ;
wire start_bit_dec , shift ,parity_load , check_stop ;
wire[7:0] rx_data_in ;
wire[7:0] parity_out ;

detect_start d(.rx_in(rx_in) , .start_bit_dec(start_bit_dec) );
SIPO s(.clk(clk)  , .rx_in(rx_in) , .shift(shift) , .rx_data_in(rx_data_in)) ;
stop_bit_checker  c(.rx_in(rx_in) , .check_stop(check_stop),.rx_data_in(rx_data_in), .stop_bit_error(stop_bit_error),.rx_data_out(rx_data_out)); 
parity_checker p(.rx_in(rx_in) ,.parity_load(parity_load) , .rx_data_in(rx_data_in) ,.parity_bit_error(parity_bit_error),.parity_out(parity_out));
  

rx_fsm h(.clk(clk) ,.rstn(rstn) , .start_bit_dec(start_bit_dec) ,.shift(shift) , .parity_load(parity_load) , .parity_bit_error(parity_bit_error) , .check_stop(check_stop) ) ;


endmodule
