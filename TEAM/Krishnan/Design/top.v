`include "txfsm.v"
`include "uart_mux.v"
`include "uart_piso.sv"
`include "uart_parity_gen.v"

module top(clk, rst, tx_start, tx_data, tx_data_out, tx_busy);

    input clk, rst, tx_start;
    input [7:0] tx_data;

    output tx_busy, tx_data_out;

    wire shift, load_data, data_bit, parity_bit;
    wire [1:0] select;

    reg start_p = 0, stop_p = 1;

    txfsm t1 (.clk(clk), .rst(rst), .tx_start(tx_start), .shift(shift), .load_data(load_data), .select(select), .tx_busy(tx_busy));

    piso p1 (.clk(clk), .tx_data(tx_data), .shift(shift), .load_data(load_data), .data_bit(data_bit));

    parity_generator pg1 (.tx_data(tx_data), .load_data(load_data), .parity_bit(parity_bit));

    TXmux m1 (.start_bit(start_p), .data_bit(data_bit), .parity_bit(parity_bit), .stop_bit(stop_p), .select(select), .tx_data_out(tx_data_out));

endmodule