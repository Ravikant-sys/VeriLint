module driver_mod_28 (
    input clk,
    input [31:0] port_a_28,
    input [31:0] port_b_28,
    output reg [31:0] bus_out_28
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_28 <= port_a_28;
    end

    always @(negedge clk) begin
        bus_out_28 <= port_b_28;
    end
endmodule
