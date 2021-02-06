module mux (start_bit, data_bit, parity_bit, stop_bit, select, tx_data_out);

    input start_bit, data_bit, parity_bit, stop_bit;
    input [1:0] select;

    output reg tx_data_out;
    
    always @(*) begin
        case (select)
            2'd0 : tx_data_out = start_bit;
            2'd1 : tx_data_out = data_bit;
            2'd2 : tx_data_out = parity_bit;
            2'd3 : tx_data_out = stop_bit;
        endcase        
    end
    
endmodule
 
/*
module muxtest;

    reg start_bit, data_bit, parity_bit, stop_bit;
    reg [1:0] select;

    wire tx_data_out;

    mux m1 (.start_bit(start_bit), .data_bit(data_bit), .parity_bit(parity_bit), .stop_bit(stop_bit), .select(select), .tx_data_out(tx_data_out));

    initial begin 
        $dumpfile("mux_tb.vcd");
        $dumpvars(0, muxtest);

        start_bit=0; data_bit=0; parity_bit=1; stop_bit=1; select=2'b00;
        #2 select=2'b01; data_bit=1; 
        #2 data_bit=0;
        #2 data_bit=1;
        #2 data_bit=1;
        #2 data_bit=1;
        #2 data_bit=1;
        #2 data_bit=0;
        #2 select=2'b10; 
        #2 select=2'b11;
        $finish();
    end

    initial begin 
        $monitor("time=%0d, start_bit=%b, data_bit=%b, parity_bit=%b, stop_bit=%b, select=%b, tx_data_out=%b", $time, start_bit, data_bit, parity_bit, stop_bit, select, tx_data_out);
    end

endmodule
*/

