/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SIPO: Converts serial data into 8 bit parallel data.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module sipo_(dout,clk,shift,reset,Rxin);
input clk,reset,shift;
input Rxin;
output [7:0]dout; //output to Paritychecker
reg [7:0]s=0;

always@(posedge clk)
begin
if (!reset)
begin
s=0;
end
else if(shift)
begin
s=s>>1;
s[7]=Rxin;
end
else
s=s;
end
assign dout=s;
endmodule