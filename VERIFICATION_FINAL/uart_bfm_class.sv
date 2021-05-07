


class uart_bfm_class;
uart_tx_class tx;
virtual uart_intf bfm_vif;
int cnt;

  
  
  task bfm_run();
    bfm_vif=uart_config_class::svif ;
    forever begin
      tx=new();
      wait(bfm_vif.rstn==1);
      uart_config_class::gen2bfm.get(tx);
      uart_drive_in_out(tx);
      cnt=0;
    end
  endtask
  

  task uart_drive_in_out(input uart_tx_class tx);
	    bit tx_start_0 = 0;
	    bit tx_start_1 = 1;
    while (cnt<13) begin 
          @( posedge bfm_vif.clk_out);          
            if(cnt == 0) begin
              $display("count1=%d",cnt);
				tx.tx_start = tx_start_1;//means driving tx_start = '1'
				bfm_vif.tx_start = tx.tx_start; 
				bfm_vif.tx_data_in  = tx.tx_data_in;//change to blocking assignment
                cnt=cnt+1;
             // $display("tx_start=%d,tx_data_in=%b",bfm_vif.tx_start,bfm_vif.tx_data_in);
			end
           else if(cnt>0 && cnt<11) begin 
           // $display("count2=%d",cnt);
				//tx.tx_start = tx_start_1;//means driving tx_start = '1'
				bfm_vif.tx_start = tx.tx_start;
				bfm_vif.tx_data_in  = tx.tx_data_in;//change to blocking assignment
                cnt=cnt+1;
			end
          else if(cnt >=11 && cnt<13) begin //only for code Author: remember: cnt!=11, tx_busy ==1
              //  $display("count3=%d",cnt);
				tx.tx_start = tx_start_0;//means driving tx_start = '0'
				bfm_vif.tx_start = tx.tx_start;
				bfm_vif.tx_data_in  = tx.tx_data_in;//change to blocking assignment
                cnt=cnt+1;
			end
        end
          endtask

endclass

