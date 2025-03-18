= The Workshop: a scaffolding for collective investigation <sec:workshop>
It was clear pretty early in the conceptualization phase of the thesis research that a workshop format and methodology is the desired outcome.
A workshop, essentially a ritualized communal learning experience is the ideal breeding ground for experimenting with novel formats.

== A history of making: the genesis of the workshop <sec:genesis>

As already mentioned in @sec:introduction, initially, the plan was to create a machine workflow, that enables the user to 3D-print using exclusively self-recycled plastics#footnote[The initial idea was basically born around this Video: #cite(<cnckitchenRecycleYourFailed>)]. Since Fused-Deposition-Modelling (FDM) Printers are most widely available and they depend on Filament, a long strand of plastics, usually rolled onto a spool, that needed to be created. 
To create filament, an _Extruder_ is needed, a machine using a screw to feed plastics pellets into a heated chamber pressing the melted plastic through a die, much like how spaghetti are made. 

To achieve something resembling virgin plastics-pellets used in the industry, the usual plastic waste comes in pieces too big to work with. A uniform particle size, around 5mm is desirable, and best achieved using a plastic shredder.

Shredding plastic is not a trivial process, on a hobbyist level, people often try to re-purpose paper shredders with mixed results.
I built this shredder in 2019, already with a research project in mind.
The primary focus there was to achieve a granulate uniform enough to work in conjunction with the #cite(<filastruderFilastruderKit>, form: "prose").
The thinking was to attach some kind of micro-controller to get the sensitive extrusion process under automated control, which requires an enormous level of accuracy and consistency.
The Filastruder wrote history for being the first commercially available filament extruder achieving a price-point under 1000 Euro. 
It's winding process is laser-based, so it is, in addition to being sensitive to wind and temperature changes, also sensitive to changes in light. 
This proved to be a hard challenge without a dedicated workspace setup that could be light-controlled.
While Recycling-to-Filament poses an interesting and often-tackled research problem #cite(<Mikula2021>), for the purposes of a participatory workshop, I decided for plate fabrication in the end.

Workflows in a didactic context need to be resilient, and simplicity usually wins there. A process involving sheets does constrain the area of potential research slightly more than a process allowing 3D Printing in a truly circular fashion, but the easier, even kid-friendly sheet process makes up for that. 

Another question that often came up, is the question of the product. 
Something has to be made out of the materials in the workshop and this something is ideally viewed as unequivocally having greater value. An object can only ascend to a _durable_ status if enough people decide it is worth keeping. 

Thereby, a high burden of decision is present: what can we make that is better than the material we made it out of? 

After not being able to come up with a convincing answer, and through some processual feedback by Franz I found the practice of the Materialstudien described in @materialstudien. 
That formed the first buds of the conceptual framing now present: 
A workshop is first and foremost a learning experience, a tool of knowledge. 
Could the generated knowledge be what gives value to the created object?

The planning shifted away from needing to create things people might consider useful (that's where I see value) towards thinking about how to capture and materialize the Knowledge. 
Working with plastic, at least in the manner proposed here, seems quite artisanal, touching and deforming molten plastic requires an intimate experiential knowledge, one that is less present in printing out a purely digitally modeled file.

Plastics are craftable in many ways, sometimes behaving like wood or iron, or even glass, but we tend not to think about plastics in this fashion, since they were only widely present only after the industrialization and depend on often socially invisible processes of industry. 

How can we craft plastics? How deform them? How can we _transmatter_ them and attribute novel meaning? 

== Intent and constituting elements <sec:intent_and_elements>
Plastics pollution is one of the most pressing environmental challenges of our time, yet recycling processes are often monopolized by industrial systems that prioritize economic efficiency over ecological sustainability. The ReShaping Plastics workshop aims to empower participants with hands-on experience in recycling and reimagining plastic waste as a valuable resource, fostering a sense of agency against an otherwise overwhelming global issue.
This workshop is open to participants from all disciplines, requiring no prior experience. Over the course of two sessions, participants will learn to construct a DIY plastic sheet press and explore innovative methods for recycling plastic waste into durable and functional objects. The small group size of less than 10 people ensures an intimate, collaborative environment tailored to the capabilities of the tools provided.

The workshop encourages a shift in perspective, treating plastic not as disposable waste but as a versatile material capable of new forms and functions. By engaging directly with the processes of sorting, shredding, heating, and molding plastic waste, participants will gain practical skills and insights into sustainable design practices and circular economies.

The workshop balances technical instruction with creative exploration, culminating in the production of personalized objects such as engraved cutting boards, modular clamps, or experimental prototypes. Participants will leave with a deeper understanding of plastics' life-cycle and the tools to advocate for and contribute to ecological innovation in their communities.
This is not just a recycling workshop—it's an opportunity to rethink waste, create tangible solutions, and spark a broader dialogue on sustainability and material culture.

TODO Concisely repeat the intent of the workshop

A workshop can foster experimentation and leaves breathing room for the unexpected. It's an opportunity to explore new ideas, test hypotheses, and refine processes in a collaborative environment. It is set up around a loose network of research tasks, while its main achievement is the provision of infrastructure. It provides access to the AutomatedArchive described in @AutomatedArchive, and also enables prestructured access to a host of Workstations and Machines laid out in @machinesetup

What are expected outcomes?
What is to be proven?



#figure(
[
#image("../assets/images/recycling_process.png", width: 120%)
#set align(left)
_Note._
Plastic recycling is a complex, multi-step process. It involves several stages, and on an industry scale, many different pathways are established. For a good overview of different industrial pathways see #cite(<volkTechnoeconomicAssessmentComparison2021>, form: "prose").
Presented here is an adapted one that incorporates feasibility in smaller scales and is designed with the machinery and PPE process at hand in mind.
],
caption: [
	The specific plastic recycling process in the workshop
],
placement: none,
)<fig:recycling_process>

