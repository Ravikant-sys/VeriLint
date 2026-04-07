document.addEventListener('DOMContentLoaded', () => {
    const dropZone = document.getElementById('dropZone');
    const fileInput = document.getElementById('fileInput');
    const uploadSection = document.getElementById('uploadSection');
    const resultsSection = document.getElementById('resultsSection');
    const loader = document.getElementById('loader');
    const violationsList = document.getElementById('violationsList');
    const scoreCircle = document.getElementById('scoreCircle');
    const scoreText = document.getElementById('scoreText');
    const violationCount = document.getElementById('violationCount');
    const severityLevel = document.getElementById('severityLevel');
    const uploadBtnTop = document.getElementById('uploadBtnTop');

    // API CONFIG
    const API_URL = '/analyze';

    // Drag and drop handlers
    dropZone.addEventListener('click', () => fileInput.click());
    
    dropZone.addEventListener('dragover', (e) => {
        e.preventDefault();
        dropZone.classList.add('border-indigo-500', 'bg-slate-900');
    });

    dropZone.addEventListener('dragleave', () => {
        dropZone.classList.remove('border-indigo-500', 'bg-slate-900');
    });

    dropZone.addEventListener('drop', (e) => {
        e.preventDefault();
        dropZone.classList.remove('border-indigo-500', 'bg-slate-900');
        const files = e.dataTransfer.files;
        if (files.length > 0) handleUpload(files[0]);
    });

    fileInput.addEventListener('change', (e) => {
        if (e.target.files.length > 0) handleUpload(e.target.files[0]);
    });

    uploadBtnTop.addEventListener('click', () => {
        resultsSection.classList.add('hidden');
        uploadSection.classList.remove('hidden');
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    async function handleUpload(file) {
        if (!file.name.endsWith('.v')) {
            alert('Please upload a Verilog (.v) file.');
            return;
        }

        // Show loader
        uploadSection.classList.add('hidden');
        loader.classList.remove('hidden');

        const formData = new FormData();
        formData.append('file', file);

        try {
            const response = await fetch(API_URL, {
                method: 'POST',
                body: formData
            });

            if (!response.ok) throw new Error('Analysis failed');

            const data = await response.json();
            renderResults(data);
        } catch (error) {
            console.error(error);
            alert('Error connecting to the analysis engine. Make sure the Flask server is running.');
            loader.classList.add('hidden');
            uploadSection.classList.remove('hidden');
        }
    }

    function renderResults(data) {
        loader.classList.add('hidden');
        resultsSection.classList.remove('hidden');

        // Update Score Circular Progress
        const score = data.design_health_score;
        const circumference = 2 * Math.PI * 80;
        const offset = circumference - (score / 100) * circumference;
        
        scoreCircle.style.strokeDasharray = circumference;
        scoreCircle.style.strokeDashoffset = offset;
        scoreText.innerText = score;

        // Update Summary Stats
        violationCount.innerText = data.violations.length;
        if (data.violations.length === 0) {
            severityLevel.innerText = 'Excellent';
            severityLevel.className = 'text-green-400 font-bold px-3 py-1 bg-green-400/10 rounded-full text-sm';
        } else if (data.violations.length < 3) {
             severityLevel.innerText = 'Moderate';
             severityLevel.className = 'text-yellow-400 font-bold px-3 py-1 bg-yellow-400/10 rounded-full text-sm';
        } else {
             severityLevel.innerText = 'Critical';
             severityLevel.className = 'text-red-400 font-bold px-3 py-1 bg-red-400/10 rounded-full text-sm';
        }

        // Render Violations
        violationsList.innerHTML = '';
        if (data.violations.length === 0) {
            violationsList.innerHTML = '<div class="p-8 text-center bg-slate-900 rounded-3xl border border-slate-800"><p class="text-slate-400">No violations found! Your design follows all guidelines.</p></div>';
            return;
        }

        data.violations.forEach(v => {
            const item = document.createElement('div');
            item.className = 'bg-slate-900 border border-slate-800 rounded-2xl p-6 hover:border-slate-700 transition-all card-glow';
            item.innerHTML = `
                <div class="flex flex-col md:flex-row justify-between items-start mb-6">
                    <div>
                        <div class="flex items-center space-x-3 mb-2">
                            <span class="px-2 py-0.5 bg-red-500/10 text-red-500 text-[10px] font-bold rounded border border-red-500/20 uppercase tracking-wider">${v.id}</span>
                            <h4 class="text-lg font-bold text-white">${v.type}</h4>
                        </div>
                        <p class="text-slate-400 text-sm">Line ${v.line} &bull; ${v.explanation}</p>
                    </div>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="bg-slate-950 rounded-xl overflow-hidden border border-slate-800">
                        <div class="px-4 py-2 bg-slate-900/50 border-b border-slate-800 text-[10px] font-bold text-slate-500 uppercase flex justify-between items-center">
                            <span>Detected Issue</span>
                            <span class="text-red-500/50">L${v.line}</span>
                        </div>
                        <pre class="p-4 text-sm mono text-red-400 overflow-x-auto"><code>${v.snippet}</code></pre>
                    </div>
                    <div class="bg-indigo-950/20 rounded-xl overflow-hidden border border-indigo-500/20">
                        <div class="px-4 py-2 bg-indigo-500/10 border-b border-indigo-500/20 text-[10px] font-bold text-indigo-400 uppercase flex justify-between items-center">
                            <span>AI Suggested Fix</span>
                             <span class="text-indigo-500/50">Gemini Pro</span>
                        </div>
                        <pre class="p-4 text-sm mono text-indigo-300 overflow-x-auto"><code>${v.refactoring || v.suggestion}</code></pre>
                    </div>
                </div>
            `;
            violationsList.appendChild(item);
        });
    }
});
