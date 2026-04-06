module driver_mod_38 (
    input clk,
    input [7:0] port_a_38,
    input [7:0] port_b_38,
    output reg [7:0] bus_out_38
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_38 <= port_a_38;
        else 
            bus_out_38 <= port_b_38;
    end
endmodule
