module driver_mod_38 (
    input clk,
    input [7:0] port_a_38,
    input [7:0] port_b_38,
    output reg [7:0] bus_out_38
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_38 <= port_a_38;
    end

    always @(negedge clk) begin
        bus_out_38 <= port_b_38;
    end
endmodule
