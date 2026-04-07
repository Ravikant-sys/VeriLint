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
    const themeToggle = document.getElementById('themeToggle');
    const htmlEl = document.documentElement;
    const sunIcon = document.getElementById('sunIcon');
    const moonIcon = document.getElementById('moonIcon');

    // API CONFIG
    const API_URL = '/analyze';

    // --- Loading Stream Logic ---
    let tokenInterval;
    
    function startTokenCounter() {
        let tokens = 0;
        const tokenElem = document.getElementById('tokenCounter');
        const statusElem = document.getElementById('loadingStatusText');
        const statuses = [
            'Extracting Verilog Modules...', 
            'Constructing Abstract Syntax Tree...', 
            'Engaging Gemini Pro heuristics...', 
            'Analyzing multi-driver collisions...', 
            'Validating standard compliance...', 
            'Awaiting neural inference stream...'
        ];
        
        tokenInterval = setInterval(() => {
            tokens += Math.floor(Math.random() * 25) + 5;
            if (tokenElem) tokenElem.innerText = tokens;
            
            if(Math.random() > 0.95 && statusElem) {
                statusElem.innerText = statuses[Math.floor(Math.random() * statuses.length)];
            }
        }, 50);
    }

    function stopTokenCounter() {
        clearInterval(tokenInterval);
    }
    // ----------------------------


    // --- Theme Management ---
    function updateThemeIcons() {
        if (htmlEl.classList.contains('dark')) {
            sunIcon.classList.remove('hidden');
            moonIcon.classList.add('hidden');
        } else {
            sunIcon.classList.add('hidden');
            moonIcon.classList.remove('hidden');
        }
    }

    // Check previously saved theme (defaults to light mode)
    if (localStorage.getItem('theme') === 'dark') {
        htmlEl.classList.add('dark');
    } else {
        htmlEl.classList.remove('dark');
    }
    updateThemeIcons();

    themeToggle.addEventListener('click', () => {
        htmlEl.classList.toggle('dark');
        const isDark = htmlEl.classList.contains('dark');
        localStorage.setItem('theme', isDark ? 'dark' : 'light');
        updateThemeIcons();
    });
    // ------------------------

    // Drag and drop handlers
    dropZone.addEventListener('click', () => fileInput.click());
    
    dropZone.addEventListener('dragover', (e) => {
        e.preventDefault();
        dropZone.classList.add('border-green-500', 'bg-slate-50', 'dark:bg-slate-900');
    });

    dropZone.addEventListener('dragleave', () => {
        dropZone.classList.remove('border-green-500', 'bg-slate-50', 'dark:bg-slate-900');
    });

    dropZone.addEventListener('drop', (e) => {
        e.preventDefault();
        dropZone.classList.remove('border-green-500', 'bg-slate-50', 'dark:bg-slate-900');
        const files = e.dataTransfer.files;
        if (files.length > 0) handleUpload(files[0]);
    });

    // Test File click handlers
    const testFileBtns = document.querySelectorAll('.test-file-btn');
    testFileBtns.forEach(btn => {
        btn.addEventListener('click', async () => {
            const fileName = btn.getAttribute('data-file');
            try {
                // Determine file contents from the static folder
                const response = await fetch(`/assets/test_files/${fileName}`);
                if (!response.ok) throw new Error('File not found');
                const text = await response.text();
                
                // Create a virtual file object to simulate drop/upload
                const file = new File([text], fileName, { type: "text/plain" });
                handleUpload(file);
            } catch (error) {
                console.error("Error loading test file:", error);
                alert("Failed to load the test file. Ensure it exists in the test_files directory.");
            }
        });
    });

    fileInput.addEventListener('change', (e) => {
        if (e.target.files.length > 0) handleUpload(e.target.files[0]);
    });

    uploadBtnTop.addEventListener('click', () => {
        resultsSection.classList.add('hidden');
        uploadSection.classList.remove('hidden');
        uploadBtnTop.classList.add('hidden'); // Hide when back to upload section
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
        // Hide uploadbtn if it was somehow visible
        uploadBtnTop.classList.add('hidden');
        
        // Start streaming aesthetic
        const tokenElem = document.getElementById('tokenCounter');
        if (tokenElem) tokenElem.innerText = '0';
        startTokenCounter();

        const formData = new FormData();
        formData.append('file', file);

        try {
            const response = await fetch(API_URL, {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                let errorMsg = 'Analysis failed';
                try {
                    const errData = await response.json();
                    if (errData.error) errorMsg = errData.error;
                } catch(e) {}
                throw new Error(errorMsg);
            }

            const data = await response.json();
            renderResults(data);
        } catch (error) {
            console.error(error);
            stopTokenCounter();
            
            // Gracefully render the crash into the DOM instead of alerting
            renderResults({
                design_health_score: 0,
                violations: [{
                    id: "ERR_504",
                    type: "Engine Timeout",
                    line: 0,
                    explanation: "Backend proxy disconnected or AI Engine timed out due to complex data logic.",
                    snippet: "// Connection sequence forcefully terminated\n// by cloud load balancers.",
                    refactoring: "// Please verify GEMINI_API_KEY is active.\n// Try scanning a less complex module or relying on cached results.",
                    suggestion: "// Please verify GEMINI_API_KEY is active."
                }]
            });
        }
    }

    function renderResults(data) {
        stopTokenCounter();
        loader.classList.add('hidden');
        resultsSection.classList.remove('hidden');
        
        // Show New Analysis button
        uploadBtnTop.classList.remove('hidden');

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
            severityLevel.className = 'text-green-600 dark:text-green-400 font-bold px-3 py-1 bg-green-100 dark:bg-green-400/10 rounded-full text-sm';
        } else if (data.violations.length < 3) {
             severityLevel.innerText = 'Moderate';
             severityLevel.className = 'text-yellow-600 dark:text-yellow-400 font-bold px-3 py-1 bg-yellow-100 dark:bg-yellow-400/10 rounded-full text-sm';
        } else {
             severityLevel.innerText = 'Critical';
             severityLevel.className = 'text-red-600 dark:text-red-400 font-bold px-3 py-1 bg-red-100 dark:bg-red-400/10 rounded-full text-sm';
        }

        // Render Violations
        violationsList.innerHTML = '';
        if (data.violations.length === 0) {
            violationsList.innerHTML = '<div class="p-8 text-center bg-white dark:bg-slate-900 rounded-3xl border border-slate-200 dark:border-slate-800"><p class="text-slate-500 dark:text-slate-400">No violations found! Your design follows all guidelines.</p></div>';
            return;
        }

        data.violations.forEach(v => {
            const item = document.createElement('div');
            item.className = 'bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-2xl p-6 shadow-sm hover:shadow-md hover:border-slate-300 dark:hover:border-slate-700 transition-all card-glow';
            item.innerHTML = `
                <div class="flex flex-col md:flex-row justify-between items-start mb-6">
                    <div>
                        <div class="flex items-center space-x-3 mb-2">
                            <span class="px-2 py-0.5 bg-red-100 dark:bg-red-500/10 text-red-600 dark:text-red-500 text-[10px] font-bold rounded border border-red-200 dark:border-red-500/20 uppercase tracking-wider">${v.id}</span>
                            <h4 class="text-lg font-bold text-slate-800 dark:text-white">${v.type}</h4>
                        </div>
                        <p class="text-slate-500 dark:text-slate-400 text-sm">Line ${v.line} &bull; ${v.explanation}</p>
                    </div>
                </div>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="bg-slate-50 dark:bg-slate-950 rounded-xl overflow-hidden border border-slate-200 dark:border-slate-800">
                        <div class="px-4 py-2 bg-slate-100 dark:bg-slate-900/50 border-b border-slate-200 dark:border-slate-800 text-[10px] font-bold text-slate-500 uppercase flex justify-between items-center">
                            <span>Detected Issue</span>
                            <span class="text-red-500 dark:text-red-500/50">L${v.line}</span>
                        </div>
                        <pre class="p-4 text-sm mono text-red-600 dark:text-red-400 overflow-x-auto"><code>${v.snippet}</code></pre>
                    </div>
                    <div class="bg-green-50 dark:bg-green-950/20 rounded-xl overflow-hidden border border-green-200 dark:border-green-500/20">
                        <div class="px-4 py-2 bg-green-100 dark:bg-green-500/10 border-b border-green-200 dark:border-green-500/20 text-[10px] font-bold text-green-700 dark:text-green-400 uppercase flex justify-between items-center">
                            <span>AI Suggested Fix</span>
                             <span class="text-green-600 dark:text-green-500/50">Gemini Pro</span>
                        </div>
                        <pre class="p-4 text-sm mono text-green-700 dark:text-green-300 overflow-x-auto"><code>${v.refactoring || v.suggestion}</code></pre>
                    </div>
                </div>
            `;
            violationsList.appendChild(item);
        });
    }
});
