module tx_parity_gen(tx_data_in ,load , parity_bit);

input [7:0] tx_data_in;
input load;
output reg parity_bit ;


always@(*)
if(load==0) 

parity_bit=1'b0;

else
parity_bit =^(tx_data_in) ;


endmodule

