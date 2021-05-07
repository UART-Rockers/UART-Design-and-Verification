`include "uart_top.sv"
`include "uart_tx_class.sv"
`include "uart_intf.sv"
`include "uart_config_class.sv"
`include "uart_gen_class.sv"
`include "uart_bfm_class.sv"
`include "uart_mon_class.sv"
`include "uart_sbd_class.sv"
`include "uart_env_class.sv"
module uart_tb_top;
bit clk=0;
bit rstn=0;
bit[1:0] sel=2'b11 ;
uart_env_class ehdl;
  

uart_intf pif( .clk(clk) ,.rstn(rstn),.sel(sel)); 
  
  uart_top top (.clk(pif.clk),.rstn(pif.rstn),.sel(pif.sel),.tx_start(pif.tx_start),.tx_data_in(pif.tx_data_in),.parity_bit_error(pif.parity_bit_error) ,.stop_bit_error(pif.stop_bit_error),.rx_data_out(pif.rx_data_out),.clk_out(pif.clk_out));
 
initial begin
uart_config_class :: svif =pif ;
end
  
  
 initial forever #5 clk=~clk;
  
  initial begin
    ehdl=new();
    rstn=1'b0; 
    repeat(2) @(posedge clk);
    rstn=1'b1;
    $display("Inside UART ENV");
    ehdl.env_run();
  end
  
  initial begin
    $dumpvars(0,uart_tb_top);
    #50000;
    $finish;
  end
  
endmodule
 


  
  


