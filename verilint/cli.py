import argparse
import sys
import os

# Add parent directory to path so verilint module can be found when run simply
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from verilint.core import VerilintCore

def main():
    parser = argparse.ArgumentParser(description="Verilint AI-Powered Core Engine")
    parser.add_argument("file", help="Path to Verilog (.v) file to analyze")
    
    args = parser.parse_args()
    
    if not os.path.exists(args.file):
         print(f"Error: File '{args.file}' not found.")
         sys.exit(1)
         
    with open(args.file, 'r') as f:
         code = f.read()

    print(f"Verilint: Analyzing {args.file}...\n")
    engine = VerilintCore()
    engine.run(code)

if __name__ == "__main__":
    main()
