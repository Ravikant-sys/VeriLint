module driver_mod_47 (
    input clk,
    input [15:0] port_a_47,
    input [15:0] port_b_47,
    output reg [15:0] bus_out_47
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_47 <= port_a_47;
    end

    always @(negedge clk) begin
        bus_out_47 <= port_b_47;
    end
endmodule
