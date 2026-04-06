module latch_mod_35 (
    input [3:0] sel_35,
    input en,
    output reg dec_35
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_35 > 0) begin
            dec_35 = 1'b1;
        end else begin
            dec_35 = 1'b0;
        end
    end
endmodule
