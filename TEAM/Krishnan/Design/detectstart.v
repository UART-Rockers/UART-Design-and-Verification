///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//Detect start: Ideally the receiver receives continuous 1, as soon as the 0 is detected which is done by this module, the reception of data starts.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module detect_bit( startbit,rxin,clk);
input rxin,clk;
output reg startbit;
reg [3:0]x=0;
always@(posedge clk)
begin
if(!rxin)
begin
if (x==4'd12) //8 clock cycles for datain,1 for startbit,1 paritybit,1 stop bit..detect in 12th bit
begin
startbit=1; //detect 0 to start the Rx;
x=0;
end
else
begin
startbit=0;
x=x+1; //start counting 1's as per mentioned in the specs.
end
end
else
begin //default case statement
x=0;
startbit=0;
end
end
endmodule