`timescale 1ns / 1ps




module csa_multiplier(
     input [3:0] m, q,
    output [7:0] p,
    wire [3:0] c_out0, c_out1, c_out2, mq0, mq1, mq2, mq3, s0, s1, s2
    );
    
    
  //instantiating mq's. mq0 denotes m(3-0)q0, mq1 denotes m(3-0)q1, etc.
    mq_4bit andq0 (.m(m),
                   .q(q[0]),
                   .mq(mq0));
    mq_4bit andq1 (.m(m),
                   .q(q[1]),
                   .mq(mq1));
    mq_4bit andq2 (.m(m),
                   .q(q[2]),
                   .mq(mq2));
    mq_4bit andq3 (.m(m),
                   .q(q[3]),
                   .mq(mq3));  
                   
                   
  //first stage
    full_adder fad_stage1_0 (.x(mq1[0]),    
                             .y(mq0[1]), 
                             .c_in(0),         
                             .s(s0[0]), 
                             .c_out(c_out0[0]));
    full_adder fad_stage1_1 (.x(mq1[1]),    
                             .y(mq0[2]), 
                             .c_in(mq2[0]),    
                             .s(s0[1]), 
                             .c_out(c_out0[1]));
    full_adder fad_stage1_2 (.x(mq1[2]),    
                             .y(mq0[3]), 
                             .c_in(mq2[1]),    
                             .s(s0[2]), 
                             .c_out(c_out0[2]));
    full_adder fad_stage1_3 (.x(mq1[3]),    
                             .y(0),      
                             .c_in(mq2[2]),    
                             .s(s0[3]), 
                             .c_out(c_out0[3]));
                             
    
    //second stage
    full_adder fad_stage2_0 (.x(0),         
                             .y(s0[1]),  
                             .c_in(c_out0[0]), 
                             .s(s1[0]), 
                             .c_out(c_out1[0]));
    full_adder fad_stage2_1 (.x(mq3[0]),    
                             .y(s0[2]),  
                             .c_in(c_out0[1]), 
                             .s(s1[1]), 
                             .c_out(c_out1[1]));
    full_adder fad_stage2_2 (.x(mq3[1]),    
                             .y(s0[3]),  
                             .c_in(c_out0[2]), 
                             .s(s1[2]), 
                             .c_out(c_out1[2]));
    full_adder fad_stage2_3 (.x(mq3[2]),    
                             .y(mq2[3]), 
                             .c_in(c_out0[3]), 
                             .s(s1[3]), 
                             .c_out(c_out1[3]));
    
    
    //third stage
    full_adder fad_stage3_0 (.x(c_out1[0]), 
                             .y(s1[1]),  
                             .c_in(0),         
                             .s(s2[0]), 
                             .c_out(c_out2[0]));
    full_adder fad_stage3_1 (.x(c_out1[1]), 
                             .y(s1[2]),  
                             .c_in(c_out2[0]), 
                             .s(s2[1]), 
                             .c_out(c_out2[1]));
    full_adder fad_stage3_2 (.x(c_out1[2]), 
                             .y(s1[3]),  
                             .c_in(c_out2[1]), 
                             .s(s2[2]), 
                             .c_out(c_out2[2]));
    full_adder fad_stage3_3 (.x(c_out1[3]), 
                             .y(mq3[3]), 
                             .c_in(c_out2[2]), 
                             .s(s2[3]), 
                             .c_out(c_out2[3]));
    
    //set outputs
    assign p[0] = mq0[0];
    assign p[1] = s0[0];
    assign p[2] = s1[0];
    assign p[3] = s2[0];
    assign p[4] = s2[1];
    assign p[5] = s2[2];
    assign p[6] = s2[3];
    assign p[7] = c_out2[3];
endmodule
