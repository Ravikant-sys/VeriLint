module driver_mod_36 (
    input clk,
    input [15:0] port_a_36,
    input [15:0] port_b_36,
    output reg [15:0] bus_out_36
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_36 <= port_a_36;
    end

    always @(negedge clk) begin
        bus_out_36 <= port_b_36;
    end
endmodule
