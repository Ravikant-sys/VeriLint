module latch_mod_25 (
    input [3:0] sel_25,
    input en,
    output reg dec_25
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_25 > 0) begin
            dec_25 = 1'b1;
        end else begin
            dec_25 = 1'b0;
        end
    end
endmodule
