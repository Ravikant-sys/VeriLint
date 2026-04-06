module driver_mod_7 (
    input clk,
    input [7:0] port_a_7,
    input [7:0] port_b_7,
    output reg [7:0] bus_out_7
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_7 <= port_a_7;
    end

    always @(negedge clk) begin
        bus_out_7 <= port_b_7;
    end
endmodule
