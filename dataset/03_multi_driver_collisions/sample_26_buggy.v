module driver_mod_26 (
    input clk,
    input [7:0] port_a_26,
    input [7:0] port_b_26,
    output reg [7:0] bus_out_26
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_26 <= port_a_26;
    end

    always @(negedge clk) begin
        bus_out_26 <= port_b_26;
    end
endmodule
