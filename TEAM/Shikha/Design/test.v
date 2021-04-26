`include "uart_top.v"
module test;
reg clk , rstn ,tx_start ;
reg  [7:0] tx_data_in ;
  reg [1:0] sel;

wire  parity_bit_error ,stop_bit_error ;
wire [7:0] rx_data_out ;
  
  uart_top     top(.clk(clk),.rstn(rstn),.sel(sel),.tx_start(tx_start),.tx_data_in(tx_data_in),.parity_bit_error(parity_bit_error) ,.stop_bit_error(stop_bit_error),.rx_data_out(rx_data_out));
  
initial begin
  $dumpvars(0,test);
    $dumpfile("v.vcd");
  $monitor($time,"tx_start=%d,tx_data_in=%d,parity_bit_error=%d ,stop_bit_error=%d ,rx_data_out=%d,sel=%d",tx_start,tx_data_in,parity_bit_error ,stop_bit_error,rx_data_out,sel);
end
initial forever #5 clk= ~clk;
initial begin
 clk =0;rstn=0;
  #10 rstn=1;sel=0;
  #10 tx_start=1; tx_data_in=33;
  
  #2000;
  $finish;
end
  
  
  
  
  
endmodule
