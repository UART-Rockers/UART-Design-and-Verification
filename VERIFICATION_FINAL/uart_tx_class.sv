
class uart_tx_class;

rand bit tx_start;
rand bit[7:0] tx_data_in;
rand bit msel;
bit parity_bit_error ,stop_bit_error ;
bit[7:0] rx_data_out;
bit tx_data_out,tx_busy;
//rx
rand bit sent_stop ;
rand bit[10:0] rx_ext_tran;

     constraint rx_c{ sent_stop==1;}
     constraint start_bit{soft rx_ext_tran[0]==0  ;}
     constraint parity_rx_C{ soft rx_ext_tran[9]==(rx_ext_tran[1]^rx_ext_tran[2]^rx_ext_tran[3]^rx_ext_tran[4]^rx_ext_tran[5]^rx_ext_tran[6]^rx_ext_tran[7]^rx_ext_tran[8]);}
     constraint stop_bit_rx{ soft rx_ext_tran[10]==1;}

     function void print(string name = " ");
      $display("**************%s**********",name);
      $display("***Inside transaction class***");
      $display("Transaction class : tx_start= %b ,tx_data_in= %08b ,  parity_bit_error=%b ,stop_bit_error=%b , rx_data_out=%8b ,msel=%d,rx_ext_tran=%d ,tx_data_out=%11b,tx_busy=%d " ,tx_start,tx_data_in ,parity_bit_error ,stop_bit_error , rx_data_out,msel,rx_ext_tran,tx_data_out,tx_busy);	
     endfunction

endclass

