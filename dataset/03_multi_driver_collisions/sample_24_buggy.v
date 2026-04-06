module driver_mod_24 (
    input clk,
    input [15:0] port_a_24,
    input [15:0] port_b_24,
    output reg [15:0] bus_out_24
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_24 <= port_a_24;
    end

    always @(negedge clk) begin
        bus_out_24 <= port_b_24;
    end
endmodule
