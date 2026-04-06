module driver_mod_41 (
    input clk,
    input [15:0] port_a_41,
    input [15:0] port_b_41,
    output reg [15:0] bus_out_41
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_41 <= port_a_41;
    end

    always @(negedge clk) begin
        bus_out_41 <= port_b_41;
    end
endmodule
