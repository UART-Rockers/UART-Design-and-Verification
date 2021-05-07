
interface uart_intf(input logic clk ,rstn,input logic [1:0] sel);
logic tx_start;
logic[7:0] tx_data_in;
logic parity_bit_error ,stop_bit_error ;
logic[7:0] rx_data_out;
logic clk_out;
endinterface
e
