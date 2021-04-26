module baud_gen(clk_in,rstn,sel,clk_out);
input clk_in,rstn;
input[1:0]  sel;
 reg[10:0] MODULUS; 
output reg clk_out;
 integer count=0;
 
  always@(*)begin
  case(sel)
	2'b00:MODULUS=12; //baud=2400;
    2'b01:MODULUS=20; //baud=9600
    2'b10:MODULUS=307200; //baud =19200;
    2'b11:MODULUS=614400; //baud =38400

endcase
end
  
  always@(posedge clk_in , negedge rstn )
    begin 
      if(rstn==0) begin
        clk_out=0;
        count=0;
      end
     else 
       begin
       if(count<(MODULUS/2))
      begin
       clk_out=0;
      count= count+1;
        $display("1vcount=%d ,MODULUS=%d",count,MODULUS);
      end
         else if(count>=(MODULUS/2)&& count<MODULUS) begin
           clk_out=1;
      count= count+1;
      
           $display("2count=%d ,MODULUS=%d",count,MODULUS);
    end
         else if(count==MODULUS) begin
      clk_out=0;
      count=1;
      $display("3count=%d",count);
    end
    end
    end
  
endmodule
