module driver_mod_33 (
    input clk,
    input [31:0] port_a_33,
    input [31:0] port_b_33,
    output reg [31:0] bus_out_33
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        bus_out_33 <= port_a_33;
    end

    always @(negedge clk) begin
        bus_out_33 <= port_b_33;
    end
endmodule
