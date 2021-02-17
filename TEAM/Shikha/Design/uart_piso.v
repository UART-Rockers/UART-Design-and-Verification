module uart_piso(load , clk,shift ,tx_data_in ,data_out);

input load , clk,shift ;
input[7:0] tx_data_in;
output reg data_out;

 reg[6:0] temp;// only 7 bit data needed bcz 1 bit will transfer with load

 always@(posedge clk )
 begin
	 if(load) begin
	   
	 data_out <= tx_data_in[0] ;
	 temp<=tx_data_in[7:1];
          end
 else if(shift)
 begin
 data_out<=temp[0];
 temp<=temp >>1 ;
/* temp[7] <= 1'b0;
 temp[6] <=temp[7];
 temp[5] <=temp[6];
 temp[4] <=temp[5];
 temp[3] <=temp[4];
 temp[2] <=temp[3];
 temp[1] <=temp[2];
 temp[0] <=temp[1];
end */
end
end


endmodule  
