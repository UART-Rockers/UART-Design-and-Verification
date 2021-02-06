module piso (clk, tx_data, shift, load_data, data_bit);

    input clk, shift, load_data;
    input [7:0] tx_data;

    output data_bit;

    reg [7:0] temp;
    integer i;

    always @ (posedge clk) begin
        if(load_data) 
            for (i=7; i >= 0; i=i-1)
                temp[7-i] <= tx_data[i];

        if(shift) 
            temp <= {temp[6:0], 1'b0};
    end

    assign data_bit = temp[7];

endmodule

/*
module pisotest;

    reg clk, shift, load_data;
    reg [7:0] tx_data;

    wire data_bit;

    piso p1 (.clk(clk), .tx_data(tx_data), .shift(shift), .load_data(load_data), .data_bit(data_bit));

    initial begin
        $dumpfile("piso_tb.vcd");
        $dumpvars(0, pisotest);

        clk=1; tx_data=8'b10110011; load_data=0; shift=0;
        #4 load_data=1; shift=0;
    	#4 load_data=0; shift=1;
    end

    always #2 clk=~clk;

    initial begin 
        $monitor("time=%0d, clk=%b, tx_data=%b, shift=%b, load_data=%b, data_bit=%b", $time, clk, tx_data, shift, load_data, data_bit);
    end

endmodule
*/