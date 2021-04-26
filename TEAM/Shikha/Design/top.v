module tx_top (clk , rstn ,tx_start , tx_data_in  ,tx_data_out ,  tx_busy ) ;

output tx_data_out ,  tx_busy ;
input clk , rstn ,tx_start ;
input [7:0] tx_data_in ;


wire[1:0] select ;
wire shift , load , parity_bit , data_out ;
reg start_p = 0 , stop_p = 1 ;


uart_mux m(  .start_bit(start_p) , .parity_bit(parity_bit) , .stop_bit(stop_p) , .data_bit(data_out) ,.select_bit(select) ,.tx_data_out(tx_data_out));
tx_parity_gen pg(.tx_data_in(tx_data_in) ,.load(load) , .parity_bit(parity_bit)) ;
uart_piso piso(.load(load) , .clk(clk),.shift(shift) ,.tx_data_in(tx_data_in) ,.data_out(data_out));
uart_tx_fsm fsm(.clk(clk) , .rstn(rstn) , .tx_start(tx_start) , .shift(shift) ,.select(select) , .load(load) , .tx_busy(tx_busy) );


endmodule 

