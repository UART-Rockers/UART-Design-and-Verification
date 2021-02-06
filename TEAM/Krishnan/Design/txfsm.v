module txfsm (clk, rst, tx_start, shift, load_data, select, tx_busy);

    input clk, rst, tx_start;

    output reg shift, load_data, tx_busy;
    output reg [1:0] select;

    reg [2:0] state, next, count;  
    wire flag;  


    // State encodings 
    parameter [2:0] IDLE=3'b000, START_BIT=3'b001, DATA_BIT=3'b010, PARITY_BIT=3'b011, STOP_BIT=3'b100;

    always @(posedge clk, posedge rst) begin 
      if(rst) begin 
        state <= IDLE;
        count <= 0;
      end
      else begin 
        state <= next; 
        if(state == DATA_BIT) 
          count <= count + 1;
        else 
          count <= 0;
      end
    end

    assign flag = (count == 7);

    // State transitions and outputs
    always @(*) begin 
      case(state) 
        IDLE: begin 
          shift = 0;
          load_data = 0;
          select = 2'b11;
          tx_busy = 0;
          if (tx_start) 
            next = START_BIT; 
          else 
            next = IDLE;
        end 
        START_BIT: begin 
          shift = 0;
          load_data = 1;
          select = 2'b00;
          tx_busy = 1;
          next = DATA_BIT; 
        end
        DATA_BIT: begin 
          shift = 1;
          load_data = 0; 
          select = 2'b01;
          tx_busy = 1;
          if(!flag) 
            next = DATA_BIT;
          else
            next = PARITY_BIT;
        end
        PARITY_BIT: begin
          shift = 0;
          load_data = 1;
          select = 2'b10;
          tx_busy = 1;
          next = STOP_BIT;
        end
        STOP_BIT: begin 
          shift = 0;
          load_data = 0; 
          select = 2'b11;
          tx_busy = 0;
          if(tx_start) next = START_BIT; 
          else next = IDLE;
        end

default:begin next=IDLE; load_data=0; shift=0;select=2'b11;tx_busy=1'b0;end
      endcase
    end

endmodule