== Setup and Machines <machinesetup>

The workshop concept hinges on the quick availability of machines that can be easily transported and set up at various locations. 
A central constraint is portability, as the workshop should be able to adapt to different spaces and contexts without requiring extensive infrastructure or setup time. 
As a consequence, everything was built on wheels. 
The workshop's core components include:

- The Shredder (@shredder)
- The Material Station (@MaterialStation)
- Heat Area (@press)
- CNC Station (@cncstation)
- Post-Processing Area (@postprocessingarea)
- Upload Station (@uploadstation)

=== Areas and Stations
Within the setup, a clear zoning was pursued, to cleanly separate different types of work areas.
Everything is intentionally happening in the same room, to aid with flow and collaboration. The stations are designed to be modular and easily reconfigurable. 
First, it makes sense to divide into the desk area (@sec:plenum), and the workshop area. 
Situated adjacent to the desk area is also the UploadStation, described in @uploadstation. 
Switching regularly back and forth utilizes each infrastructures strength and guides people towards either reflective or active states with less explicit instructions.


==== Enabling Sharing: the desk area <sec:plenum>

A central element to tie all the others together is a classic Roundtable Structure, which serves as the focal point for discussions and collaborative work. 
The desk area is equipped with a large screen and all the essential information as printouts, allowing participants to share ideas and progress in real-time.

#figure(
[
#image("/assets/images/inküle/p23.jpg", width: 80%)
#set align(left)
_Note._
 A dedicated table was prepared to enable exploring digital results and to facilitate communal reflection\
Image Credits: Beril Ece Güler / InKüLe
],
caption: [
	More Zoning effects: the Area for sharing experiences and peer-learning
],
placement: none,
)<fig:p23>


==== The UploadStation <uploadstation>

This is where documentation happens. 
It is a designated desk, slightly removed from the working area, yet close enough to cause as little obstructions to its use as possible.
The UploadStation has an assortment of paper, markers, and pens, such that any concept can quickly be sketched out.
To make the process even quicker, also the sketching or tagging is optional: the fastest way to convey an idea is by moving any pre-printed marker into the frame of the camera along with the research object. 

The markers were tested in multiple iterations. They depend on template matching, meaning the maker is defined by its specific (edge)shape. 
This has multiple reasons: 
1. It is very fast: scanning a 4k image for over 30 markers takes less than 120ms
2. As long as the shape is distinct, the markers and their associated meaning is arbitrary. We can potentially decide on new markers or decide to redefine their meaning relatively quickly

Hidden in there is also the biggest flaw of this architecture, only discovered in the process of the workshop: All recycling logos have the same overall shape, only distinct by the number in the middle. Using the recycling logo several times as marker proved unreliable. In a real-world scenario with changing light conditions and people bumping into cameras, changing focus etcetera some markers had to be retired.

I also tried Laser-cut wooden chips as markers, sadly the Contrast was not strong enough to get reliably picked up. This was fixed for the second workshop iteration. TODO check

