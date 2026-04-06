module driver_mod_45 (
    input clk,
    input [15:0] port_a_45,
    input [15:0] port_b_45,
    output reg [15:0] bus_out_45
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_45 <= port_a_45;
    end

    always @(negedge clk) begin
        bus_out_45 <= port_b_45;
    end
endmodule
