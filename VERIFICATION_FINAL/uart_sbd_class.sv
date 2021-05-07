class uart_sbd_class;
 uart_tx_class shdl;
 uart_tx_class lhdl;
  
  task sbd_run();
    forever begin
    shdl=new();
      uart_config_class:: mon2sbd1.get(shdl);
      uart_config_class::mon2sbd.get(lhdl);
      if(shdl.tx_data_in==lhdl.rx_data_out)
        $display("Pass shdl.tx_data_in=%d, shdl.rx_data_out=%d ",shdl.tx_data_in,lhdl.rx_data_out);
      else
        $display("fail shdl.tx_data_in=%d, shdl.rx_data_out=%d ",shdl.tx_data_in,lhdl.rx_data_out);
    end
  endtask
endclass
