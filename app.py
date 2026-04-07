import os
import json
from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
from dotenv import load_dotenv
from werkzeug.utils import secure_filename

# Import VerilintCore
from verilint.core import VerilintCore

load_dotenv()

# Serve static files from 'frontend'
app = Flask(__name__, static_folder='frontend', static_url_path='')
CORS(app)

UPLOAD_FOLDER = 'uploads'
ALLOWED_EXTENSIONS = {'v'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

engine = VerilintCore()

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/')
def index():
    return app.send_static_file('index.html')

@app.route('/analyze', methods=['POST'])
def analyze_file():
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400
    
    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400
    
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)
        
        with open(filepath, 'r') as f:
            content = f.read()
            
        
        try:
            results = engine.run_json(content)
            
            lines = content.splitlines()
            mapped_violations = []
            for v in results.get('violations', []):
                start = max(0, v.get("start_line", 1) - 1)
                end = min(len(lines), v.get("end_line", 1))
                # Add context lines if needed, but here we just take the block directly
                snippet = "\n".join(lines[start:end]) if lines else "N/A"
                if not snippet.strip():
                     snippet = "// No clear snippet identified"
                
                mapped_violations.append({
                    "id": v.get("rule_id", "R000"),
                    "type": v.get("severity", "Warning").capitalize(),
                    "line": v.get("start_line", 1),
                    "explanation": v.get("message", ""),
                    "snippet": snippet.strip(),
                    "suggestion": v.get("corrected_code", ""),
                    "refactoring": v.get("corrected_code", "")
                })
            
            score = max(0, 100 - len(mapped_violations) * 5)
            
            response_data = {
                "status": "success",
                "filename": filename,
                "design_health_score": score,
                "violations": mapped_violations
            }
            
            
            return jsonify(response_data)
            
        except Exception as e:
            return jsonify({"error": str(e)}), 500

    return jsonify({"error": "Invalid file type"}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
