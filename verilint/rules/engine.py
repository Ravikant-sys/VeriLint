from abc import ABC, abstractmethod
from typing import List, Dict

class Rule(ABC):
    @property
    @abstractmethod
    def rule_id(self) -> str:
        pass

    @property
    @abstractmethod
    def description(self) -> str:
        pass

    @abstractmethod
    def check(self, block) -> List[Dict]:
        """Returns a list of violations. dict with keys: 'line', 'message', 'severity'"""
        pass

    def check_all(self, blocks) -> List[Dict]:
        """Runs the rule across all blocks simultaneously. Defaults to iterating check()."""
        violations = []
        for block in blocks:
             issues = self.check(block)
             for issue in issues:
                 # Wrap with block metadata for old rules
                 wrapped = issue.copy()
                 wrapped['block_type'] = getattr(block, 'block_type', 'global')
                 wrapped['start_line'] = getattr(block, 'start_line', 1)
                 wrapped['end_line'] = getattr(block, 'end_line', 1)
                 wrapped['code_context'] = getattr(block, 'code', '')
                 violations.append(wrapped)
        return violations

class RuleEngine:
    def __init__(self):
        self.rules = []

    def register_rule(self, rule: Rule):
        self.rules.append(rule)

    def analyze(self, blocks) -> List[Dict]:
        violations = []
        for rule in self.rules:
            issues = rule.check_all(blocks)
            for issue in issues:
                violations.append({
                    'rule_id': rule.rule_id,
                    'block_type': issue.get('block_type', 'unknown'),
                    'start_line': issue.get('start_line', -1),
                    'end_line': issue.get('end_line', -1),
                    'issue': issue,
                    'code_context': issue.get('code_context', '')
                })
        return violations
