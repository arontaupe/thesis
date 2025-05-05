tags:: mermaid, optimization
public:: true

- ```mermaid
  graph TD
      A["Winder speed<br>- controlled via laser"] --> D["Filament Diameter<br>- has to be consistent<br>- has to be a circle --> advanced systems measure ovality also"]
      B["Extrusion speed<br>- function of motor wattage and plastic resistance (temperature)"] --> D
      C["Cooling intensity<br>- function of extrusion speed and fan speed"] --> D
      E["Heat<br>- I can set the temp of the heating elements<br>- location and number of heating elements"] --> D
      
      D --> A
      D --> B
      D --> C
      D --> E
  ```