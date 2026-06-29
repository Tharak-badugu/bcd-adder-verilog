`timescale 1ns/1ps
`include "newer.v"
module newer_tb;
reg [3:0]a,b;
reg cin;
wire [3:0]sum;
wire cout;

bcd_adder dut(a,b,cin,sum,cout);
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,newer_tb);
end

initial begin
    $monitor("Time=%0t ns | A=%d B=%d Cin=%b -> BCD_Sum=%d Cout=%b", $time, a, b, cin, sum, cout);
        //initailizing to 0
        {a,b,cin}=0;

        // Case 1: Normal Addition (Sum <= 9) No correction needed.
        a= 4'd4; b = 4'd3; cin = 1'b0; #10;

        // Case 2: max Boundary without Correction (Exactly 9)
        a = 4'd5; b = 4'd4; cin = 1'b0; #10; 

        // Case 3: Correction Triggered (Sum > 9). Adds 6 internally.
        a = 4'd8; b = 4'd5; cin = 1'b0; #10;

        // Case 4: Exact Boundary Correction (Exactly 10)
        a = 4'd6; b = 4'd4; cin = 1'b0; #10; 

        // Case 5: Addition with an input carry (Cin) active
        a = 4'd7; b = 4'd2; cin  = 1'b1; #10;
        
        // Case 6: Binary Overflow Trap Case (8 + 8 = 16)
        a = 4'd8; b = 4'd8; cin = 1'b0; #10; 

        // Case 7: Maximum Capacity Stress Test (9 + 9 + 1)
        a = 4'd9; b = 4'd9; cin = 1'b1; #10; 
        $display("program completed");
        $finish;
end
endmodule


