tags:: mermaid, circular
public:: true

- ```mermaid
  graph TD;
      A[fa:fa-vial Testing] -->|Process| B[fa:fa-print Production];
      B -->|Manufacture| C[fa:fa-cube Object];
      C -->|Distribute| D[fa:fa-map-marker Local];
      D -->|Collect| E[fa:fa-trash Sorting];
      E -->|Recycle| F[fa:fa-shredder Shredding];
      F -->|Reprocess| G[fa:fa-industry Extrusion];
      G -->|Reuse| A;
  ```