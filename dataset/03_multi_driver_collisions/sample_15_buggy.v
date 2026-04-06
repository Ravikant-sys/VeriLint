module driver_mod_15 (
    input clk,
    input [31:0] port_a_15,
    input [31:0] port_b_15,
    output reg [31:0] bus_out_15
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_15 <= port_a_15;
    end

    always @(negedge clk) begin
        bus_out_15 <= port_b_15;
    end
endmodule
