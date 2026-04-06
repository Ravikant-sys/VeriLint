module latch_mod_24 (
    input [3:0] sel_24,
    input en,
    output reg dec_24
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_24 > 0) begin
            dec_24 = 1'b1;
        end else begin
            dec_24 = 1'b0;
        end
    end
endmodule
