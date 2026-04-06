module latch_mod_21 (
    input [3:0] sel_21,
    input en,
    output reg dec_21
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_21 > 0) begin
            dec_21 = 1'b1;
        end else begin
            dec_21 = 1'b0;
        end
    end
endmodule
