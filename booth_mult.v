`timescale 1ns / 1ps
module bm(
    input signed [4:0] a, 
    input signed [4:0] b, 
    output reg signed [9:0] total
);

    reg qbit;
    integer i;

    always @* begin
        total = {5'b0, b}; 
        qbit = 0;
        
        for (i = 0; i < 5; i = i + 1) begin
            casez({total[0], qbit}) 
                2'b00, 2'b11: begin
                    qbit = total[0];
                    total = total >>> 1; 
                end
                2'b01: begin
                    total[9:5] = total[9:5] + a; 
                    qbit = total[0];
                    total = total >>> 1;  // Arithmetic shift right
                end
                2'b10: begin
                    total[9:5] = total[9:5] - a;  
                    qbit = total[0];
                    total = total >>> 1;
                end
            endcase
        end
    end
endmodule
