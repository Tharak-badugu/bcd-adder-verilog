module full_adder(input a, b, cin, output sum, carry);
wire w1, w2, w3;
and a1(w1, a, b);
and a2(w2, b, cin);
and a3(w3, a, cin);
or o1(carry, w1, w2, w3);
xor ox1 (sum, a, b, cin);
endmodule

module ripple_adder(input [3:0]a,input [3:0]b,input cin,output [3:0]sum,output cout);

wire w1,w2,w3;
full_adder fa0(a[0],b[0],cin,sum[0],w1);
full_adder fa1(a[1],b[1],w1,sum[1],w2);
full_adder fa2(a[2],b[2],w2,sum[2],w3);
full_adder fa3(a[3],b[3],w3,sum[3],cout);
endmodule

module bcd_adder(input[3:0]a, input[3:0]b,input cin,output[3:0]sum,output cout);
wire [3:0]rca1_sum;
wire rca1_cout;
wire w1,w2;
wire [3:0]rca2_b;
wire uncout;

ripple_adder rca1(a,b,cin,rca1_sum,rca1_cout);

and a1(w1,rca1_sum[3],rca1_sum[2]);
and a2(w2,rca1_sum[3],rca1_sum[1]);
or o1(cout,w1,w2,rca1_cout);


ripple_adder rca2(rca1_sum,rca2_b,1'b0,sum,uncout);
assign rca2_b[0]=1'b0;
assign rca2_b[1]=cout;
assign rca2_b[2]=cout;
assign rca2_b[3]=1'b0;
endmodule




