module top_secret_chip (
    input clk,
    input rst,
    input [3:0] data_in,
    input en,
    output reg [3:0] out_data,
    output reg alert
);

    // Error 1: Incorrect wire declaration (Syntax)
    wire [3:0] internal_bus
    
    // Error 2: Mixed Blocking and Non-Blocking (Logical/Race Condition)
    // Rule: Never use '=' in a clocked block for sequential logic.
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out_data = 4'b0000; // Violation: Blocking reset
        end else if (en) begin
            internal_bus = data_in; // Violation: Assigning to a 'wire' inside 'always'
            out_data <= internal_bus + 1; 
        end
    end

    // Error 3: The Inferred Latch (Architecture Violation)
    // Rule: Combinational blocks must cover all cases.
    always @(*) begin
        if (data_in > 4'd10) begin
            alert = 1'b1;
        end
        // Violation: Missing 'else'. If data_in <= 10, 'alert' latches its state.
    end

    // Error 4: Multi-Driver Bug (Critical Synthesis Error)
    // Rule: A signal cannot be driven by two different blocks.
    always @(posedge clk) begin
        alert <= 1'b0; // Violation: 'alert' is already driven in the block above!
    end

    // Error 5: Sensitivity List Mismatch (Legacy/Simulation Error)
    // Rule: List all inputs or use @(*)
    reg [3:0] temp_val;
    always @(data_in) begin 
        temp_val = data_in ^ 4'b1111;
        // Violation: If another signal affected this logic, it's missing from the list.
    end

    // Error 6: Module instantiation syntax error
    sub_module u1 (
        .in(data_in)
        .out(internal_bus) // Violation: Missing comma
    )

endmodule