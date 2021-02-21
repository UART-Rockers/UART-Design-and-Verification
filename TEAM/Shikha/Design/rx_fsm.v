
module  rx_fsm(clk ,rstn , start_bit_dec ,shift , parity_load , parity_bit_error , check_stop ) ;

input clk ,rstn  ,parity_bit_error,  start_bit_dec ;
output reg   check_stop ,  shift ,parity_load ;

 reg [1:0] state , n_state ;
integer count ;
parameter IDLE= 0  , DATA =1 , PARITY_BIT=2 , STOP_BIT=3  ;




always @(*)
begin

case(state)
IDLE : begin check_stop = 0 ;   
shift=0  ;
parity_load = 0 ;
n_state<=start_bit_dec?DATA:IDLE;
end

DATA:begin 
check_stop = 0  ;   
shift=1 ;
parity_load = 0 ;
if(count==7)
n_state<=PARITY_BIT ;
else
n_state<= DATA ;
end

PARITY_BIT : begin 
check_stop = 0   ;   
shift=0 ;
parity_load = 1;
n_state <=parity_bit_error ?IDLE : STOP_BIT ;
end

STOP_BIT : begin 
check_stop = 1 ;     
shift=0 ;
parity_load = 0;
n_state <=IDLE ;
end

endcase
end

always@(posedge clk , negedge rstn )
begin
if(!rstn)
state<=IDLE ;
else
state<=n_state ;
end
always@(posedge clk  )
begin
if(state== DATA)
count<= count +1 ;
else
count<= 0 ;
end

endmodule 