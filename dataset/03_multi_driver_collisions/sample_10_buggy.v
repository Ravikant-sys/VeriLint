module driver_mod_10 (
    input clk,
    input [7:0] port_a_10,
    input [7:0] port_b_10,
    output reg [7:0] bus_out_10
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_10 <= port_a_10;
    end

    always @(negedge clk) begin
        bus_out_10 <= port_b_10;
    end
endmodule
