
class uart_tx_class;

rand bit tx_start;
rand bit[7:0] tx_data_in;
bit parity_bit_error ,stop_bit_error ;
bit[7:0] rx_data_out;


	function void print(string name = " ");
        $display("t=%0d",$time);
	$display("**************%s**********",name);
        $display(">>>>In Parent Print():uart_transaction_class<<<<<");
	$display("tx_start= %b ,tx_data_in= %08b ,  parity_bit_error=%b ,stop_bit_error=%b , rx_data_out=%8b " ,tx_start,tx_data_in ,parity_bit_error ,stop_bit_error , rx_data_out);	
	endfunction

endclass

