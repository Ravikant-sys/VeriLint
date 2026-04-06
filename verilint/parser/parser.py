import re
from dataclasses import dataclass

@dataclass
class ContextBlock:
    block_type: str  # 'module', 'always', 'initial'
    code: str
    start_line: int
    end_line: int

class RegexVerilogParser:
    def __init__(self):
        # We use regex to find start points of interesting blocks
        self.module_start_pattern = re.compile(r'\bmodule\s+\w+\b')
        self.always_start_pattern = re.compile(r'\balways\b')
        self.initial_start_pattern = re.compile(r'\binitial\b')

    def parse(self, verilog_code: str):
        blocks = []
        lines = verilog_code.split('\n')
        
        # Add a global block representing the entire file for syntax rules
        blocks.append(ContextBlock(
            block_type='global',
            code=verilog_code,
            start_line=1,
            end_line=len(lines)
        ))
        
        in_module = False
        module_lines = []
        module_start = 0

        # Note: True block extraction requires tracking 'begin'/'end' nesting.
        # This is a highly customized regex and state-machine hybrid logic.
        curr_block_type = None
        curr_block_lines = []
        curr_block_start = 0
        nesting_level = 0
        
        for i, line in enumerate(lines):
            line_no = i + 1
            clean_line = line.split('//')[0] # ignore comments
            
            # Module Detection (Usually ends with endmodule)
            if self.module_start_pattern.search(clean_line) and not curr_block_type:
                blocks.append(ContextBlock(
                    block_type='module_decl', 
                    code=line, 
                    start_line=line_no, 
                    end_line=line_no
                ))
            
            # Block detection (always/initial)
            if not curr_block_type:
                if self.always_start_pattern.search(clean_line):
                    curr_block_type = 'always'
                    curr_block_start = line_no
                elif self.initial_start_pattern.search(clean_line):
                    curr_block_type = 'initial'
                    curr_block_start = line_no
            
            if curr_block_type:
                curr_block_lines.append(line)
                
                # Keep track of nesting to know when block ends
                # Basic representation of balanced keywords
                words = re.findall(r'\b\w+\b', clean_line)
                if 'begin' in words or 'case' in words or 'generate' in words:
                    nesting_level += 1
                if 'end' in words or 'endcase' in words or 'endgenerate' in words:
                    nesting_level -= 1
                
                # If nesting returns to 0 and we have lines, it's the end of single statement or block
                # A single statement always block ends immediately if no `begin` is found (simplification)
                if nesting_level <= 0 and ('end' in words or curr_block_type in clean_line and 'begin' not in clean_line and ';' in clean_line):
                     nesting_level = 0
                     blocks.append(ContextBlock(
                         block_type=curr_block_type,
                         code='\n'.join(curr_block_lines),
                         start_line=curr_block_start,
                         end_line=line_no
                     ))
                     curr_block_type = None
                     curr_block_lines = []
                     
        return blocks
