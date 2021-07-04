

class uart_gen_class ;
uart_tx_class ghdl;

  task gen_run();
    
    case(uart_config_class::testname)
     
      "LOOP_BACK_RANDOM_TEST":begin
          for(int i=0 ; i<1 ; i =i+1) begin
              $display("Inside loop back random test");
              $display(" *** %0d.Inside Generator before randomization***",i);
              ghdl = new();
	     assert(ghdl.randomize()with {msel==0;});
             $display("Generator : i= %d,ghdl =%p", i,ghdl);
             ghdl.print("Generator after randomization");
             uart_config_class ::gen2bfm.put(ghdl);
	   end
      end

       "RECEIVER_RANDOM_TEST":begin
          for(int i=0 ; i<1 ; i =i+1) begin
              $display("Inside receiver random test");
              $display(" *** %0d.Inside Generator before randomization***",i);
              ghdl = new();
	     assert(ghdl.randomize()with{msel==1;});
             $display("Generator : i= %d,ghdl =%p", i,ghdl);
             ghdl.print("Generator after randomization");
             uart_config_class ::gen2bfm.put(ghdl);
	   end
      end
     
       "TRANSMITTER_RANDOM_TEST":begin
          for(int i=0 ; i<1 ; i =i+1) begin
              $display("Inside transmitter random test");
              $display(" *** %0d.Inside Generator before randomization***",i);
              ghdl = new();
	     assert(ghdl.randomize()with{msel==0;});
             $display("Generator : i= %d,ghdl =%p", i,ghdl);
             ghdl.print("Generator after randomization");
             uart_config_class ::gen2bfm.put(ghdl);
	   end
      end

       "EVEN_NO_OF_ONES_DATA_TEST":begin
          for(int i=0 ; i<4 ; i =i+1) begin
              $display("Inside even parity random test");
              $display(" *** %0d.Inside Generator before randomization***",i);
              ghdl = new();
	     assert(ghdl.randomize()with{msel==0; ^tx_data_in[7:0]==0; });
             $display("Generator : i= %d,ghdl =%p", i,ghdl);
             ghdl.print("Generator after randomization");
             uart_config_class ::gen2bfm.put(ghdl);
	   end
      end
 
       "ODD_NO_OF_ONES_DATA_TEST":begin
          for(int i=0 ; i<4 ; i =i+1) begin
              $display("Inside odd parity  random test");
              $display(" *** %0d.Inside Generator before randomization***",i);
              ghdl = new();
	     assert(ghdl.randomize()with{msel==0; ^tx_data_in[7:0]==1; });
             $display("Generator : i= %d,ghdl =%p", i,ghdl);
             ghdl.print("Generator after randomization");
             uart_config_class ::gen2bfm.put(ghdl);
	   end
      end

       
       "PARITY_ERROR_TEST":begin
          for(int i=0 ; i<4 ; i =i+1) begin
              $display("Inside parity error test");
              $display(" *** %0d.Inside Generator before randomization***",i);
              ghdl = new();
	     assert(ghdl.randomize()with{msel==1; rx_ext_tran[9]==~^rx_ext_tran[8:1] ; });
             $display("Generator : i= %d,ghdl =%p", i,ghdl);
             ghdl.print("Generator after randomization");
             uart_config_class ::gen2bfm.put(ghdl);
	   end
      end

         
       "STOP_BIT_ERROR_TEST":begin
          for(int i=0 ; i<4 ; i =i+1) begin
              $display("Inside stop bit error test");
              $display(" *** %0d.Inside Generator before randomization***",i);
              ghdl = new();
	     assert(ghdl.randomize()with{msel==1; rx_ext_tran[10]==0; });
             $display("Generator : i= %d,ghdl =%p", i,ghdl);
             ghdl.print("Generator after randomization");
             uart_config_class ::gen2bfm.put(ghdl);
	   end
      end

       "START_BIT_ERROR_TEST":begin
          for(int i=0 ; i<4 ; i =i+1) begin
              $display("Inside start bit error test");
              $display(" *** %0d.Inside Generator before randomization***",i);
              ghdl = new();
	     assert(ghdl.randomize()with{msel==1; rx_ext_tran[0]==1; });
             $display("Generator : i= %d,ghdl =%p", i,ghdl);
             ghdl.print("Generator after randomization");
             uart_config_class ::gen2bfm.put(ghdl);
	   end
      end
         "LSB_RECEPTION_DATA_TEST":begin
          for(int i=0 ; i<1 ; i =i+1) begin
              $display("lsb reception data test");
              $display(" *** %0d.Inside Generator before randomization***",i);
              ghdl = new();
	     assert(ghdl.randomize()with {msel==0;});
             $display("Generator : i= %d,ghdl =%p", i,ghdl);
             ghdl.print("Generator after randomization");
             uart_config_class ::gen2bfm.put(ghdl);
	   end
      end
   
    endcase
  
   endtask
endclass
