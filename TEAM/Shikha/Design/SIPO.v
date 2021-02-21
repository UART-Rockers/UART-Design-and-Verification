
module SIPO(clk  , rx_in , shift , rx_data_in) ;


input rx_in , shift , clk ;
output reg [7:0] rx_data_in ;





always@(posedge clk )
begin
if(shift)
 rx_data_in <= {rx_in ,rx_data_in[7:1]} ;
end

endmodule
 