A positive surprise was how well the last (of many) iteration of Optical Character Recognition (OCR) worked. Detecting Handwritten characters is arguably harder than OCR for print, which is essentially a solved problem in computer vision. Several other algorithms such as _tesseract_ and _EasyOCR_ worked well on the printed markers but were struggling with handwriting. 
Large Language models already performed noticeably better, but were taking the upload sequence from 2 seconds to 2 minutes. They are implemented and can optionally be enabled to perform OCR. The solution that did the best in the end was utilizing the built-in apple vision framework using _pyobjC_ That is essentially Apples proprietary algorithms for extracting writing form Photos. It is fast (170ms) and the most reliable of all options, while also being able to detect QR-Codes, Bar-codes and URLs. It is hard to recommend since it is bound to specific hardware and proprietary, therefore optional in the project, but it enabled mostly flawless detection of hashtags.
This made it possible for users to expand on the Markers, transforming the previously closed class into a variable, ever-expanding one. 

TODO move to software discussion? 

#figure(
  [
  #image("../assets/images/workshop_setup/uploadstation.jpeg", width: 80%)
  #set align(left)
  ],
  caption: [ The UploadStation ],
    placement: none,
)<fig:uploadstation>

The UploadStation denotes only the physical area of interaction with the participants. 
All of the software-back-end taking place here are discussed in @AutomatedArchive.

After looking at the Areas aiding in reflective and discussion states, now follows the layout for the explorative and practical part.

==== The MaterialStation <MaterialStation>
For all of the shredded material, there needs to be a way to store them, keep them sorted and clean, yet portable.

Herein lies a delicate balance, since it will become infeasible very quickly having several colors from every type of material on hand.
The material station, made from an IKEA serving kart and several restaurant grade steel containers on aluminum rails, attempts to solve the storage issue in a compact, versatile and portable form factor.

One moot point here is the labelling. For later iterations it would be convenient to have material type and color on a given container labeled in a reusable fashion. 
In the current, more prototypical fashion, it was nevertheless quite usable and comfortably fits more color variations than really needed for initial experimentation.

Arguably, the overall objective of flexible and efficient storage is met in this iteration and it hopefully serves in many more upcoming formats.

#figure(
  [
  #image("../assets/images/workshop_setup/materialstation.jpeg", width: 80%)
  #set align(left)
  ],
  caption: [ The MaterialStation ],
    placement: none,
)<fig:materialstation>

After Participants had selected their Materials and colors, they would continue to the Heat-press Station described in @press.

=== Machines <sec:machines>
In this section, I shortly describe the machines chosen for the workflow and their specific (dis)advantages. I will also describe some deliberations made in their choice and layout.

==== Shredder <shredder>
The Precious Plastic Shredder is a versatile tool designed to efficiently break down plastic waste into small, manageable flakes, making it easier to process and recycle into new materials. Its robust design accommodates a wide variety of plastic types, enabling the creation of sustainable, high-quality outputs from discarded items. By offering an accessible and affordable solution, the shredder empowers individuals and communities to actively engage in local recycling initiatives and foster circular economies.

#figure(
  [
  #image("../assets/images/workshop_setup/shredder.jpeg", width: 80%)
  #set align(left)
  ],
  caption: [ The Homebuilt Shredder ],
    placement: none,
)<fig:shredder>

It combines the motor and controls of a standard garden variety wood chipper (motor is strong and geared for high torque) with a robust cutting mechanism that can handle tough materials like PET bottles, PVC pipes, and more. The shredder's design allows it to be easily disassembled for cleaning and maintenance, ensuring its continued performance over time. The shredder-box is manufactured according to specs from #cite(<preciousplasticHowBuildShredder>, form: "prose")

Having a shredder for the process nevertheless enables far better storage options, since storing granulate is far easier than storing filament or failed prints.

A shredder, in this configuration is a welcome aesthetic tool, in such that it gives us control over the particle size used as inputs for the plate-pressing process, enabling greater color precision, but it is more or less optional, since most of the plastic pieces a 2kw shredder can manage are able to be melted whole in the heat-presses.

During the workshop, it was used to shred a number of PLA support structures. 


==== Hot Press <press>
In order to create sheet goods, some kind of flattening heat source is needed. 
After a bit of research into cost-effective solutions, a ribless sandwich maker was used. 
It is limited to sheets the size of A4 paper. 
Some modification might be necessary to ensure level sheets, since the pressure is only applied along the center axis, but for the first tests, this is sufficient.
It is comfortably reaching 200°C, which is enough for all plastics used in the context of the thesis. 
Some optimization could be achieved here by adding some form of Oven to keep plastic warm and enable larger batch sizes.

#figure(
  [
  #image("../assets/images/workshop_setup/pressarea.jpeg", width: 80%)
  #set align(left)
  ],
  caption: [ The Heat Press Area ],
    placement: none,
)<fig:pressarea>


==== Oven

