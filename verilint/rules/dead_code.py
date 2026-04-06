import re
from verilint.rules.engine import Rule

class DeadCodeRule(Rule):
    @property
    def rule_id(self):
         return "R010"

    @property
    def description(self):
         return "Detects entirely unused parameters (dead code) and unreachable FSM state branches."

    def check_all(self, blocks):
        violations = []
        global_block = next((b for b in blocks if b.block_type == 'global'), None)
        
        if not global_block:
            return violations
            
        clean_code = '\n'.join([line.split('//')[0] for line in global_block.code.split('\n')])
        clean_code = re.sub(r'/\*.*?\*/', '', clean_code, flags=re.DOTALL)
        
        # Extract parameters
        param_lines = re.findall(r'\b(?:parameter|localparam)\s+(.*?);', clean_code)
        params = []
        for p_line in param_lines:
            p_names = re.findall(r'\b([A-Za-z0-9_]+)\s*=', p_line)
            params.extend(p_names)
            
        for param in params:
            # Check 1: Entirely unused?
            matches = re.findall(r'\b' + re.escape(param) + r'\b', clean_code)
            if len(matches) == 1:
                # Occurs only exactly once where it is defined
                violations.append({
                    'severity': 'Warning',
                    'message': f"Dead Code: Parameter State '{param}' is defined but no logic ever evaluates or transitions to it.",
                    'start_line': -1,
                    'end_line': -1
                })
                continue
                
            # Check 2: Unreachable State? (used as a case label, but never structurally transitioned to)
            is_case_label = re.search(r'\b' + re.escape(param) + r'\s*:', clean_code)
            if is_case_label:
                # Must be on the RHS of an assignment `=> PARAM` or `= PARAM` to be reachable
                is_rhs = re.search(r'(?:<=|=)[^;]*?\b' + re.escape(param) + r'\b', clean_code)
                if not is_rhs:
                     violations.append({
                         'severity': 'Error',
                         'message': f"Unreachable State: '{param}' is defined as a case branch but no logic ever transitions to it. This is Dead Code causing synthesis bloat.",
                         'start_line': -1,
                         'end_line': -1
                     })
                     
        return violations

    def check(self, block):
        return []
