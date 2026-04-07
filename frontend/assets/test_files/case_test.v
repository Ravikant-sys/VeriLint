module case_test (
    input [1:0] current_state,
    output reg [1:0] next_state
);
    parameter IDLE = 2'b00;
    parameter READ = 2'b01;
    parameter WRITE = 2'b10;

    // Rule: Case statements in combinational logic must be 'full'
    always @(*) begin
        case (current_state)
            2'b00: next_state = IDLE;
            2'b01: next_state = READ;
            2'b10: next_state = WRITE;
            // VIOLATION: 2'b11 is missing, and there is no 'default'.
        endcase
    end
endmodule