#figure(
  [
  #image("../assets/images/archive_uploads/snap_2025-02-27_15-26-18-224.png", width: 80%)
  #set align(left)
  ],
  caption: [ The Oven,
  #link("https://archive.petau.net/#/page/Upload-2025-02-27_15%3A26%3A25")[Archive Location]
  ],
    placement: none,
)<fig:oven>

The oven was planned for a batching process, enabling larger and thicker sheet goods through preheating materials in the oven.
Workshop attendants also used it creatively for thermoforming processes, something I had not anticipated.

Despite that, the oven feels most useful for advanced processes and is one of the more optional tools in the introductory context of the workshop.


==== CNC Station <cncstation>
Thanks to the support of InKüLe, there are two Shaper origins available. These are quite specialized CNC machines, in that they allow for handheld operation, making them more-than-digital fabrication tools. They require a Vector Image to work, which can be created from multiple Sources. One of particular interest here is via Shaper Trace, a workflow where it is possible to digitize any object or sketch via taking a photo of it with a specially marked reference frame.

#figure(
  [
  #image("../assets/images/workshop_setup/cncarea.jpeg", width: 80%)
  #set align(left)
  ],
  caption: [ The CNC Cutting Station  ],
    placement: none,
)<fig:cnc>

#figure(
[
#image("/assets/images/inküle/p19.jpg", width: 80%)
#set align(left)
_Note._
Image Credits: Beril Ece Güler / InKüLe
],
caption: [
	The Shaper Origin combining digital and analogue
],
placement: none,
)<fig:p19>


==== The Post-processing Area <postprocessingarea>
For the purposes of the workshop, any process happening up until this point was structurally constrained on a unified scaffolding for all participants. Design and Research decisions could be taken, but it was generally suggested to take the provided material in granulate form, press it into plates and carve some form out of the plate either using hand-tools or the CNC (@cncstation)


This station then provides an explosion of opportunities, where one is forced structurally to already have some preconception of a final object in mind.

Post-processing then denotes any work done to an object after it has been pressed into a plate and carved.
I will now lay out some prominent options for post-processing. It would not serve the thesis purpose to make the list exhaustive here, but instead the post-processing is to be understood as an open category, inviting research not only on a design- and material level, but also inviting to gather new processual knowledge.

One example for that is a research group in the workshop examining whether melted plastic can be treated using a glass-blowing process. The result of that can be seen in @fig:mobile_example.

#figure(
  [
  #image("../assets/images/workshop_setup/postprocessingarea.jpeg", width: 80%)
  #set align(left)
  ],
  caption: [ The Post-Processing Area ],
    placement: none,
)<fig:postprocessingarea>

===== Welding Iron
For some portable soldering irons I already had, I found additional tips in knife form. This made them work effectively like a hot-knife, enabling small scale hot-plate welding and efficient plastic cutting. They also serve well for cleaning up edges of parts. A soldering iron comes designed for small and detailed work, it proved versatile and accessible for many finer tasks.

#figure(
[
#image("/assets/images/inküle/P05.jpg", width: 80%)
#set align(left)
_Note._
Here, the hot knife was explored not only as a cutting tool, but also for its plastic welding potential.
Image Credits: Beril Ece Güler / InKüLe
],
caption: [
	Using the hot knife
],
placement: none,
)<fig:P05>


===== Hot Air Gun <hotair>
The hot air guns proved incredibly useful and versatile as they provided fine-grained control and selective heat application onto parts.
Typically, the hot air gun is the tool of choice for removing strings and flakes from a CNC-cutting job, but it is potentially powerful enough to heat up entire parts and is the only tool in this context that gives the user fine control over heat application.


===== Power tools and wooden hand tools <smalltools>

====== Multi-tool
as a precaution, I had brought bunch of hand- and power tools, and the multi-tool was probably the biggest win there: It proved very apt at cutting cleanly through plastic and will be a staple tool in upcoming plastic workshops

====== Jigsaw
Way faster cuts, but far less clean




== The AutomatedArchive <AutomatedArchive>

The AutomatedArchive, integrated into the Uploadstation introduced in @uploadstation 

The design guideline for the AutomatedArchive was to be as minimally invasive as possible. 
It should not require a computer screen and not require typing out findings. 
Paper as medium was preferred, as it leaves a level of stylistic finesse not present in typed out words.

The Archive is born to capture a host of processes that typically get lost in the design and making process.
It is designed to minimize interruptions within the creative workflow.
As design constraints it was set that

		- you don't need to sit down to use it
		- you can operate it with one "start" interaction
		- it is content-agnostic: anything you hold into the camera will be documented.
		- it is as minimally prescriptive as possible: all the instructions telling you how to use it can be ignored and "hacking" the archive for creative purposes becomes possible

