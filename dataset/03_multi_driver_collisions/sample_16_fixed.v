module driver_mod_16 (
    input clk,
    input [31:0] port_a_16,
    input [31:0] port_b_16,
    output reg [31:0] bus_out_16
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_16 <= port_a_16;
        else 
            bus_out_16 <= port_b_16;
    end
endmodule
