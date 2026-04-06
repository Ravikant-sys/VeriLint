module driver_mod_18 (
    input clk,
    input [31:0] port_a_18,
    input [31:0] port_b_18,
    output reg [31:0] bus_out_18
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_18 <= port_a_18;
        else 
            bus_out_18 <= port_b_18;
    end
endmodule