In the current form, the archive operates with a .config-file, where I as the admin can set several settings and switch between a few different approaches: it is possible to define the Camera to be used; in a mac environment mobile archiving via the continuum camera becomes possible.
Further, different optional analysis tools can be added to the pipeline depending on the requirements of the specific workshop.
		- Several different OCR Algorithms can be chosen:
			- EasyOCR
			- Tesseract
			- Ollama-OCR
			- mac-Framework-Vision (built with pyobjC, utilizing pyobjC-framework-Vision)

The archive is fully reachable under https://archive.petau.net

  For a similar summary in pseudocode, check @archive_pseudocode


In modern waste centers, a notebook is still the main instrument of classification. This on the one hand, shows again how technologically infeasible recycling as an industrial endeavor is, and on the other, also shows how documenting and tracing is among the most effective tools to preserve and create value in objects.
#cite(<laserSortingShreddingSmelting2020>)

I claim the AutomatedArchive is delivering a value-creation process.

TODO evidence?



#figure(
  [
#image("../assets/images/archive_uploads/snap_2025-02-27_16-49-46-495.png", width: 80%)
  #set align(left)
      _Note._
    An illustration of the Upload process.
    As camera, a modified document camera was used, which allowed for the capture of high-quality images and videos directly from hotkey on the prepared keyboard. The UploadStation was used to upload these media files into the archive system. Everything after pressing the hotkey was done automatically by the system.
  ],
  caption: [ The UploadStation in use during the workshop, showcasing the automated archive system.
  #link("https://archive.petau.net/#/page/Upload-2025-02-27_16%3A49%3A53")[Archive Location]
  ],
    placement: none,
)<fig:upload_station>


=== Back-end Description

#figure(
  [
#image("../assets/images/archive_flowchart.png", width: 90%)
  #set align(left)
      _Note._
TODO update graph (Pinry, apple vision, mobile camera)
  ],
  caption: [The archive internal workflow
  ],
    placement: none,
)<fig:archive_backend>



=== Presentation of the archive
An archive becomes only an archive once it is re-visitable and can be browsed by users.
The UploadStation, as part of the workshop, only serves in additive capacity.
To enable further interaction, connecting dots and synthesizing knowledge from it, it needs to be available publicly.

This was realized through a public website.
TODO

=== The Case for Markdown as persistent archive

For knowledge transfer and archiving, the digital is not always a net positive. Things get lost in the WWW and ever-changing digital landscapes can be frustrating for researchers or historians looking to trace the origins of ideas. No data format has really persisted since the very first days of the internet. Archiving and storage of Semantic Knowledge is a hard problem and gets harder through rapidly changing standards and platforms.
Markdown, which is around since 2004, is one of very many proposals to store Knowledge in a human readable syntax in text files. It is platform agnostic, resilient against private appropriation, efficient and hopefully, long lasting.
I would argue, that it is almost as transformative for the digital world as the email standard. Markdown is widely adopted, open for architectures to build on top, and not dogmatically enforced. Any archival system based around Markdown will be easy to store, to maintain and simply future-proof.
#cite(<gruber2004markdown>)



=== Software used for the archival process

It is not common to cite software in academic research, it usually only happens when the software is of special import to the project or the software itself is the object of research. 
The point of citations is to increase transparency over ones sources.
As this is an artistic research, and the overall argument of connected and embedded knowledge is made, herein lies an attempt at increasing transparency over the work involved. Software, frameworks and their affordances enable my work at least as much as an academic paper read. 
Therefore, a necessarily incomplete effort is made here to attribute utilized prior work.

==== Typst
Typst is a rust-based, markdown-like programming environment for Text. It fulfills many of the same needs LaTeX does. Compared against LaTeX, where I used to write academic papers in, it is orders of magnitude faster and I subjectively felt the Transition from the Markdown-format in the AutomatedArchive to be smoother to Typst than to LaTeX.
#cite(<Madje_Typst>)

==== Python
#cite(<rossumPython1991>)
Python is my programming language of choice and makes the entirety of the AutomatedArchive possible.

==== Mermaid
Mermaid is an implementation of Diagrams-as-Code. The general concept is that a diagram gets formalized in such a strict syntax that can be fully described with human-readable text. It integrates syntactically very nicely with markdown.
All schematics and diagrams in this work are publicized using Mermaid.
#cite(<Sveidqvist_Mermaid_Generate_diagrams_2014>)

