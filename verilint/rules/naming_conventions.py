import re
from verilint.rules.engine import Rule

class NamingConventionRule(Rule):
    @property
    def rule_id(self):
         return "R003"

    @property
    def description(self):
         return "Enforces naming conventions (e.g. active low resets should end with _n)."

    def check(self, block):
        violations = []
        if block.block_type in ['module_decl', 'always']:
            # Search for negedge reset that doesn't end with _n or _b
            negedge_matches = re.finditer(r'negedge\s+([A-Za-z0-9_]+)', block.code)
            for m in negedge_matches:
                sig_name = m.group(1)
                if not sig_name.endswith('_n') and not sig_name.endswith('_b'):
                    violations.append({
                        'severity': 'Warning',
                        'message': f"Active low reset signal '{sig_name}' does not follow suffix convention (_n or _b)."
                    })
        return violations
