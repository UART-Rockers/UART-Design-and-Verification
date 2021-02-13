module uart_piso(load , clk  ,tx_data_in ,data_bit);

input load , clk ;
input[7:0] tx_data_in;
output data_bit;

 reg[7:0] temp;

 always@(posedge clk )
 begin
 if(load) temp<=tx_data_in;
 else begin
// data_bit<=temp[0];
// temp<=temp >>1'b0 ;
 temp[7] <= 1'b0;
 temp[6] <=temp[7];
 temp[5] <=temp[6];
 temp[4] <=temp[5];
 temp[3] <=temp[4];
 temp[2] <=temp[3];
 temp[1] <=temp[2];
 temp[0] <=temp[1];
end
end

assign data_bit =temp[0];
endmodule  
