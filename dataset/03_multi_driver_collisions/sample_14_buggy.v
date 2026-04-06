module driver_mod_14 (
    input clk,
    input [7:0] port_a_14,
    input [7:0] port_b_14,
    output reg [7:0] bus_out_14
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_14 <= port_a_14;
    end

    always @(negedge clk) begin
        bus_out_14 <= port_b_14;
    end
endmodule
