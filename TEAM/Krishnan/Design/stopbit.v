//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//After the detection of valid parity bit, the stop bit is detected, if the stop bit is not detected then reception of data is terminated by setting Stop bit error signal high.


//logic: as per mentioned in the oversampling for the uart rx, to syncrhonise the RX with the TX clock,the middle bit of the data has to be extracted to know the clock frequency.
//every bit is sampled 16 times,if there are 8 bits of data ,every bit should be sampled 2 times..
//hence the count is done two times till the data bits are 16 to confirm if the Tx frequency is the same throughout transmission

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module stop_bit (dout1,rxdataout,stopbiterror,rxin,checkstop,clk,reset);
input rxin,checkstop,clk,reset;
input [7:0]dout1;//output of paritychecker
output reg stopbiterror;
output reg [7:0] rxdataout =0;//output of the stop bit checker
reg x=3'd0;
always@(posedge clk)
begin
if (checkstop)
begin
if(rxin)
begin
if(x==15) 
begin
x<=0;
rxdataout<=dout1;
stopbiterror<=0;
end
else
begin
x=x+1;
stopbiterror<=0;
rxdataout<=dout1;
end
end
else
begin
rxdataout<=8'd0;//RX should receive only continuous 1's and not 0's.if 0 then stopbit error
stopbiterror<=1;
end
end
else
begin
rxdataout<=dout1;
stopbiterror<=0;
end
end
endmodule