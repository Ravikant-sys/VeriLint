import re
from verilint.rules.engine import Rule

class MultiDriverRule(Rule):
    @property
    def rule_id(self):
         return "R006"

    @property
    def description(self):
         return "Detects signals driven by multiple always blocks (Multi-Driver Error)."

    def check(self, block):
        # We don't use this directly since we override check_all
        return []

    def check_all(self, blocks):
        violations = []
        drivers = {} # target_name -> list of blocks
        
        for block in blocks:
            if block.block_type == 'always':
                # Grab all LHS assignments inside this always block
                target_matches = re.finditer(r'\b([a-zA-Z0-9_]+)\s*(?:<=|=)', block.code)
                targets_in_block = set(m.group(1) for m in target_matches)
                
                for target in targets_in_block:
                    # Ignore 'if' and 'else' being falsely matched
                    if target in ['if', 'else', 'begin', 'end']:
                        continue
                    if target not in drivers:
                        drivers[target] = []
                    drivers[target].append(block)

        # Cross block analysis     
        for target, blocks_driving in drivers.items():
            if len(blocks_driving) > 1:
                # It's an error. We add the violation to the LAST block driving it
                faulty_block = blocks_driving[-1]
                issue = {
                    'severity': 'Error',
                    'message': f"Critical Synthesis Error: Signal '{target}' is driven by multiple procedural blocks. A signal can only be driven by a single always block."
                }
                
                wrapped = issue.copy()
                wrapped['block_type'] = faulty_block.block_type
                wrapped['start_line'] = faulty_block.start_line
                wrapped['end_line'] = faulty_block.end_line
                wrapped['code_context'] = faulty_block.code
                violations.append(wrapped)
                
        return violations
