module driver_mod_2 (
    input clk,
    input [31:0] port_a_2,
    input [31:0] port_b_2,
    output reg [31:0] bus_out_2
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            bus_out_2 <= port_a_2;
        else 
            bus_out_2 <= port_b_2;
    end
endmodule
