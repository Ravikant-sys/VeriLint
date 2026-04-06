module driver_mod_39 (
    input clk,
    input [7:0] port_a_39,
    input [7:0] port_b_39,
    output reg [7:0] bus_out_39
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_39 <= port_a_39;
    end

    always @(negedge clk) begin
        bus_out_39 <= port_b_39;
    end
endmodule
