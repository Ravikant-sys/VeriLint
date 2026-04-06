module driver_mod_17 (
    input clk,
    input [31:0] port_a_17,
    input [31:0] port_b_17,
    output reg [31:0] bus_out_17
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_17 <= port_a_17;
    end

    always @(negedge clk) begin
        bus_out_17 <= port_b_17;
    end
endmodule
