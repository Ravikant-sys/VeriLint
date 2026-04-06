// Elements
const codeEditor = document.getElementById('codeEditor');
const lineNumbers = document.getElementById('lineNumbers');
const clearBtn = document.getElementById('clearBtn');
const analyzeBtn = document.getElementById('analyzeBtn');
const resultsContainer = document.getElementById('resultsContainer');
const engineStatus = document.getElementById('engineStatus');

// Update line numbers dynamically
function updateLineNumbers() {
    const lines = codeEditor.value.split('\n').length;
    let numbersHtml = '';
    for (let i = 1; i <= lines; i++) {
        numbersHtml += `<div>${i}</div>`;
    }
    lineNumbers.innerHTML = numbersHtml || '1';
}

codeEditor.addEventListener('input', updateLineNumbers);
codeEditor.addEventListener('scroll', () => {
    lineNumbers.scrollTop = codeEditor.scrollTop;
});

// Initialize line numbers
updateLineNumbers();

// Clear editor
clearBtn.addEventListener('click', () => {
    codeEditor.value = '';
    updateLineNumbers();
    resetResults();
});

function resetResults() {
    resultsContainer.innerHTML = `
        <div class="empty-state">
            <svg class="empty-icon" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
            <p>Submit code to run Phase 1 (Parsing), Phase 2 (Rule Engine), and Phase 3 (AI Refactoring).</p>
        </div>
    `;
    engineStatus.textContent = 'Awaiting Input';
    engineStatus.className = 'status-badge idle';
}

// REAL Analysis API Flow
analyzeBtn.addEventListener('click', async () => {
    const code = codeEditor.value.trim();
    if (!code) return;

    // UI Loading state
    analyzeBtn.innerHTML = '<svg class="spin" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="2" x2="12" y2="6"></line><line x1="12" y1="18" x2="12" y2="22"></line><line x1="4.93" y1="4.93" x2="7.76" y2="7.76"></line><line x1="16.24" y1="16.24" x2="19.07" y2="19.07"></line><line x1="2" y1="12" x2="6" y2="12"></line><line x1="18" y1="12" x2="22" y2="12"></line><line x1="4.93" y1="19.07" x2="7.76" y2="16.24"></line><line x1="16.24" y1="7.76" x2="19.07" y2="4.93"></line></svg> Analyzing...';
    analyzeBtn.disabled = true;
    engineStatus.textContent = 'Engine API Running...';
    engineStatus.className = 'status-badge analyzing';
    
    resultsContainer.innerHTML = '';

    try {
        const response = await fetch('/analyze', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ code: code })
        });
        
        if (!response.ok) throw new Error('API Execution Failed');
        
        const data = await response.json();
        
        // Fast mock timeout just to animate visually
        setTimeout(() => {
            addPhaseCard('Phase 1: RegEx Tokenization Pipeline', '<p style="color:var(--success)">✓ Successfully mapped Context Blocks globally</p>', 0);
            
            setTimeout(() => {
                if (data.passed) {
                    addPhaseCard('Phase 2: Verilint Rule Engine', '<p style="color:var(--success)">✓ No syntax or architecture violations detected</p>', 100);
                    finalizeAnalysis(false);
                } else {
                    let violationsHTML = '';
                    let aiReasoningHTML = '';

                    // Build Phase 2 and Phase 3 natively from JSON iteration
                    data.violations.forEach((v, index) => {
                        // Badge tracking string for exact line location
                        let linesLabel = v.start_line === v.end_line ? `Line ${v.start_line}` : `Lines ${v.start_line}-${v.end_line}`;
                        if (v.start_line === -1) linesLabel = 'Global Scope';

                        violationsHTML += `
                            <div class="violation-banner">
                                <div class="violation-title">
                                    [${v.rule_id}] ${v.severity} <span class="line-badge">${linesLabel}</span>
                                </div>
                                <div class="violation-desc">${v.message}</div>
                            </div>
                        `;

                        aiReasoningHTML += `
                            <div class="ai-reasoning" style="margin-top: 1rem;">
                                <div class="ai-header">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2v4m0 12v4M4.93 4.93l2.83 2.83m8.48 8.48l2.83 2.83M2 12h4m12 0h4M4.93 19.07l2.83-2.83m8.48-8.48l2.83-2.83"></path></svg>
                                    Gemini Pipeline Refactoring (${linesLabel})
                                </div>
                                <p style="font-size: 0.9rem; margin-bottom: 1rem; color: var(--text-primary);">
                                    ${v.ai_reasoning}
                                </p>
                                <div class="ai-header">Suggested Snippet Fix</div>
                                <div class="refactored-code">${v.corrected_code}</div>
                            </div>
                        `;
                    });

                    addPhaseCard('Phase 2: Verilint Rule Engine', violationsHTML, 100);
                    
                    setTimeout(() => {
                        addPhaseCard('Phase 3: AI Gemini Architecture Fixes', aiReasoningHTML, 200);
                        finalizeAnalysis(true);
                    }, 500);
                }
            }, 300);
        }, 100);
    } catch (error) {
        addPhaseCard('System Error', `<p style="color:var(--error)">API Engine Crash: ${error.message}</p>`, 0);
        finalizeAnalysis(true);
    }
});

function addPhaseCard(title, content, delay) {
    const card = document.createElement('div');
    card.className = 'phase-card';
    card.style.animationDelay = delay + 'ms';
    
    // Select appropriate icon
    let icon = '<circle cx="12" cy="12" r="10"></circle><polyline points="12 16 16 12 12 8"></polyline><line x1="8" y1="12" x2="16" y2="12"></line>';
    if (title.includes('Phase 1')) icon = '<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline>';
    if (title.includes('Phase 2')) icon = '<polygon points="5 3 19 12 5 21 5 3"></polygon>';
    if (title.includes('Phase 3')) icon = '<path d="M12 2v4m0 12v4M4.93 4.93l2.83 2.83m8.48 8.48l2.83 2.83M2 12h4m12 0h4"></path>';

    card.innerHTML = `
        <h3><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">${icon}</svg> ${title}</h3>
        ${content}
    `;
    resultsContainer.appendChild(card);
    
    // Auto scroll bottom
    resultsContainer.scrollTop = resultsContainer.scrollHeight;
}

function finalizeAnalysis(hasViolation) {
    analyzeBtn.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg> Analyze';
    analyzeBtn.disabled = false;
    
    if (hasViolation) {
        engineStatus.textContent = 'Violations Detected';
        engineStatus.className = 'status-badge violation';
    } else {
        engineStatus.textContent = 'Passed checks';
        engineStatus.className = 'status-badge passed';
    }
}
