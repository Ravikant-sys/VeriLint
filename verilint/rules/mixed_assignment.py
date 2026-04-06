import re
from verilint.rules.engine import Rule

class MixedAssignmentRule(Rule):
    @property
    def rule_id(self):
         return "R001"

    @property
    def description(self):
         return "Checks for mixed blocking (=) and non-blocking (<=) assignments in sequential blocks."

    def check(self, block):
        violations = []
        if block.block_type != 'always':
             return violations
        
        # Determine if block is sequential by checking for edge triggers
        is_sequential = bool(re.search(r'@\s*\(\s*(posedge|negedge)', block.code))
        
        if is_sequential:
            has_blocking = bool(re.search(r'(?<!<)=[^=]', block.code)) 
            has_non_blocking = bool(re.search(r'<=', block.code))
            
            if has_blocking and has_non_blocking:
                 violations.append({
                     'severity': 'Error',
                     'message': 'Sequential block contains both blocking (=) and non-blocking (<=) assignments.'
                 })
            elif has_blocking and not has_non_blocking:
                 violations.append({
                     'severity': 'Warning',
                     'message': 'Sequential block uses blocking (=) assignments instead of non-blocking (<=).'
                 })
                 
        return violations
