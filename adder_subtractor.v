`timescale 1ns / 1ps

module adder_subtractor
    #(parameter n = 4) (
    input [n - 1:0] x, y,
    input add_n,
    output [n - 1:0] s,
    output c_out,
    output overflow
    );
    
    // declare different signals for XOR gate results
    wire [n - 1: 0] xored_y;
    
    // generate several XOR gates. if add_n=1, two's complement y
    generate
        genvar k;
        
        for (k = 0; k < n; k = k + 1)
        begin: bit
            assign xored_y[k] = y[k] ^ add_n;
        end
    endgenerate
    
    // instantiate an n-bit adder using XOR gate results as y input
    rca_nbit #(.n(n)) adder0 (
        .x(x),
        .y(xored_y),
        .c_in(add_n),
        .s(s),
        .c_out(c_out)
    );
    
    // generate an overflow flag by looking at the signs
    // of x, xored_y, s
    // we look at the xored_y because we only care about the adder portion of the circuit
    assign overflow = (x[n - 1] & xored_y[n - 1] & ~s[n - 1]) |
                      (~x[n - 1] & ~xored_y[n - 1] & s[n - 1]);
    
endmodule
