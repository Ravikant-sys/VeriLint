module driver_mod_37 (
    input clk,
    input [15:0] port_a_37,
    input [15:0] port_b_37,
    output reg [15:0] bus_out_37
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_37 <= port_a_37;
    end

    always @(negedge clk) begin
        bus_out_37 <= port_b_37;
    end
endmodule
