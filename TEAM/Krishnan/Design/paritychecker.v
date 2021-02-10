
/////////////////////////////////////////////////////////////////////////////////////////////////
//Parity checker:Checks the correctness of data by Xoring the 10th received bit with xor value of 8 bit received data.
////////////////////////////////////////////////////////////////////////////////////////////////


module parity_checker(paritybiterror,load,dout,dout1,rxin,reset);
input load,rxin,reset;
input [7:0]dout; //output from SIPO
reg[7:0]a;
wire [7:0]b;//becasue the 8th bit of data xor with the 10th bit
output reg paritybiterror;
output [7:0]dout1; //output from the paritychecker
assign b=dout;
always@(posedge clk)
begin
if (!reset)
a<=8'h00;
else if (load)
begin
if (rxin==(^b)) //here the 8th bit is xored with the 10th bit//assuming//check
begin
a<=dout;
paritybiterror<=0;
end
else
begin
paritybiterror<=1;
a<=a;
end
end
else
begin
paritybiterror<=0;
a<=a;
end
end
assign dout1=a;
endmodule