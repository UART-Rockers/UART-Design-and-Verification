class uart_mon_class;
 uart_tx_class mhdl;
 virtual uart_intf mon_vif;
  int cnt ;
  
  //rx
  bit[1:0] sent_stop_array;
  bit[10:0] uart_frame_array;
  bit[12:0] overall;
  
  
  //Tx
  int count=0;
  bit start_store;
  bit [7:0]data_store;
  bit parity_store;
  bit stop_store;
  bit [10:0]overallt;
  
  task mon_run();
    mon_vif=uart_config_class:: svif;
    forever begin
      mhdl=new();
      wait(mon_vif.rstn==1);
        case(uart_config_class::Operated_mode)
        "LOOP_BACK":begin
           $display("***Inside Loop Back Monitor***");
           uart_mon_in_out_loop_back(mhdl);
        end
        "RECEIVER":begin
           $display("***Inside Receiver Monitor***");
           uart_mon_in_out_recevier(mhdl);
        end
        "TRANSMITTER":begin
          $display("***Inside Transmitter Monitor****");
          uart_mon_in_out_transmitter(mhdl);
        end
      endcase
     
    end
  endtask
  
  
  task uart_mon_in_out_loop_back(input uart_tx_class mhdl);
     @(posedge mon_vif.clk_out)
      if(cnt==1) begin
       mhdl.tx_start =  mon_vif.tx_start;
       mhdl.tx_data_in= mon_vif.tx_data_in;
       mhdl.msel=mon_vif.msel;
        $display("Monitor(Input data) : msel=%d,tx_start=%d,tx_data_in=%d",mhdl.msel,mhdl.tx_start ,mhdl.tx_data_in);
         uart_config_class:: mon2sbd1.put(mhdl);
      end
      @(negedge mon_vif.clk_out)
      if(cnt==11) begin
        mhdl.parity_bit_error= mon_vif.parity_bit_error ;
        mhdl.stop_bit_error=mon_vif.stop_bit_error ;
        mhdl.rx_data_out=mon_vif.rx_data_out;
        $display("Monitor(Output data) : parity_bit_error=%d,stop_bit_error=%d,rx_data_out=%d",mhdl.parity_bit_error,mhdl.stop_bit_error,mhdl.rx_data_out);
        uart_config_class:: mon2sbd.put(mhdl);
      cnt=-1;
      end
       else
        cnt++;
   endtask
  
  
   task uart_mon_in_out_recevier(input uart_tx_class mhdl);
     @(posedge mon_vif.clk_out)
     @(negedge mon_vif.clk_out)
     if(cnt<13)begin
       cnt++;
     case(cnt)
       1,2: begin
         sent_stop_array[cnt-1]=mon_vif.rx_ext;       
       end
       3,4,5,6,7,8,9,10,11,12,13:begin
         uart_frame_array[cnt-3]=mon_vif.rx_ext;
         if(cnt==13) begin
           
         overall[1:0]=sent_stop_array;
         overall[12:2]=uart_frame_array;
           $display("Monitor : 11 bit Tranaction Frame=%p", overall[12:2]);
           $display("Monitor : 8 bit Rx data=%p", overall[10:3]);
           mhdl.parity_bit_error=mon_vif.parity_bit_error;
           mhdl.stop_bit_error=mon_vif.stop_bit_error;
           mhdl.rx_data_out=mon_vif.rx_data_out;
           mhdl.msel=mon_vif.msel;
           uart_config_class ::mon2sbd1.put(mhdl);
           uart_config_class::mon2sbd1.put(overall);
           $display("Monitor : mhdl=%p", mhdl);
           cnt=0;
      
         end
       end
      endcase
      end
   endtask  
  
  
  task uart_mon_in_out_transmitter(input uart_tx_class mhdl);
       @(negedge mon_vif.clk_out);  
      if(mon_vif.tx_busy && count<13) begin
        count++;
        case(count)
          1:begin
            $display("start count=%d",count);
            start_store=mon_vif.tx_data_out;
           // overall[0]=start_store;
            $display("start store : %b",start_store);
          end
          2,3,4,5,6,7,8,9:begin
            $display("count 2=%d",count);
            data_store[count-2]=mon_vif.tx_data_out;
            $display("data store : %b",data_store[count-2]);
          end
          10:begin
            parity_store=mon_vif.tx_data_out;
            $display("parity store : %b",parity_store);
          end
          11:begin
            stop_store=mon_vif.tx_data_out;
            $display("stop store : %b",stop_store);
          end
          12:begin
            count=0;
            overallt[0]=start_store;
            $display("start: %p",overallt[0]);
            overallt[8:1]=data_store[7:0];
            $display("data: %p",overallt[8:1]);
            overallt[9]=parity_store;
            $display("parity: %p",overallt[9]);
            overallt[10]=stop_store;
            $display("stop: %p",overallt[10]);
            $display("Monitor : %p",overallt);
            $display("Monitor : %b",overallt);
            mhdl.tx_start=mon_vif.tx_start;//sample in the 1st cycle itself 
            mhdl.tx_data_in=mon_vif.tx_data_in; 
            //a=th.tx_data;
            mhdl.tx_busy=mon_vif.tx_busy;
            mhdl.tx_data_out=mon_vif.tx_data_out;
            uart_config_class::mon2sbd1.put(mhdl);
            uart_config_class::mon2sbd.put(overallt);
            start_store=0;
            //data_store.delete; //should check
            parity_store=0;
            stop_store=0;
            //overall.delete;
          end
         
        endcase
      end
     endtask
   

endclass

  
  


