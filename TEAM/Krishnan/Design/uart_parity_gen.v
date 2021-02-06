
module parity_generator(parity_bit,tx_data,load_data);
output reg parity_bit;
input [7:0]tx_data;
input load_data;
always@(*)
begin
if (load_data)
parity_bit<=^tx_data;//sum of even number 1's exor result will be 0 and sum of odd number of 1's result is 1
else
parity_bit<=1'b0;
end
endmodule
/////10101011 --->odd parity ,sum =1
