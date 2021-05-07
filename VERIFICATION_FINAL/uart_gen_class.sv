

class uart_gen_class ;
uart_tx_class ghdl;

	task gen_run()
           for(int i ; i<3 ; i =i+1;) begin
           $display(">>++++++>> %0d.Inside the UART_Transmitter_Generator Class <<+++++<<",i);
	   ghdl = new();
	   asssert(ghdl.randomize());
	   $display("i= %d,ghdl =%p", i,ghdl);
           ghdl.print("UART GERNERATOR CLASS : After randmoization");
           uart_config_class ::gen2bfm.put(ghdl);
	   end
	endtask

endclass
