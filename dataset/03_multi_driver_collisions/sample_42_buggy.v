module driver_mod_42 (
    input clk,
    input [7:0] port_a_42,
    input [7:0] port_b_42,
    output reg [7:0] bus_out_42
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_42 <= port_a_42;
    end

    always @(negedge clk) begin
        bus_out_42 <= port_b_42;
    end
endmodule
