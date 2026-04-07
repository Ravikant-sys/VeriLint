import json
import urllib.request
import urllib.error

class RealGeminiAI:
    def __init__(self, api_key: str):
        self.api_key = api_key
        # Using the standard gemini-flash-latest model endpoint
        self.url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key={self.api_key}"

    def analyze_violation(self, rule_id: str, context_code: str, issue_msg: str) -> dict:
        prompt = f"""
You are an expert Verilog reasoning engine part of the 'Verilint' linter.
A rule violation was detected.

Rule ID: {rule_id}
Issue Message: {issue_msg}

Original Full Verilog Code Context:
```verilog
{context_code}
```

Respond with ONLY valid JSON containing EXACTLY two keys:
- "reasoning": A detailed explanation of why this bug is biologically bad for synthesis/simulation, and explicitly outline the **PROBABLE FIX** (e.g. "Move the wire assignment to a separate assign block", "Add the missing elsewhere branch", "Combine the two always blocks").
- "corrected_code": ONLY the specific refactored lines or the exact block that caused the violation. Do not output the entire file. Do NOT wrap it in markdown block quotes, just raw text.
"""
        payload = {
            "contents": [{
                "parts": [{"text": prompt}]
            }],
            "generationConfig": {
                "temperature": 0.2
            }
        }

        data = json.dumps(payload).encode('utf-8')
        req = urllib.request.Request(self.url, data=data, headers={'Content-Type': 'application/json'}, method='POST')

        try:
            with urllib.request.urlopen(req, timeout=45.0) as response:
                result = json.loads(response.read().decode('utf-8'))
                
                # Extract text from API response
                try:
                    text = result['candidates'][0]['content']['parts'][0]['text'].strip()
                except (KeyError, IndexError):
                    text = "Error: Invalid response format from API."

                # Clean up markdown JSON wrappers if the model includes them
                if text.startswith('```json'):
                     text = text[7:]
                if text.startswith('```'):
                     text = text[3:]
                if text.endswith('```'):
                     text = text[:-3]
                     
                parsed_data = json.loads(text.strip())
                return {
                    "reasoning": parsed_data.get("reasoning", "No reasoning provided."),
                    "corrected_code": parsed_data.get("corrected_code", context_code)
                }
        except urllib.error.HTTPError as e:
            return {
                "reasoning": f"AI API Connection Failed: {e.code} {e.reason}. Please verify if your API Key is valid and active.",
                "corrected_code": context_code
            }
        except Exception as e:
            return {
                "reasoning": f"AI Parsing Failed: {str(e)}",
                "corrected_code": context_code
            }
