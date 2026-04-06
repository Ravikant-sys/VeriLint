# Verilint Core Engine

Verilint is an advanced, AI-powered Verilog static analysis and linting engine. It goes substantially beyond simple syntax checking by actively compiling context block models, applying robust architecture heuristics to prevent synthesization failure, and directly communicating with Google's Gemini AI to dynamically orchestrate structural refactoring of flawed hardware designs.

## 🚀 Architecture Pipeline

Verilint evaluates codebase stability across three deterministic phases:

1. **Phase 1: Tokenization/Parsing Pipeline**
   Extracts `always`, `initial`, `module_decl` and `global` procedural blocks from source code while actively mapping topological code scope using balanced traversal rules.
   
2. **Phase 2: Verilint Rule Engine**
   A rigorous suite of internal Python logic rules parses the execution flow to identify dangerous simulation patterns before synthesis generation.
   
3. **Phase 3: Deep AI Refactoring Engine**
   Using the `RealGeminiAI` framework (leveraging `gemini-flash-latest`), natively generated violations are seamlessly passed into an LLM context window against the complete Verilog codebase interface for deep-state reasoning. The AI strictly computes the most logical "Probable Fix" strategy and emits a flawlessly patched code snippet.

---

## 🛡️ Active Rule Checks

* **[R001] Mixed Assignments**: Detects catastrophic trace conditions involving blocking (`=`) and non-blocking (`<=`) logic occurring sequentially within the same `always` evaluation block.
* **[R002] Naming Conventions**: Enforces `_n` or `_b` suffix structures for `rst` and `clear` signals.
* **[R003] Inferred Latches**: Detects incomplete `if` or `case` combinational branching paths (e.g., missing `else` logic, or missing `default` labels) that incorrectly infer memory retention.
* **[R004] Syntax Checker**: Recursively searches instantiations globally to trap deeply nested missing terminators (missing `;` or `,`).
* **[R005] Multi-Driver Collisions**: Traverses asynchronous global states to prevent the identical hardware signal from being forcibly driven by multiple, fiercely conflicting `always` procedural blocks.
* **[R006] Procedural Wire Assignments**: Stops synthesization crashes generated when a state machine directly assigns combinatorial data to a `wire` trace inside a chronological loop.
* **[R007] Sensitivity Mismatches**: Reconciles asynchronous signal dependencies (e.g. `posedge clk`) missing from implicit sensitivity declarations.
* **[R009] Unused Ports**: Resolves input/output module interfaces that are completely untethered from processing logic globally.
* **[R010] Dead Code & Unreachable FSMs**: Aggressive algorithmic validation targeting defined Parameter States that are unreachable due to incomplete procedural LHS state transitions (Dead State Logic).

---

## 🌐 Web Server & UI 

Verilint comes fully equipped with a modern, Glassmorphism-themed dynamic Localhost Router. 

**To Start the Web UI Engine:**
```bash
cd Verilint
python server.py
```
*Navigate to `http://localhost:8000` to access the Visual Inspector GUI.* The frontend automatically binds to the Python Engine through local REST networking, dynamically piping Verilog syntax data directly into the Phase 3 LLM and visualizing precise `Line-by-Line` bounding UI badges!

---

## 📊 Benchmark Dataset Generation Suite

If you want to train alternative LLM pipelines onto the Verilint Framework, a localized benchmark testbed can be spun up automatically.

**Generate Test Suite Data:**
```bash
python generate_dataset.py
```
This generates an automated `dataset.csv` payload holding mapped logical string context between hundreds of procedurally generated buggy Verilog modules (multi-driver crashes, inferred latches, etc) securely alongside their flawless algorithmic refactored fixes!