==== Logseq
Logseq is a knowledge management platform that allows for the creation of non-linear notes and diagrams. It is particularly useful for organizing thoughts and ideas in a way that is both visually appealing and easy to navigate.
It is entirely textual, meaning everything is stored as markdown files.
#cite(<Logseq>)

==== openCV
openCV is a classic library for python, handling anything related to computer vision. It is used in the AutomatedArchive project to handle image processing tasks.
#cite(<OpenCV>)

==== Ollama
Ollama is a large language model handler and library. It's API permits the local use of LLMs. It is used for Image description tasks in the AutomatedArchive. It was also used in a co-creative process in writing the back-end for the AutomatedArchive
#cite(<Ollama>)

==== LLMs
Within Ollama, several LLMs were employed for different tasks, such as:
- Performing OCR and Image description:
 - Llama3.2-vision  #cite(<meta2024llama32vision>, form: "prose")
- Text and Code Completion:
 - Qwen2.5 #cite(<qwen2.5>, form: "prose")
 - LLama3.2 #cite(<meta2024llama32>, form: "prose")


==== Pinry
Pinry is a tiling image board system for people who want to save, tag, and share images. As such it is already collaborative at its core and serves as a supplement to the AutomatedArchive, providing a more comprehensive interface for users focusing only on images. It is less relational than a knowledge graph, but adds efficient upload navigation.
It was used to realize #link("https://pinry.petau.net")[pinry.petau.net].
#cite(<pinry>)



== Workshop Structure
Although the workshop was structured primarily on the practical research questions surrounding the materiality of plastics, it included the minimum viable knowledge on the plastics classes and labelling. Through this, no prior knowledge was necessary and the format opens up to anybody.
The materials presented are taken mostly from other public information campaigns on sorting plastics, but the Precious Plastic Melbourne materials #cite(<PreciousPlasticDownloadable>) stand out as being prepared quite aptly specifically for laypersons in a sorting-plastic-as-workshop format.



=== Polymer Identification

==== Polymer Subclasses

#figure(
  [
#image("../assets/images/polymer_subclasses.png", width: 80%)
  #set align(left)
      _Note._
   Sometimes one finds elastomers excluded from this overview, as they are not necessarily a polymer. It is more of a functional definition: anything that stretches, is an elastomer. It can be of thermoplastic origin, then it is a thermoplastic elastomer (TPE), but it can be another class altogether, much like vegetables do scientifically speaking not really exist. TODO proof?
  ],
  caption: [ The three subclasses of polymers
  #cite(<katzIdentificationPolymers1998>) #cite(<AcademyPreciousPlastica>)
  ],
    placement: none,
)<fig:polymer_subclasses>


#figure(
[
#image("../assets/images/polymer_classification_options.png", width: 80%)
#set align(left)
_Note._
Polymers are a complex and large family. They can be classified along several dimensions, here are some common distinguishers used in research and industry
#cite(<thangaduraiPOLYMERNANOCOMPOSITESENERGY2023>) #cite(<oraonOrganicPolymersEnergyenvironmental2025>).
],
caption: [
	Different ways to classify polymers
],
placement: none,
)<fig:polymer_classification_options>




==== Thermoplastics Subclasses
#figure(
  [
#image("../assets/images/thermoplastics_subclasses.png", width: 100%)
  #set align(left)
      _Note._
   While this overview cannot be exhaustive, since there are hundreds of subclasses, and it is a little futile to keep track of novel materials that producers come up with every time they need slightly tweaked properties and adjust the additives and formulations, this list represents the 7 internationally recognized broad categories that many countries regulate in recycling programs. #cite(<SPI1988>) #cite(<ASTM2019>)
  ],
  caption: [ The commonly identified subclasses of the thermoplastics
  #cite(<katzIdentificationPolymers1998>) #cite(<AcademyPreciousPlastica>)
  ],
    placement: none,
)<fig:thermoplastics_subclasses>


#figure(
  [
  #image("../assets/images/polymer_id_tree.png", width: 80%)
  #set align(left)
      _Note._
    Polymers Identification is generally a hard problem. On a surface level, for artistic purposes, a few simple density tests are enough. This is a decision tree that found its way into many basic chemistry classrooms.
  ],
  caption: [ A standard decision tree for identifying common polymer classes.
  #cite(<katzIdentificationPolymers1998>)
  ],
    placement: none,
)<fig:polymer_id_tree>



For the purposes of the workshop, I had prepared only density tests; with water, alcohol and


