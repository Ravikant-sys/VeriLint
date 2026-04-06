import re
from verilint.rules.engine import Rule

class UnusedPortRule(Rule):
    @property
    def rule_id(self):
         return "R009"

    @property
    def description(self):
         return "Detects input or output ports that are declared but never used in the module logic."

    def check_all(self, blocks):
        violations = []
        global_block = None
        module_block = None
        
        for b in blocks:
            if b.block_type == 'global':
                global_block = b
            if b.block_type == 'module_decl':
                module_block = b
                
        if not global_block:
            return violations
            
        # Strip comments from global code globally to avoid matching ports inside comments
        clean_code = '\n'.join([line.split('//')[0] for line in global_block.code.split('\n')])
        clean_code = re.sub(r'/\*.*?\*/', '', clean_code, flags=re.DOTALL)
        
        # Extract the full module declaration block
        module_decl_match = re.search(r'\bmodule\b.*?\);', clean_code, flags=re.DOTALL)
        if not module_decl_match:
             return violations
        module_code = module_decl_match.group(0)
        
        # Extract explicitly declared ports
        ports = re.findall(r'\b(?:input|output|inout)\s*(?:reg|wire|logic)?\s*(?:\[.*?\])?\s*([a-zA-Z0-9_]+)', module_code)
        
        for port in ports:
            # Count occurrences of the port globally
            # The port is declared once in the module interface, so if count == 1, it is entirely unused!
            matches = re.findall(r'\b' + re.escape(port) + r'\b', clean_code)
            if len(matches) == 1:
                violations.append({
                    'severity': 'Warning',
                    'message': f"Unused Port: The interface port '{port}' is declared but never utilized anywhere in the module's internal logic.",
                    'start_line': -1,
                    'end_line': -1
                })
                
        return violations

    def check(self, block):
        return []
