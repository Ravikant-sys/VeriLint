import re

class MockGeminiAI:
    def analyze_violation(self, rule_id: str, context_code: str, issue_msg: str, start_line: int, end_line: int) -> dict:
        """
        Mock AI reasoning based on predefined rule knowledge.
        In the real Phase 3, this would be an API call to Gemini.
        """
        response = {
            "reasoning": "Standard rule violation detected. Modifying this logic to adhere to Verilog best practices is recommended to avoid synthesis-simulation mismatches.",
            "corrected_code": context_code # fallback to original
        }

        # Hardcode some simple refactoring for our demo
        if rule_id == "R001":
            response["reasoning"] = "Mixing blocking and non-blocking assignments in an edge-triggered always block can lead to race conditions. State registers should typically use non-blocking (`<=`) assignments."
            
            # Simple regex replace for our specific mock
            # Converts lines like "q = 8'd0;" to "q <= 8'd0;" 
            # Note: A real LLM would intelligently rewrite AST nodes
            refactored = []
            for line in context_code.split('\n'):
                # Very rudimentary regex to swap `=` with `<=` inside always blocks as a demo
                if not '<=' in line and '=' in line and 'if' not in line and 'else' not in line:
                    line = re.sub(r'([^<>=!])=([^=])', r'\1<=\2', line)
                refactored.append(line)
            response["corrected_code"] = '\n'.join(refactored)

        elif rule_id == "R003":
             response["reasoning"] = f"A rule check determined that active low reset signals should be explicitly suffixed with _n or _b. This improves team code readability."
             
        elif rule_id == "R004":
             response["reasoning"] = "Inferred latches are usually accidental and happen when a combinational always block has incomplete 'if' branches. Provide a default assignment or a matching 'else' to fix."
             
             # Example simplistic mock refactor: add an else clause assigning to 0 (default) or self.
             lines = context_code.split('\n')
             refactored = []
             for line in lines:
                 refactored.append(line)
                 if line.strip() == "end" and "if" in context_code.split('end')[0]:
                     # A very crude AST placeholder
                     refactored.insert(-1, "    else\n        /* TODO: Add default assignment here to avoid latch */;")
             response["corrected_code"] = '\n'.join(refactored)

        return response
