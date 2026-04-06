module driver_mod_29 (
    input clk,
    input [31:0] port_a_29,
    input [31:0] port_b_29,
    output reg [31:0] bus_out_29
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_29 <= port_a_29;
    end

    always @(negedge clk) begin
        bus_out_29 <= port_b_29;
    end
endmodule
