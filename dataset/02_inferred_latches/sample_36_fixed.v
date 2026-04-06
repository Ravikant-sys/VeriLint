module latch_mod_36 (
    input [1:0] sel_36,
    input en,
    output reg dec_36
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_36 > 0) begin
            dec_36 = 1'b1;
        end else begin
            dec_36 = 1'b0;
        end
    end
endmodule
