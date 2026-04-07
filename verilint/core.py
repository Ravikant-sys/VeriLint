import os
from pprint import pprint
from verilint.parser.parser import RegexVerilogParser
from verilint.rules.engine import RuleEngine
from verilint.rules.mixed_assignment import MixedAssignmentRule
from verilint.rules.naming_conventions import NamingConventionRule
from verilint.rules.inferred_latch import InferredLatchRule
from verilint.rules.syntax_checker import SyntaxCheckerRule
from verilint.rules.multi_driver import MultiDriverRule
from verilint.rules.wire_assignment import WireAssignmentRule
from verilint.rules.sensitivity_list import SensitivityListRule
from verilint.rules.unused_ports import UnusedPortRule
from verilint.rules.dead_code import DeadCodeRule
from verilint.ai.mock_gemini import MockGeminiAI
from verilint.ai.gemini_client import RealGeminiAI

class VerilintCore:
    def __init__(self):
        # Phase 1
        self.parser = RegexVerilogParser()
        
        # Phase 2
        self.engine = RuleEngine()
        self.engine.register_rule(MixedAssignmentRule())
        self.engine.register_rule(NamingConventionRule())
        self.engine.register_rule(InferredLatchRule())
        self.engine.register_rule(SyntaxCheckerRule())
        self.engine.register_rule(MultiDriverRule())
        self.engine.register_rule(WireAssignmentRule())
        self.engine.register_rule(SensitivityListRule())
        self.engine.register_rule(UnusedPortRule())
        self.engine.register_rule(DeadCodeRule())

        # Phase 3
        # Use provided key or environment variable
        self.ai_key = os.environ.get("GEMINI_API_KEY", "AIzaSyCyCP8qN0ULhmC7pDHO1j8VURAQj5BjrWU")
        
        if self.ai_key:
             print("Initializing real Gemini AI Client...")
             self.ai = RealGeminiAI(self.ai_key)
        else:
             print("No API Key found. Falling back to Mock Gemini AI...")
             self.ai = MockGeminiAI()

    def run(self, verilog_code: str):
        # PHASE 1: Parsing
        print("--- PHASE 1: Parsing Context Blocks ---")
        blocks = self.parser.parse(verilog_code)
        for b in blocks:
             print(f"Extracted [{b.block_type}] (Lines {b.start_line}-{b.end_line})")

        print("\n--- PHASE 2: Rule Engine ---")
        # PHASE 2: Rule Analysis
        violations = self.engine.analyze(blocks)
        if not violations:
             print("Passed! No violations detected.")
             return

        for violation in violations:
             issue = violation['issue']
             print(f"[Violation {violation['rule_id']}] {issue['severity']} at lines {violation['start_line']}-{violation['end_line']}: {issue['message']}")
             
             # PHASE 3: AI Refactoring
             print("\n   --- PHASE 3: AI Reasoning & Refactoring ---")
             # Pass the FULL verilog code so AI has cross-block awareness
             ai_resp = self.ai.analyze_violation(violation['rule_id'], verilog_code, issue['message'])
             print(f"   Reasoning: {ai_resp['reasoning']}")
             print("   Refactored Code Snippet:\n   " + ai_resp['corrected_code'].replace('\n', '\n   '))
             print("-" * 50)

    def run_json(self, verilog_code: str) -> dict:
        blocks = self.parser.parse(verilog_code)
        violations = self.engine.analyze(blocks)
        
        results = {
            'passed': len(violations) == 0,
            'violations': []
        }

        for violation in violations:
             issue = violation['issue']
             # AI Reasoning
             try:
                 ai_resp = self.ai.analyze_violation(violation['rule_id'], verilog_code, issue['message'])
             except Exception as e:
                 print(f"AI Failure: {e}")
                 ai_resp = {
                     'reasoning': "AI analysis unavailable due to network or quota error. Please check your API key.",
                     'corrected_code': "// AI Suggestion unavailable"
                 }
             
             results['violations'].append({
                 'rule_id': violation['rule_id'],
                 'severity': issue['severity'],
                 'message': issue['message'],
                 'start_line': violation.get('start_line', 1),
                 'end_line': violation.get('end_line', 1),
                 'ai_reasoning': ai_resp['reasoning'],
                 'corrected_code': ai_resp['corrected_code']
             })
             
        return results
