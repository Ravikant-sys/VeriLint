import re
from verilint.rules.engine import Rule

class InferredLatchRule(Rule):
    @property
    def rule_id(self):
         return "R004"

    @property
    def description(self):
         return "Detects inferred latches in combinational logic (missing 'else' in 'if' or missing 'default' in 'case')."

    def check(self, block):
        violations = []
        if block.block_type != 'always':
             return violations
        
        # Check if block is combinational 
        # (Contains no posedge or negedge)
        is_combinational = not bool(re.search(r'(posedge|negedge)', block.code))
        
        if is_combinational:
            # Simple heuristic using regex: count 'if' and 'else'
            # A more robust parser would use an AST, but regex handles basic cases.
            if_count = len(re.findall(r'\bif\s*\(', block.code))
            else_count = len(re.findall(r'\belse\b', block.code))
            
            # If there are more 'if' branches than 'else' branches in a combinational block
            # it might hold state unnecessarily, leading to an inferred latch
            if if_count > else_count:
                 violations.append({
                     'severity': 'Error',
                     'message': "Inferred latch detected: Combinational logic has incomplete conditional branches (missing 'else'). This causes unintended memory."
                 })
                 
            # Check for non-full case statements that cause latches!
            case_blocks = re.findall(r'\bcase\b.*?\bendcase\b', block.code, flags=re.DOTALL)
            for cb in case_blocks:
                 # Check if the case block explicitly defines a default state
                 # First strip out any inline comments using a quick filter
                 clean_cb = '\n'.join([line.split('//')[0] for line in cb.split('\n')])
                 
                 # Basic tokenizer check using \b boundary to prevent substring matches
                 if not re.search(r'\bdefault\b', clean_cb):
                     violations.append({
                         'severity': 'Error',
                         'message': "Inferred latch detected: 'case' statement in combinational logic is not 'full' (missing 'default' keyword). This causes unintended memory."
                     })
                 
        return violations
