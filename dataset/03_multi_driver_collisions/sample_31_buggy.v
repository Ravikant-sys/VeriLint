module driver_mod_31 (
    input clk,
    input [7:0] port_a_31,
    input [7:0] port_b_31,
    output reg [7:0] bus_out_31
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_31 <= port_a_31;
    end

    always @(negedge clk) begin
        bus_out_31 <= port_b_31;
    end
endmodule
