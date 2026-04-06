import os
import random
import csv

# Categories and their directories
CATEGORIES = [
    "01_race_conditions",
    "02_inferred_latches",
    "03_multi_driver_collisions"
]

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATASET_DIR = os.path.join(BASE_DIR, "dataset")

def setup_directories():
    if not os.path.exists(DATASET_DIR):
        os.makedirs(DATASET_DIR)
    for cat in CATEGORIES:
        cat_dir = os.path.join(DATASET_DIR, cat)
        if not os.path.exists(cat_dir):
            os.makedirs(cat_dir)

def generate_race_condition(index):
    width = random.choice([4, 8, 16, 32, 64])
    v_in = f"sig_in_{index}"
    v_out = f"sig_out_{index}"
    clk_edge = random.choice(["posedge clk", "negedge clk"])
    
    buggy = f"""module race_mod_{index} (
    input clk,
    input [{width-1}:0] {v_in},
    output reg [{width-1}:0] {v_out}
);
    // BUG: Mixing blocking assignment in sequential logic
    always @({clk_edge}) begin
        {v_out} = {v_in} + 1'b1;
    end
endmodule
"""
    fixed = f"""module race_mod_{index} (
    input clk,
    input [{width-1}:0] {v_in},
    output reg [{width-1}:0] {v_out}
);
    // FIX: Use non-blocking assignment
    always @({clk_edge}) begin
        {v_out} <= {v_in} + 1'b1;
    end
endmodule
"""
    reason = f"Using blocking assignment '=' in a clocked {clk_edge} block causes simulation/synthesis race conditions. Used non-blocking '<=' instead."
    return buggy, fixed, reason

def generate_inferred_latch(index):
    width = random.choice([2, 3, 4, 5])
    cases = 2**width
    v_in = f"sel_{index}"
    v_out = f"dec_{index}"
    
    buggy = f"""module latch_mod_{index} (
    input [{width-1}:0] {v_in},
    input en,
    output reg {v_out}
);
    // BUG: Incomplete combinational logic
    always @(*) begin
        if (en && {v_in} > 0) begin
            {v_out} = 1'b1;
        end
        // Missing else branch creates a transparent latch!
    end
endmodule
"""
    fixed = f"""module latch_mod_{index} (
    input [{width-1}:0] {v_in},
    input en,
    output reg {v_out}
);
    // FIX: Complete combinational logic
    always @(*) begin
        if (en && {v_in} > 0) begin
            {v_out} = 1'b1;
        end else begin
            {v_out} = 1'b0;
        end
    end
endmodule
"""
    reason = "Combinational block has an incomplete if/else branch, inferring an unintended state latch. Added a default else branch."
    return buggy, fixed, reason

def generate_multi_driver(index):
    width = random.choice([8, 16, 32])
    v_in1 = f"port_a_{index}"
    v_in2 = f"port_b_{index}"
    v_out = f"bus_out_{index}"
    
    buggy = f"""module driver_mod_{index} (
    input clk,
    input [{width-1}:0] {v_in1},
    input [{width-1}:0] {v_in2},
    output reg [{width-1}:0] {v_out}
);
    // BUG: Multiple blocks driving the same output
    always @(posedge clk) begin
        {v_out} <= {v_in1};
    end

    always @(negedge clk) begin
        {v_out} <= {v_in2};
    end
endmodule
"""
    fixed = f"""module driver_mod_{index} (
    input clk,
    input [{width-1}:0] {v_in1},
    input [{width-1}:0] {v_in2},
    output reg [{width-1}:0] {v_out}
);
    // FIX: Merge logic into a single driving block
    always @(posedge clk or negedge clk) begin
        if (clk) 
            {v_out} <= {v_in1};
        else 
            {v_out} <= {v_in2};
    end
endmodule
"""
    reason = "Signal driven by multiple procedural always blocks causing a synthesis short-circuit. Merged the drivers into a single block."
    return buggy, fixed, reason


def main():
    print("Starting Verilint Benchmark Dataset Generator...")
    setup_directories()
    
    csv_data = []
    
    # Generate 50 samples per category
    SAMPLES_PER_CAT = 50
    
    generators = [
        ("01_race_conditions", generate_race_condition),
        ("02_inferred_latches", generate_inferred_latch),
        ("03_multi_driver_collisions", generate_multi_driver)
    ]
    
    for cat_idx, (cat_name, gen_func) in enumerate(generators):
        cat_dir = os.path.join(DATASET_DIR, cat_name)
        for i in range(SAMPLES_PER_CAT):
            buggy_code, fixed_code, reason = gen_func(i)
            
            # Save files
            buggy_path = os.path.join(cat_dir, f"sample_{i}_buggy.v")
            fixed_path = os.path.join(cat_dir, f"sample_{i}_fixed.v")
            
            with open(buggy_path, 'w') as f: f.write(buggy_code)
            with open(fixed_path, 'w') as f: f.write(fixed_code)
            
            # Append to CSV
            csv_data.append({
                'id': f"{cat_name}_{i}",
                'category': cat_name,
                'buggy_file': os.path.relpath(buggy_path, BASE_DIR),
                'fixed_file': os.path.relpath(fixed_path, BASE_DIR),
                'reasoning': reason,
                'buggy_snippet': buggy_code.replace('\\n', ''),
                'fixed_snippet': fixed_code.replace('\\n', '')
            })

    # Write CSV Mapping
    csv_path = os.path.join(DATASET_DIR, "dataset.csv")
    with open(csv_path, 'w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=['id', 'category', 'buggy_file', 'fixed_file', 'reasoning', 'buggy_snippet', 'fixed_snippet'])
        writer.writeheader()
        writer.writerows(csv_data)
        
    print(f"Success! Generated {SAMPLES_PER_CAT * len(generators)} testing pairs across {len(generators)} categories.")
    print(f"Dataset securely saved to {DATASET_DIR}")
    print(f"Master Mapping CSV path: {csv_path}")

if __name__ == "__main__":
    main()
