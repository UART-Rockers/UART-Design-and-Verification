
module parity_checker(rx_in ,parity_load , rx_data_in ,parity_bit_error);

input rx_in ,parity_load ;
 input[7:0] rx_data_in ; 
output reg parity_bit_error;

reg temp ;

always@(*)
begin
if(parity_load)
begin
temp = ^rx_data_in ;
if(rx_in ==temp)
parity_bit_error = 0;
 else 
parity_bit_error = 1 ;

end
end



endmodule 





