module driver_mod_40 (
    input clk,
    input [7:0] port_a_40,
    input [7:0] port_b_40,
    output reg [7:0] bus_out_40
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_40 <= port_a_40;
    end

    always @(negedge clk) begin
        bus_out_40 <= port_b_40;
    end
endmodule
