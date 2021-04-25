
module parity_checker(rx_in ,parity_load , rx_data_in ,parity_bit_error,parity_out);

input rx_in ,parity_load ;
 input[7:0] rx_data_in ; 
output reg parity_bit_error;
 output reg [7:0] parity_out;

reg temp ;


always@(parity_load) begin
    if(parity_load) begin
      temp = ^rx_data_in ;
      if(rx_in==temp) begin
        parity_bit_error <= 0; 
        parity_out<=rx_data_in; 
      end
      else begin
        parity_bit_error <= 1;
        parity_out<=rx_data_in;
      end
    end
  end


endmodule 





