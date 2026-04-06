module driver_mod_25 (
    input clk,
    input [7:0] port_a_25,
    input [7:0] port_b_25,
    output reg [7:0] bus_out_25
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_25 <= port_a_25;
    end

    always @(negedge clk) begin
        bus_out_25 <= port_b_25;
    end
endmodule
