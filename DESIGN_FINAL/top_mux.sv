module top_mux(msel,tx_data_out,rx_ext,muxout);
  input msel,tx_data_out,rx_ext;
  output muxout;
  
  
 assign muxout=msel?rx_ext:tx_data_out;
  
  /*always @ (*) begin
   case (msel)
     1'b0 : muxout=tx_data_out;
     1'b1 : muxout=rx_ext;
   endcase        
  end*/
  
endmodule
