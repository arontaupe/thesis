- ```mermaid
  graph TD;
      A[Rubbish Collection] --collects--> B[[Shredder - Produces Granules]];
      B --shreds--> C[[Sorting Station]];
      C --sorts--> D[[Hot Press - Melts and Compresses]];
      D --compresses--> E[Processing];
      E --processes directly--> G[[Welding / Hot Air / Oven - Combining Parts]];
      E --cuts optionally--> F[[CNC Machine - Cutting to Shape]];
      F --feeds into--> G;
      G --welds--> G1((Welding Machine));
      G --heats--> G2((Hot Air Machine));
      G --bakes--> G3((Oven));
      G1 --finalizes--> H((Final Object Ready));
      G2 --finalizes--> H;
      G3 --finalizes--> H;
  
  ```