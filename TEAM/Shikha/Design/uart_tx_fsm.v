module uart_tx_fsm(clk , rstn , tx_start , shift ,select , load , tx_busy );

input clk ,rstn , tx_start ;
output reg  shift , load , tx_busy ;
output reg [1:0] select ;



parameter IDLE = 3'b000 , START_BIT = 3'b001 , DATA_BIT = 3'b010 , PARITY_BIT=3'b011 , STOP_BIT =3'b100 ;

reg [2:0] next , state , count ;
wire  flag ;


always@(posedge clk , negedge rstn)
begin //1
if( ! rstn || ! tx_start ) begin //2
state <= IDLE ;
count <= 0 ;
end //2

else 
begin //3
state <= next  ;
if(state ==  DATA_BIT)
 count<= count + 1 ;

else 
count <= 0 ;

end //3

end //1


assign flag = (count == 7) ;


always@(*) begin
case(state)

IDLE : begin 
shift =0 ;
load = 0 ;
select = 2'b11 ; 
tx_busy = 0 ;
if (tx_start ) 
next = START_BIT ;
else
next = IDLE ;
end



START_BIT : begin 
shift = 0 ;
load = 1;
select = 2'b00 ;
tx_busy = 1 ;
next =DATA_BIT ;
end



DATA_BIT : begin
load = 0;
shift =1 ;
select = 2'b01 ;
tx_busy = 1 ;
if(! flag )
next = DATA_BIT ;
else 
next =PARITY_BIT ;
end


PARITY_BIT : begin
load =1 ;
shift = 0;
select = 2'b10 ;
tx_busy = 1 ;
next = STOP_BIT ;
end


STOP_BIT : begin
load = 0 ;
shift = 0 ;
tx_busy = 0 ;
select = 2'b11 ;
if(! tx_start)
next = IDLE ;
else
next = STOP_BIT ;
end

default : begin
load = 0 ;
shift = 0 ;
tx_busy = 0 ;
select = 2'b11 ;  // doubt 
next = IDLE ;
end



endcase
end
endmodule

