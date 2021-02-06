module tb;
reg        clk         ;
reg        reset      ;
reg        txstart ; 
 wire    txbusy; 
output reg  [7:0] tx_dataout; // The recieved data.

reg [7:0] to_send;


tx_fsm t1(
.clk          (clk          ),
.reset      (reset      ),
.txstart   (txstart ),
.txbusy (txbusy ),
.tx_dataout (tx_dataout ) 
);



initial begin
clk=0;
end

always #5 clk=~clk;

initial begin
    reset = 1'b1;
    #10 reset = 1'b0;
   end 

task send_byte;
    input [7:0] to_send;
    begin
   
        tx_dataout= to_send;
        txstart  = 1'b1;
        $display("data sent to Rx is %b ",tx_dataout,$time);
     
    end
endtask




initial begin
   repeat(20) begin
        to_send = $random;
        send_byte(to_send);
                wait(!txbusy);
        end
#1000;
    $finish();

     $display("Finish simulation at time %d", $time);
end
endmodule