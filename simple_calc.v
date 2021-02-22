`timescale 1ns / 1ps

module simple_calc(
    input [3:0] x, y,
    input [1:0] op_sel,
    output [11:0] result,
    output reg neg_led,
    output carry_out, overflow
    );
    
    wire add_n;
    wire [7:0] add_sub_out;
    wire [7:0] mult_out;
    wire [7:0] bin;
    reg [7:0] bin_flip;
    
    //if S0 = 1, add_n = 0 for addition, if S0 = 1, add_n = 1 for subtraction
    //assign add_n = ~op_sel[0] & 0 | op_sel[0] & 1;
    
    adder_subtractor add_sub(
                             .x(x), 
                             .y(y), 
                             .add_n(op_sel[0]), 
                             .s(add_sub_out), 
                             .c_out(carry_out), 
                             .overflow(overflow));
    
    csa_multiplier add_mult(
                            .m(x), 
                            .q(y), 
                            .p(mult_out));
    
    mux_2x1_8bit(
                 .x(add_sub_out), 
                 .y(mult_out), 
                 .s(op_sel[1]), 
                 .f(bin));
                 
                 
 //check for negative number by checking y>x and subtraction.
   //if true, 2's complement              
   always@(*)
        begin
        if( y > x & op_sel[0])
            begin
            bin_flip = (bin ^ 'b1111) + 1;
            neg_led = 1;
            end
        else if(carry_out & ~op_sel[0] & ~op_sel[1])
            begin
            bin_flip = bin + 16;
            end
        else
            begin
            bin_flip = bin;
            neg_led = 0;
            end
        end
                 
   bin2bcd bcd1 (.bin(bin_flip), 
                 .bcd(result));
    
endmodule