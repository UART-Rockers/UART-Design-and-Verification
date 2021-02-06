`include "mux.v"
`include "tx_fsm.v"
`include "piso.v"
`include "parity_gen.v"

module top (clk, rst, tx_start, tx_data, tx_data_out, tx_busy);

    input clk, rst, tx_start;
    input [7:0] tx_data;

    output tx_busy, tx_data_out;

    wire shift, load_data, data_bit, parity_bit;
    wire [1:0] select;

    reg start_p = 0, stop_p = 1;

    tx_fsm t1 (.clk(clk), .rst(rst), .tx_start(tx_start), .shift(shift), .load_data(load_data), .select(select), .tx_busy(tx_busy));

    piso p1 (.clk(clk), .tx_data(tx_data), .shift(shift), .load_data(load_data), .data_bit(data_bit));

    parity_gen pg1 (.tx_data(tx_data), .load_data(load_data), .parity_bit(parity_bit));

    mux m1 (.start_bit(start_p), .data_bit(data_bit), .parity_bit(parity_bit), .stop_bit(stop_p), .select(select), .tx_data_out(tx_data_out));

endmodule

module test;

    reg clk, rst, tx_start;
    reg [7:0] tx_data;

    wire tx_busy, tx_data_out;

    top t1 (.clk(clk), .rst(rst), .tx_start(tx_start), .tx_data(tx_data), .tx_busy(tx_busy), .tx_data_out(tx_data_out));

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, test);

        clk=1; rst=1; tx_start=0; tx_data=8'b10110011; 
    	#10; 
        rst=0; 
        #10;
        tx_start=1;
        #52 tx_start=0;
        #12 tx_start=1;
    end

    always #2 clk=~clk;

    initial begin 
        $monitor("time=%0d, clk=%b, rst=%b, tx_start=%b, tx_data=%b", $time, clk, rst, tx_start, tx_data);
    end

endmodule