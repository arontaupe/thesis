tags:: mermaid, plastic identification
public:: true

- Graphics adapted from [[@Identification of Polymers]]
- ```mermaid
  graph TD
      A[Water Test] -->|Sinks| B[<b>Copper Wire Test</b>]
      A -->|Floats| C[<b>Alcohol Test</b>]
  
      B -->|Green Flame| D[PVC]
      B -->|Orange Flame| E[<b>Acetone Test</b>]
      E -->|Reaction| F[PS]
      E -->|No Reaction| G[<b>Heat Test</b>]
      G -->|Reaction| H[PETE]
  
      C -->|Sinks| I[HDPE]
      C -->|Floats| J[<b>Oil Test</b>]
      J -->|Sinks| K[LDPE]
      J -->|Floats| L[PP]
  
      %% Style leaf nodes
      style D fill:#f9f,stroke:#333,stroke-width:2
      style F fill:#f9f,stroke:#333,stroke-width:2
      style H fill:#f9f,stroke:#333,stroke-width:2
      style I fill:#f9f,stroke:#333,stroke-width:2
      style K fill:#f9f,stroke:#333,stroke-width:2
      style L fill:#f9f,stroke:#333,stroke-width:2
  ```