#table(
  columns: 5,
  align: (left, center, center, center, center),
  table.header[*Floats on*][*Alcohol*][*Vegetable Oil*][*Water*][*Glycerin*],

  [PET], [No], [No], [No], [No],
  [HDPE], [No], [No], [Yes], [Yes],
  [PVC], [No], [No], [No], [No],
  [LDPE], [Yes], [No], [Yes], [Yes],
  [PP], [Yes], [Yes], [Yes], [Yes],
  [PS], [No], [No], [No], [Yes],
)
TODO Check

#cite(<PreciousPlasticDownloadable>)

==== Visual properties
#table(
  columns: 4,
  align: (left, left, left, left),
  table.header[*Type & Name*][*Properties*][*Common Use*][*Burning*],

  [PET (Polyethylene Terephthalate)],
  [Clear, tough, solvent-resistant, barrier to gas and moisture, softens at 80°C],
  [Soft drink, water bottles, salad domes, biscuit trays, food containers],
  [Yellow flame, little smoke],

  [HDPE (High-Density Polyethylene)],
  [Hard to semi-flexible, resistant to chemicals and moisture, waxy surface, softens at 75°C],
  [Shopping bags, freezer bags, milk bottles, juice bottles, ice cream containers, shampoo bottles, crates],
  [Difficult to ignite, smells like candle],

  [PVC (Polyvinyl Chloride)],
  [Strong, tough, can be clear and solvent-resistant, softens at 60°C],
  [Cosmetic containers, electrical conduit, plumbing pipes, blister packs, roof sheeting, garden hose],
  [Yellow flame, green spurts],

  [LDPE (Low-Density Polyethylene)],
  [Soft, flexible, waxy surface, scratches easily, softens at 70°C],
  [Cling wrap, garbage bags, squeeze bottles, refuse bags, mulch film],
  [Difficult to ignite, smells like candle],

  [PP (Polypropylene)],
  [Hard but still flexible, waxy surface, translucent, withstands solvents, softens at 140°C],
  [Bottles, ice cream tubes, straws, flower pots, dishes, garden furniture, food containers],
  [Blue yellow tipped flame],

  [PS (Polystyrene)],
  [Clear, glassy, opaque, semi-tough, softens at 95°C],
  [CD cases, plastic cutlery, imitation glass, foamed meat trays, brittle toys],
  [Dense smoke],

  [OTHER (All Other Plastics)],
  [Properties depend on the type of plastic],
  [Automotive, electronics, packaging],
  [All other plastics]
)
TODO check
#cite(<PreciousPlasticDownloadable>) TODO



TODO Description

=== The Participants
the workshop was advertised by InKüLe and through that reached students all over the UdK. I did not know the Majority of the participants beforehand.
12 People booked the Workshop and 9 showed up for it, along with Members of InKüle joining.


=== Workshop Timeline

==== Workshop Overview
A two-day hands-on exploration of plastics, their properties, and transformation techniques. Participants engaged in material studies, documentation, and reflection.

==== Summary of Events
On the first day, the workshop began with introductions, where participants shared their backgrounds and expectations. A theoretical session followed, covering types of plastics, their identification, and recycling. Participants were then introduced to the machines used for material processing and documentation through the digital archive. Hands-on activities included creating ID markers, experimenting with material properties, and initial explorations of plastic manipulation techniques. The day concluded with a reflection session where participants shared their findings and outlined their plans for further experimentation.

The second day started with a recap and discussion of the previous day's activities. Participants engaged in extended free work time, allowing for deeper material studies. An interim check-in facilitated knowledge sharing before continuing explorations. The final phase of the workshop included group reflections, gallery walks showcasing work, and a plenary discussion on insights gained. The event concluded with participant feedback and an evaluation of the workshop's impact.


==== Program Day 1
#table(
  columns: 2,
  align: left,
  table.header[*Program Day 1*][*Duration (180 Min)*],
  [Who are we?], [20 min],
  [Theory Block], [20 min],
  [Machine Introduction], [20 min],
  [The Archive], [10 min],
  [--- BREAK --- ], [],
  [Making your first ID Marker], [20 min],
  [Uploading first Post with ID Marker], [10 min],
  [The Infrastructure: what can we explore?], [20 min],
  [First Material Explorations], [30 min],
  [Reflection: what are Findings and Plans?], [30 min],
  [Clean Up], [10 min],
)

==== Program Day 2
#table(
  columns: 2,
  align: left,
  table.header[*Program Day 2*][*Duration (180 Min)*],

  [Recap, Questions], [20 min],
  [Free Work time on Material Study], [60 min],
  [Interim Check-In], [15 min],
  [--- BREAK --- ], [],
  [Free Work time on Material Study], [60 min],
  [Group Reflections: Final uploads], [15 min],
  [Gallery Walk], [20 min],
  [Plenary reflection with archive], [20 min],
  [Feedback on Workshop], [],
)

