module   TXmux  (start_bit, data_bit, parity_bit, stop_bit, select, tx_data_out);
//			00	01 	  10 		11		

// define input  port
input start_bit, data_bit, parity_bit, stop_bit;

// define input port
input [1:0] select;

// define output port
output tx_data_out;


// assign one of the inputs to the output based upon select line input
// assign out = (condition) ? (true-statement1) : (false-statement2); - ternary operator

assign tx_data_out = select[1] ? (select[0] ? stop_bit: parity_bit) : (select[0] ? data_bit : start_bit);  
//							11		10				01	00

endmodule
