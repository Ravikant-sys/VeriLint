import re
from verilint.rules.engine import Rule

class SyntaxCheckerRule(Rule):
    @property
    def rule_id(self):
         return "R005"

    @property
    def description(self):
         return "Global syntax sanity check (missing semicolons, missing commas)."

    def check(self, block):
        violations = []
        if block.block_type != 'global':
             return violations
             
        lines = block.code.split('\n')
        in_instantiation = False
        
        for i, line in enumerate(lines):
            line_no = i + 1
            clean_line = line.split('//')[0].strip()
            if not clean_line:
                continue
                
            # Error 1: Missing Semicolon on wire/reg decls
            # Matches wire or reg declarations that don't end in a semicolon
            decl_match = re.match(r'^(wire|reg)\b', clean_line)
            if decl_match and not clean_line.endswith(';'):
                violations.append({
                    'severity': 'Error',
                    'message': f"Syntax Error: Missing semicolon ';' at the end of '{decl_match.group(1)}' declaration."
                })

            # Error 6: Missing Comma in Instantiation
            # If line is a port mapping .port(sig) without comma, and next line isn't the closing parens.
            port_match = re.match(r'^\.\w+\s*\([^)]+\)$', clean_line)
            if port_match:
                # peek next line
                next_line = ""
                for j in range(i+1, len(lines)):
                    if lines[j].strip() and not lines[j].strip().startswith('//'):
                        next_line = lines[j].strip()
                        break
                if next_line and not next_line.startswith(')'):
                    violations.append({
                        'severity': 'Error',
                        'message': "Syntax Error: Missing comma ',' after port mapping in module instantiation."
                    })
                    
        return violations
