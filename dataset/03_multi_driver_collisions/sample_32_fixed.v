module driver_mod_32 (
    input clk,
    input [31:0] port_a_32,
    input [31:0] port_b_32,
    output reg [31:0] bus_out_32
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_32 <= port_a_32;
        else 
            bus_out_32 <= port_b_32;
    end
endmodule
