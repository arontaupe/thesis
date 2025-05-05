tags:: mermaid, rubbish theory

- ```mermaid
  flowchart TD
      A[TRANSIENT<br>Value decreases with time] <-.-> B[DURABLE<br>Value increases with time]
      A --> C[(RUBBISH<br>No value, no time)]
      B -.-> C
      C -.-> A
      C --> B
  ```