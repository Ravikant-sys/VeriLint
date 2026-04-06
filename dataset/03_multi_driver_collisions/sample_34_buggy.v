module driver_mod_34 (
    input clk,
    input [15:0] port_a_34,
    input [15:0] port_b_34,
    output reg [15:0] bus_out_34
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_34 <= port_a_34;
    end

    always @(negedge clk) begin
        bus_out_34 <= port_b_34;
    end
endmodule
