# VeriLint Core Engine
**Live Deployment:** [https://verilint.onrender.com](https://verilint.onrender.com)

VeriLint is an AI-powered Verilog static analysis and linting engine. Built on a modular architecture, it executes heuristic rulesets to prevent synthesization failure, and utilizes Google's Gemini models for dynamic structure refactoring of flawed hardware designs.

## Architecture

VeriLint evaluates logic stability across three distinct execution phases:

1. **Token/AST Parser**: Parses `always`, `initial`, `module`, and `global` block regions from the hardware source code while mapping topological scopes.
2. **Deterministic Rules Engine**: Python-based static analysis engine that checks execution flow to isolate fatal simulation and synthesization parameters.
3. **LLM Patch Generation**: Integrates the `RealGeminiAI` framework via REST. Violations are extracted alongside internal AST mappings into the Gemini-Flash endpoint to synthesize "Probable Fixes".
   - *Caching Layer*: Includes a local MD5 exact-match heuristic caching mechanism. Any duplicate code queries instantly load pre-compiled JSON AI models locally from disk `/cache` to eliminate redundant token execution.
   - *Timeouts*: API boundary operates on an extended 120-second timeout allocation to prevent Gunicorn processing timeouts on complex design networks.

## Core Rule Definitions

* `[R001] Mixed Assignments`: Identifies combinations of blocking (`=`) and non-blocking (`<=`) syntax within the identical `always` sequential block limit.
* `[R002] Naming Conventions`: Enforces explicit `_n` or `_b` suffix arrays for active-low operations (`rst`, `clear`).
* `[R003] Inferred Latches`: Traps combinational constructs running incomplete IF/CASE routing layers missing fallback `default` logic.
* `[R004] Syntax Checker`: Validates generic module encapsulation layout matching definitions recursively.
* `[R005] Multi-Driver Collisions`: Traverses logical boundaries preventing solitary nets from being concurrently written by asynchronous multi-always drivers.
* `[R006] Procedural Wire Assignments`: Forbids sequential behavioral procedures (`always`) from assigning values to continuous target nets (`wire`).

## Deployment & Local Execution

The application is unified into a monolithic Flask web service (`app.py`), statically routing the frontend components under `/frontend/assets/`. 

### Local Run Environment
1. Ensure your `.env` contains `GEMINI_API_KEY=<YOUR_KEY>`.
2. Build Python requirements: `pip install -r requirements.txt`.
3. Launch via Gunicorn: `gunicorn app:app --timeout 120`.
4. The service will spin up on `127.0.0.1:8000`.

### Production Deployment (Render)
The repository contains a standard `render.yaml` infrastructure-as-code Blueprint explicitly configuring the Python environment. Connect the repository to your Render Dashboard via the Blueprint specification; no native Dockerfiles are required. Define `GEMINI_API_KEY` in the Render environment settings to successfully interact with the phase 3 engine.

## Model Benchmarking Suite

VeriLint provides a utility dataset aggregation script designed for external AI training model verification.

```bash
python generate_dataset.py
```
This generates a targeted `dataset.csv` holding structural AST bug patterns correlated natively with syntactically flawless refactorings intended to benchmark downstream Large Language Models.
