import re
from verilint.rules.engine import Rule

class SensitivityListRule(Rule):
    @property
    def rule_id(self):
         return "R008"

    @property
    def description(self):
         return "Detects missing signals in the sensitivity list of a combinational block."

    def check(self, block):
        violations = []
        if block.block_type != 'always':
             return violations
        
        # Only check explicit combinational blocks: always @(a, b)
        # Skip if it's always @(*) or has edge triggers
        if '*' in block.code.split(')')[0] or 'posedge' in block.code or 'negedge' in block.code:
             return violations

        # Extract list inside @(...)
        sens_match = re.search(r'@\(([A-Za-z0-9_\s,]+)\)', block.code)
        if not sens_match:
             return violations
             
        sens_list = [v.strip() for v in sens_match.group(1).split(',')]
        
        # Extremely crude RHS extractor - find words after operators or =
        # Real version needs AST
        rhs_words = set(re.findall(r'=\s*([^;]+);', block.code))
        vars_used = set()
        for w in rhs_words:
             vars_used.update(re.findall(r'\b[a-zA-Z_]\w*\b', w))
             
        for var in vars_used:
             # filter common keywords
             if var not in sens_list and var not in ['if', 'else', 'begin', 'end', 'b', 'd']:
                 violations.append({
                     'severity': 'Warning',
                     'message': f"Sensitivity Mismatch: Variable '{var}' is read inside the block but missing from the sensitivity list. Consider using always @(*)."
                 })
                 
        return violations
