// Ensure script runs only after Logseq UI loads
logseq.ready(() => {
    function extractMermaidCode(text) {
        // Match content inside ```mermaid ... ```
        const mermaidRegex = /```mermaid\s([\s\S]*?)```/g;
        return text.replace(mermaidRegex, function(match, mermaidCode) {
            return `<pre class="mermaid">${cleanMermaid(mermaidCode)}</pre>`;
        });
    }

    function cleanMermaid(code) {
        return code
            .replace(/logseq____/g, "") // Remove logseq artifacts
            .replace(/&quot;/g, '"') // Convert escaped quotes
            .replace(/&lt;/g, "<") // Convert escaped less-than
            .replace(/&gt;/g, ">") // Convert escaped greater-than
            .replace(/\\n/g, "\n") // Convert `\n` into actual newlines
            .trim();
    }

    function processMermaidBlocks() {
        document.querySelectorAll("pre code").forEach((block) => {
            const cleanedHtml = extractMermaidCode(block.innerHTML);
            if (cleanedHtml !== block.innerHTML) {
                const wrapper = document.createElement("div");
                wrapper.innerHTML = cleanedHtml;
                block.parentElement.replaceWith(...wrapper.childNodes);
            }
        });

        // Ensure Mermaid.js is initialized
        if (window.mermaid) {
            mermaid.init(undefined, document.querySelectorAll(".mermaid"));
        }
    }

    // Run on page load
    processMermaidBlocks();

    // Observe for changes in the DOM (useful when navigating Logseq pages)
    const observer = new MutationObserver(() => processMermaidBlocks());
    observer.observe(document.body, { childList: true, subtree: true });

    // Load Mermaid.js dynamically if not already loaded
    if (!window.mermaid) {
        const script = document.createElement("script");
        script.src = "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js";
        script.onload = () => mermaid.initialize({ startOnLoad: true });
        document.head.appendChild(script);
    }
});
