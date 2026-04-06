module driver_mod_49 (
    input clk,
    input [15:0] port_a_49,
    input [15:0] port_b_49,
    output reg [15:0] bus_out_49
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_49 <= port_a_49;
    end

    always @(negedge clk) begin
        bus_out_49 <= port_b_49;
    end
endmodule
