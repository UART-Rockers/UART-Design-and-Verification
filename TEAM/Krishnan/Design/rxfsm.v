module fsm_reciver(shift,
load,
checkstop,
startbit,
paritybiterror,
clk,
reset);

input startbit,clk,reset,paritybiterror;
output reg load,shift,checkstop;

parameter idle=2'b00,data=2'b01,paritybit=2'b10,stopbit=2'b11;

reg [1:0]state;
reg [1:0]nextstate;
reg flag2=0;//for d8->d15;
reg flag=0;//for d0->d7;
reg temp=0;//for d0->d7;
reg temp1=0;//for d8->d15;
reg [3:0]x=4'd0;//counter value for d0->d7
reg[3:0]count=4'd0;//counter value for d8->d15;

always@(posedge clk)
begin

case(state)
idle:begin nextstate<=startbit?data:idle; load<=0; shift<=0;temp<=0;temp1<=0;end
data:begin nextstate<=flag?paritybit:data; load<=0; shift<=1;temp<=1;temp1<=0;end
paritybit:begin nextstate<=flag2?idle:(flag?stopbit:paritybit);temp<=0;temp1<=1; load<=1; shift<=0; end
stopbit:begin nextstate<=flag2?idle:stopbit; load<=0; shift<=0; checkstop<=1;temp<=0;temp1=<1;end
endcase

end

//this is for checking d0->d7 bits;
always@(posedge clk)
begin
if(temp)
begin
if(x==3'd7)
begin
x<=3'd0; //reset the counter to 0 value
flag<=1;
end
else
begin
flag<=0; 
x<=x+1; //increment the counter value
end
end
else
begin
flag<=0; //default conditions
x<=0;
end
end


//this is for checkin g d8->d15 bits
always@(posedge clk)
begin
if(temp1)
begin
if(count==15)
begin
flag2=1;
count=0; //reset the counter value
end
else
begin
flag2=0;
count=count+1;//increment the counter value
end
end
else
begin
count=0;//default condition
flag2=0;//default condition
end
end

always@(posedge clk or negedge reset) //modelling as asynchronous reset
begin
if(~reset)//active low of reset 
state<=idle; //return to idle state if reset is enabled
else
state<=nextstate; //else start the finite automata
end

endmodule