=== The Research Groups
- *Color Patterns*
- *Connections and Welding*
- *Thermoforming*
- *Surfaces*

==== Color Patterns

Can we influence the color mixing?
How to mix them? How to layer them?
Twist them? Fold them?
Can we mix materials?
What influence does temperature have on color?
Can we overcook, undercook?
Transparency, translucency?

==== Connections and Welding

Welding: What creates the strongest welds?
Can they be reinforced? Can they be invisible?
Can we create pin connectors?
Other, non-welded joint techniques?
How could we do hinges?
Can we sew plastic?

==== Thermoforming

Could we do slumping? (Melting into a specific shape)
Can we imprint or emboss details while hot?
How can we bend the material?
Are there material differences?
What can be done with elongation?
Can we make it melt until liquid?

==== Surfaces

What are ways to create regular or irregular patterns?
Can we stamp patterns?
How about inlays?
Plastic into other materials?
Other into plastic?
Inscriptions or engravings?


These were the initial prompts for the participants, but they were repeatedly instructed to take the opportunity and pursue their own interest in plastics.


== Participant Outcomes and their Insights

What did the participants find?

TODO Expand with examples and start to find temporal progressions

One example for each group?

What differences can be found between day one and two?


#figure(
  [
  #image("../assets/images/workshop_setup/results.jpeg", width: 80%)
  #set align(left)
  _Note._
  In a few plenary sessions in between the research blocks, participants were asked to share some aspects of what they are currently exploring. Afterwards, finished experiments went on display here.
  ],
  caption: [ Some results from the experiments ],
    placement: none,
)<fig:results>



#figure(
  [
    #table(
  columns: 2,
  [#image("../assets/images/archive_uploads/snap_2025-02-26_18-14-30-253.png", width: 94%)],
  [#image("../assets/images/archive_uploads/snap_2025-02-26_18-15-13-938.png", width: 100%)],
)
  #set align(left)
      _Note._
Here, the Workshop participants explored ways to form a sheet of plastic to a hand shape.
As can be deducted from the markers, that was done with a variety of tooling, notably trying out the heat-resistant silicone gloves, using them under the heat guns to obtain real forms of the hand.
  ],
  caption: [ A result from a group researching thermoforming processes
  #link("https://archive.petau.net/#/page/Upload-2025-02-26_18%3A14%3A41")[Archive Location]
  ],
    placement: none,
)<fig:hand_bacon>

#figure(
  [
#image("../assets/images/archive_uploads/snap_2025-02-27_18-49-01-374.png", width: 80%)
  #set align(left)
      _Note._
A participant used the CNC options to create a smartphone stand from multiple fabricated sheets of plastic. as seen in the documentation of it, PLA and PET was used here, two especially strong materials that delivered good results while being cut. The Connections and joints are reminiscent of typical laser cut connections.\
  #link("https://archive.petau.net/#/page/Upload-2025-02-27_18%3A49%3A08")[Archive Location]
  ],
  caption: [ A result from a group researching connections
  ],
    placement: none,
)<fig:phone_stand>


#figure(
  [
#image("../assets/images/archive_uploads/snap_2025-02-27_15-23-25-655.png", width: 80%)
  #set align(left)
      _Note._
Results from a group examining thermoforming properties of different plastic types.
This piece was from some leftover foodstuffs box tops, that was then successfully identified using density testing methods supplied in the workshop and shaped with the heat gun and a water bath.
\
 #link("https://archive.petau.net/#/page/Upload-2025-02-27_15%3A23%3A32")[Archive Location]
  ],
  caption: [ An eye mask from Tupperware],
    placement: none,
)<fig:eye_mask>

There were several instances where participants successfully broke down the boundaries proposed by the presented infrastructure: The Thermoforming group decided early on that they needed an efficient way to cool the Pieces and created a water bath, which proved effective in "freezing" objects in their heated shape, which they would have lost if slowly melting.

Another instance was the trials with glass blowing, where the steel tubes provided were utilized as air-conductors.
I had positioned them there, thinking people might want to explore composite-material adherence techniques proposed earlier and weld steel or wood through compressive shrinkage of the plastics. that never happened. Instead the Tubes were recognized as a tool, not only in that context but also for handling purposes.

In many other instances, participants seemed to agree to the proposed research questions and adopted them.


For a full overview of the Findings, please refer to the still present online repository visible under #link("https://pinry.petau.net")[Pinry] and #link("https://archive.petau.net")[Archive].
