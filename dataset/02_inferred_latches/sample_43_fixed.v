module latch_mod_43 (
    input [1:0] sel_43,
    input en,
    output reg dec_43
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && sel_43 > 0) begin
            dec_43 = 1'b1;
        end else begin
            dec_43 = 1'b0;
        end
    end
endmodule
