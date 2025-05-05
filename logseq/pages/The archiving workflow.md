tags:: mermaid, archive, python
public:: true

- ```mermaid
  graph TD;
      A[Archivar] -->|Takes Pictures| B[Document Camera];
      B --> |Transmits|A1;
      
      subgraph Code Evaluation
          A1[Start] --> B1[Capture Image from Webcam];
          B1 --> C1[Extract Text using OCR];
          C1 -->|Tesseract/EasyOCR| D1[Check Readability with textstat];
          C1 -->|Ollama Vision| E1[Generate Description];
          B1 --> F1[Detect Markers using SIFT];
          D1 -->|Meaningful Text| G1[Upload Text to Logseq];
          E1 --> G1;
          B1 --> H1[Save Original Image];
          H1 --> I1[Upload Image to Logseq];
          F1 --> J1[Save Annotated Image];
          J1 --> K1[Store in Logseq Assets];
          G1 --> L1[End];
          I1 --> L1;
          K1 --> L1;
      end
      L1 --> M[Logseq Export]
      M --> N[Interactive Website]
  ```
- For a similar summary in pseudocode, check [[Archive Backend]]