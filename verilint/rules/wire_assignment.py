import re
from verilint.rules.engine import Rule

class WireAssignmentRule(Rule):
    @property
    def rule_id(self):
         return "R007"

    @property
    def description(self):
         return "Check for procedural assignments to wire types."

    def check(self, block):
         return []

    def check_all(self, blocks):
        violations = []
        wires = set()
        
        # 1. Grab all wires globally
        for block in blocks:
            if block.block_type == 'global':
                wire_matches = re.finditer(r'\b(?:wire|input)\s+(?:\[[^\]]*\]\s*)?([a-zA-Z0-9_]+)', block.code)
                for m in wire_matches:
                    wires.add(m.group(1))

        # 2. Check always blocks
        for block in blocks:
            if block.block_type == 'always':
                target_matches = re.finditer(r'\b([a-zA-Z0-9_]+)\s*(?:<=|=)', block.code)
                for m in target_matches:
                    target = m.group(1)
                    if target in wires:
                        issue = {
                            'severity': 'Error',
                            'message': f"Logic Error: Cannot assign procedural value to a 'wire' variable '{target}' inside an always block. Use 'reg' or 'logic'."
                        }
                        wrapped = issue.copy()
                        wrapped['block_type'] = block.block_type
                        wrapped['start_line'] = block.start_line
                        wrapped['end_line'] = block.end_line
                        wrapped['code_context'] = block.code
                        violations.append(wrapped)
                        
        return violations
