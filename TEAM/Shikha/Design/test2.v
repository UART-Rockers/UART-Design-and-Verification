
module test2  ();
reg clk , rstn , rx_in ;

wire parity_bit_error ,stop_bit_error ;
wire [7:0] rx_data_out ;
RX_top m(.clk(clk) , .rstn(rstn) , .rx_in(rx_in) , .parity_bit_error(parity_bit_error) ,.stop_bit_error(stop_bit_error) , .rx_data_out(rx_data_out));
 

initial 
clk = 0 ;
always #5  clk = ~ clk ;

initial begin
#5 rstn = 0 ;
#5 rx_in = 1 ;
rstn=1;
#10 rx_in = 0 ;
#10 rx_in = 0 ;
#10 rx_in = 1 ;
#10 rx_in = 1 ;

#10 rx_in = 0 ;
#10 rx_in = 0 ;
#10 rx_in = 0 ;
#10 rx_in = 1 ;
#10 rx_in = 1 ;

#10 rx_in = 0 ;
#10 rx_in = 1 ;
end

endmodule
