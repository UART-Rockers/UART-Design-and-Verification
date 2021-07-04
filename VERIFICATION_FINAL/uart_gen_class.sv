
class uart_bfm_class;
uart_tx_class tx;
virtual uart_intf bfm_vif;
int cnt;
int i,j;  

  
  
  task bfm_run();
    bfm_vif=uart_config_class::svif ;
    forever begin
      tx=new();
      wait(bfm_vif.rstn==1);
      uart_config_class::gen2bfm.get(tx);
      case(uart_config_class::Operated_mode)
        "LOOP_BACK":begin
          $display("***Inside Loop Back Driver***");
          uart_drive_in_out_loop_back(tx);
          cnt=0;
        end
        "RECEIVER":begin
          $display("***Inside Receiver Driver***");
          uart_drive_in_out_recevier(tx);
          cnt=0;
        end
        "TRANSMITTER":begin
          $display("***Inside Transmitter Driver****");
          uart_drive_in_out_transmitter(tx);
          cnt=0;
        end
      endcase
    end
  endtask
  

  task uart_drive_in_out_loop_back(input uart_tx_class tx);
	    bit tx_start_0 = 0;
	    bit tx_start_1 = 1;
    while (cnt<13) begin 
          @( posedge bfm_vif.clk_out);          
            if(cnt == 0) begin
		tx.tx_start = tx_start_1;//means driving tx_start = '1'
		bfm_vif.tx_start = tx.tx_start; 
		bfm_vif.tx_data_in  = tx.tx_data_in;//change to blocking assignment
                bfm_vif.msel=tx.msel;
                cnt=cnt+1;
                $display("Inside Driver : tx_start=%d,tx_data_in=%b,msel=%d",bfm_vif.tx_start,bfm_vif.tx_data_in,bfm_vif.msel);
	     end
           else if(cnt>0 && cnt<11) begin 
		bfm_vif.tx_start = tx.tx_start;
		bfm_vif.tx_data_in  = tx.tx_data_in;
                cnt=cnt+1;
                $display("Inside Driver  : tx_start=%d,tx_data_in=%b",bfm_vif.tx_start,bfm_vif.tx_data_in);
	    end
           else if(cnt >=11 && cnt<13) begin //only for code Author: remember: cnt!=11, tx_busy ==1
		tx.tx_start = tx_start_0;//means driving tx_start = '0'
	        bfm_vif.tx_start = tx.tx_start;
		bfm_vif.tx_data_in  = tx.tx_data_in;//change to blocking assignment
                cnt=cnt+1;
                $display("Inside Driver  : tx_start=%d,tx_data_in=%b",bfm_vif.tx_start,bfm_vif.tx_data_in);
	   end
        end
          endtask
  
     
          task uart_drive_in_out_recevier(input uart_tx_class tx);
               while(cnt<13) begin
                  cnt++;
                 @(posedge bfm_vif.clk_out)
                     if(cnt<3) begin
                         bfm_vif.rx_ext=tx.sent_stop;
                         bfm_vif.msel=tx.msel;
                         $display("Inside Receiver Driver (Idle bit) :rx_ext=%b,msel=%d",bfm_vif.rx_ext,bfm_vif.msel);
                     end
         	     else if(2<cnt<14)begin
                          bfm_vif.rx_ext=tx.rx_ext_tran[cnt-3];
                          $display("Inside Receiver Driver (Data bit) :rx_ext=%b,msel=%d",bfm_vif.rx_ext,bfm_vif.msel);
       	              end
               end        
           endtask
  
   
        
         task uart_drive_in_out_transmitter( input uart_tx_class tx);
              int i = 0;	
              bit prev_busy_0 = 0;
	      bit cnt_en = 0;
	      bit tx_start_0 = 0;
	      bit tx_start_1 = 1;
              while (cnt<12) begin //dont change randomly think and change
                @( posedge bfm_vif.clk_out);
		          $display("[%0d].the BFM cnt = %0d,busy = %0d",i,cnt,bfm_vif.tx_busy);
                          $display("rstn = %b",bfm_vif.rstn);
			//Checking if the previous tx_busy is '0' and present tx_busy = 1
				//only for code Author: note - in the simulator the update of tx_busy to the TB
                  if (prev_busy_0 == 1 &&  bfm_vif.tx_busy == 1) begin//whenever the prev busy is 1 , it means that the real prev busy is 0
				   cnt_en = 1;	//set the cnt_en flag
			           prev_busy_0 = 0; //reset prev_busy_0 flag
                     $display("1. setting cnt_en = %0d,de-assert prev_busy_0=%0d",cnt_en,prev_busy_0);
		  end
			//checking if at start (represented by cnt==0), is tx_busy '0' at start
	           if(cnt == 0 && bfm_vif.tx_busy == 0) begin
				    prev_busy_0 = 1; //set prev_busy_flag//only a flag
				    tx.tx_start = tx_start_1;//means driving tx_start = '1'
				    bfm_vif.tx_start = tx.tx_start; //keep driving tx_start and tx_data from idle state
				    bfm_vif.tx_data_in  = tx.tx_data_in;//change to blocking assignment
                                    $display("2. cnt = %0d,busy = %0d,setting prev_busy_0=%0d",cnt,bfm_vif.tx_busy,prev_busy_0);
                                    $display("2.DRIVING inputs tx=%p",tx);
                     end
			//cnt_en flag set means we are in data_bit state hence continue driving the data & start counting 
                  if(cnt_en == 1 && cnt != 11) begin //only for code Author: remember: cnt!=11, tx_busy ==1
			    	    ++cnt;
				    tx.tx_start = tx_start_1;//means driving tx_start = '1'
				    bfm_vif.tx_start = tx.tx_start;
				    bfm_vif.tx_data_in  = tx.tx_data_in;//change to blocking assignment
                    $display("3. cnt_en=%0d, ++cnt = %0d,busy = %0d",cnt_en,cnt,bfm_vif.tx_busy);
                    $display("3.DRIVING inputs tx=%p",tx);
                    end
			//when counter reaches '10' start 
                    else if(cnt == 11) begin //only for code Author: remember: cnt!=11, tx_busy ==1
				   ++cnt;
				   tx.tx_start = tx_start_0;//means driving tx_start = '0'
				   bfm_vif.tx_start = tx.tx_start;
				   bfm_vif.tx_data_in  = tx.tx_data_in;//change to blocking assignment
                   $display("4. ++cnt = %0d,busy = %0d",cnt,bfm_vif.tx_busy);
                   $display("4.DRIVING inputs tx=%p",tx);
                   end
                  $display("General inputs tx=%p",tx);
	     end

         endtask
endclass
                    
