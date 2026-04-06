module driver_mod_2 (
    input clk,
    input [31:0] port_a_2,
    input [31:0] port_b_2,
    output reg [31:0] bus_out_2
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_2 <= port_a_2;
    end

    always @(negedge clk) begin
        bus_out_2 <= port_b_2;
    end
endmodule
