`include "top.v"

module test;

    reg clk, rst, tx_start;
    reg [7:0] tx_data;

    wire tx_busy, tx_data_out;
    
    top t1 (.clk(clk), .rst(rst), .tx_start(tx_start), .tx_data(tx_data), .tx_busy(tx_busy), .tx_data_out(tx_data_out));
    
    initial begin
  clk=0;
end

always # 5 clk=~clk;

initial begin
       // clk=0; rst=1; tx_start=1; tx_data=8'b10110011;
    	//#4; 
       // rst=0;
rst=1'b1;
#2;
rst=1'b0;
end

initial begin
tx_start=1'b1;
tx_data=$random;
$display("the value sent to Rx is %0b",tx_data);
 #1000;
$finish();
     end
    
endmodule