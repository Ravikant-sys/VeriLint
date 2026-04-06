module driver_mod_22 (
    input clk,
    input [31:0] port_a_22,
    input [31:0] port_b_22,
    output reg [31:0] bus_out_22
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_22 <= port_a_22;
    end

    always @(negedge clk) begin
        bus_out_22 <= port_b_22;
    end
endmodule
