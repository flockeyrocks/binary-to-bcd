`timescale 1ns / 1ps



module mq_4bit(
    input [3:0] m,
    input q,
    output [3:0] mq

    );
    
    assign mq = {4{q}} & m;
    
endmodule
