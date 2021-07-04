// Code your design here
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
bit[1:0] sel ;
uart_env_class ehdl;
event e;
  

uart_intf pif( .clk(clk) ,.rstn(rstn),.sel(sel)); 
uart_top top (.clk(pif.clk),.rstn(pif.rstn),.sel(pif.sel),.tx_start(pif.tx_start),.tx_data_in(pif.tx_data_in),.parity_bit_error(pif.parity_bit_error) ,.stop_bit_error(pif.stop_bit_error),.rx_data_out(pif.rx_data_out),.clk_out(pif.clk_out),.msel(pif.msel),.rx_ext(pif.rx_ext),.tx_data_out(pif.tx_data_out),.tx_busy(pif.tx_busy));
 
initial begin
uart_config_class :: svif =pif ;
end
  
  
 initial forever #5 clk=~clk;
  
  initial begin
    ehdl=new();
  //  @(e); 
    rstn=1'b0; 
    repeat(2) @(posedge clk);
    rstn=1'b1;
    $display("Inside UART ENV");
    ehdl.env_run();
  end
  
  
  initial begin  // it is also starting from 0 ns
   $value$plusargs("Operated_mode=%s",uart_config_class::Operated_mode);
   $value$plusargs("testname=%s",uart_config_class::testname);
   $value$plusargs("sel=%d",sel);
    //->e;
   end
  
  
  initial begin
    $dumpvars(0,uart_tb_top);
    #90000;
    $finish;
  end
  
endmodule
 


  
  



