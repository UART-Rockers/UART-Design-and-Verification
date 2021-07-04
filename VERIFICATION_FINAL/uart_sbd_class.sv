class uart_sbd_class;
 uart_tx_class shdl;
 uart_tx_class lhdl;
  //rx
   bit [12:0]ov;
  //tx
  bit [10:0]ovt;
  
  task sbd_run();
    forever begin
       shdl=new(); 
       case(uart_config_class::Operated_mode)
        "LOOP_BACK":begin
          $display("***Inside Loop Back SCOREBOARD***");
          uart_config_class::mon2sbd1.get(shdl);
          uart_config_class::mon2sbd.get(lhdl);
          $display("Expected O/p : tx_data_in=%d",shdl.tx_data_in);
          $display("Actual O/p : rx_data_out=%d",lhdl.rx_data_out);
          case(uart_config_class::testname)
          "LSB_RECEPTION_DATA_TEST":begin
            if(shdl.tx_data_in==lhdl.rx_data_out)
                   $display("LSB_RECEPTION_DATA_TEST::PASSED");
            else
                   $display("LSB_RECEPTION_DATA_TEST::FAILED");
            end 
           default:begin        
             if(shdl.tx_data_in==lhdl.rx_data_out)
                   $display("Pass");
             else
                  $display("fail");
             end
            endcase
            end
    
        "RECEIVER":begin
            $display("***Inside Receiver  SCOREBOARD***");
            uart_config_class::mon2sbd1.get(shdl);
            uart_config_class::mon2sbd1.get(ov);
            $display("Expected O/p : %p",ov[10:3]);
           $display("Actual O/p : %p",shdl);
           case(uart_config_class::testname)
           "PARITY_ERROR_TEST": begin
            if(shdl.parity_bit_error==1)
                $display("PARITY_ERROR_TEST::PASSED");
            else
                $display("PARITY_ERROR_TEST::FAILED");
            end
            "STOP_BIT_ERROR_TEST":begin
             if(shdl.stop_bit_error==1)
                $display("STOP_BIT_ERROR_TEST::PASSED");
            else
                $display("STOP_BIT_ERROR_TEST::FAILED");
            end
            "START_BIT_ERROR_TEST":begin
              if(shdl.rx_data_out==0)
                $display("START_BIT_ERROR_TEST::PASSED");
            else
                $display("START_BIT_ERROR_TEST::FAILED");
            end
            default:begin
            if(ov[10:3]==shdl.rx_data_out)
                   $display(" default Pass");
              else 
                   $display(" default Fail");
            end
           endcase
          end

        "TRANSMITTER":begin
          $display("***Inside Transmitter  SCOREBOARD****");
          uart_config_class::mon2sbd1.get(shdl);
          uart_config_class::mon2sbd.get(ovt);
          $display("actual_Scoreboard : %b",ovt[8:1]);
          $display("exp_Scoreboard : %b",shdl.tx_data_in);
          if(shdl.tx_data_in==ovt[8:1]) begin
              $display("passed");
            end
            else begin
             $display("failed");
            end
          end
       endcase   
   end
  endtask
endclass

