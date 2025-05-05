(function () {
    function extractMermaidCodeFromDivs() {
        document.querySelectorAll("div[data-lang='mermaid']").forEach((block) => {
            const textarea = block.querySelector("textarea[data-lang='mermaid']");
            if (!textarea) return;

            const mermaidCode = textarea.value; // Directly use the value from the textarea
            const mermaidElement = document.createElement("pre");
            mermaidElement.classList.add("mermaid");
            mermaidElement.textContent = mermaidCode;

            block.replaceWith(mermaidElement);
        });
    }

    function processMermaidBlocks() {
        extractMermaidCodeFromDivs();

        // Ensure Mermaid.js is initialized
        if (window.mermaid && typeof window.mermaid.run === "function") {
            window.mermaid.run({
                querySelector: ".mermaid",
            });
        }
    }

    function initMermaidRenderer() {
        console.log("Initializing Mermaid 11 renderer in Logseq...");

        // Run immediately
        processMermaidBlocks();

        // Observe for changes in the DOM (handles page navigation)
        const observer = new MutationObserver(() => processMermaidBlocks());
        observer.observe(document.body, { childList: true, subtree: true });

        // Load Mermaid.js dynamically if not already loaded
        if (!window.mermaid) {
            const script = document.createElement("script");
            script.src = "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js";
            script.onload = () => {
                mermaid.initialize({
                    startOnLoad: false,
                    securityLevel: "loose",
                });
                processMermaidBlocks();
            };
            document.head.appendChild(script);
        }
    }

    // Ensure Logseq is fully loaded before running
    if (window.logseq) {
        logseq.ready(initMermaidRenderer);
    } else {
        document.addEventListener("DOMContentLoaded", initMermaidRenderer);
    }
})();
