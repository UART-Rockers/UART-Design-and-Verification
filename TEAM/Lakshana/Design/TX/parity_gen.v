module parity_gen (tx_data, load_data, parity_bit);

    input load_data;
    input [7:0] tx_data;

    output reg parity_bit;

    always @ (*) begin
        if(load_data) begin
            parity_bit = ^(tx_data);
    	end
    	else begin
            parity_bit = 0;
    	end
    end

endmodule

/*
module paritygentest;

    reg load_data;
    reg [7:0] tx_data;

    wire parity_bit;

    parity_gen p1 (.tx_data(tx_data), .load_data(load_data), .parity_bit(parity_bit));

    initial begin 
        $dumpfile("parity_gen_tb.vcd");
        $dumpvars(0, paritygentest);

        tx_data=8'b01011110; load_data=0;
        #2 load_data=1;
        #2 tx_data=8'b01011111; load_data=0;
        #2 load_data=1;
        $finish();
    end

    initial begin 
        $monitor("time=%0d, tx_data=%b, load_data=%b, parity_bit=%b", $time, tx_data, load_data, parity_bit);
    end

endmodule
*/
