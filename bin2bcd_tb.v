`timescale 1ns / 1ps
module bin2bcd_tb();

    reg [7:0] bin;
    wire [11:0] bcd;
    
    bin2bcd DUT (
    .bin(bin),
    .bcd(bcd)
    );
    
    initial begin
        bin = 'b00000000;
        #20
        bin = 'b00000001;
        #20
        bin = 'b00000010;
        #20
        bin = 'b00000100;
        #20
        bin = 'b00001000;
        #20
        bin = 'b00010000;
        #20
        bin = 'b00100000;
        #20
        bin = 'b01000000;
        #20
        bin = 'b10000000;
        #20
        $finish;
    end

endmodule
