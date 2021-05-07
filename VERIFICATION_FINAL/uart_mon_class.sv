class uart_mon_class;
 uart_tx_class mhdl;
 virtual uart_intf mon_vif;
  int cnt ;
  
  task mon_run();
    mon_vif=uart_config_class:: svif;
    forever begin
      mhdl=new();
      wait(mon_vif.rstn==1);
     @(posedge mon_vif.clk_out)
      if(cnt==1) begin
       mhdl.tx_start =  mon_vif.tx_start;
       mhdl.tx_data_in= mon_vif.tx_data_in;
        $display("1cnt_mon=%d,mhdl.tx_start=%d, mhdl.tx_data_in=%d",cnt ,mhdl.tx_start ,mhdl.tx_data_in);
         uart_config_class:: mon2sbd1.put(mhdl);
      end
      @(negedge mon_vif.clk_out)
      if(cnt==11) begin
        mhdl.parity_bit_error= mon_vif.parity_bit_error ;
        mhdl.stop_bit_error=mon_vif.stop_bit_error ;
        mhdl.rx_data_out=mon_vif.rx_data_out;
        $display("cnt2_mon=%d,mhdl.parity_bit_error=%d,mhdl.stop_bit_error=%d,mhdl.rx_data_out=%d",cnt ,mhdl.parity_bit_error,mhdl.stop_bit_error,mhdl.rx_data_out);
        uart_config_class:: mon2sbd.put(mhdl);
      cnt=-1;
      end
       else
        cnt++;
      $display("cnt3_mon=%d",cnt);
     
     end
    
  endtask
  
  

endclass
