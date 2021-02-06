module piso(data_bit,
tx_data,
load_data,
shift,
clk,
reset);

input load_data,shift,clk,reset;
input [7:0] tx_data;
output reg data_bit=0;
reg[7:0]temp=7'd0;
always @ (posedge clk or negedge reset)
begin
if (!reset)
begin
data_bit<=1'b0;
end
else if (load_data)
temp<=tx_data;
else
begin
data_bit<=temp[0];
temp<=temp>>1'b1; //the LSB has to be shifted one position for one clock pulse
end
end
endmodule