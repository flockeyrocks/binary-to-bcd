`timescale 1ns / 1ps

module mux_2x1_8bit(
    input [3:0] x, 
    input [7:0] y,
    input s,
    output reg [7:0] f
    );
    
 always@(*)
    begin
        case(s)
            0:f={{4{0}},x};
            1:f=y;
        endcase
    end
    
endmodule
