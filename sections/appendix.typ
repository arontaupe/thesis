== Acknowledgements <acknowledgements>

TODO doublecheck

I am deeply grateful to my supervisors, Maria Kyrou and Prof. Albert Lang, for their invaluable guidance and support throughout this project. Their expertise and encouragement have been instrumental in shaping my research and practice.

My sincere thanks also go to Franz and the InKüLe team for their technical assistance and insightful contributions, which greatly enriched this work.

I am equally appreciative of the participants of the ReShaping Plastics workshop, whose enthusiasm and creativity inspired me to explore new possibilities in recycling and design.

Many thanks also to the team and the pupils at the Gabriele-von-Bülow Gymnasium, for letting me combine the research with the practical and learning to co-create together with me.

Lastly, I extend my heartfelt gratitude to my family and friends for their unwavering encouragement and belief in my work. Their support has been indispensable in bringing this thesis to fruition.

==== The Archive in Pseudocode <archive_pseudocode>

TODO update

  ```python
# Capture image from webcam
def capture_image():
    open_webcam()
    capture_frame()
    save_image()

# Extract text from image
def extract_text(image):
    text1 = tesseract_ocr(image)
    text2 = easyocr_ocr(image)
    merged_text = combine_texts(text1, text2)
    return merged_text

# Generate image description using AI model
def generate_description(image):
    return ollama_vision(image)

# Detect markers in the image using SIFT feature matching
def detect_markers(image):
    return sift_feature_matching(image)

# Check if text is readable and meaningful
def is_text_readable(text):
    return textstat_readability_check(text)

# Upload extracted text and image to Logseq
def upload_to_logseq(text, image, annotated_image):
    if is_text_readable(text):
        logseq_upload_text(text)
        logseq_upload_asset(image)
        logseq_upload_annotated_image(annotated_image)

# Main pipeline
def main():
    image = capture_image()
    text = extract_text(image)
    description = generate_description(image)
    markers = detect_markers(image)

    if markers:
        annotated_image = annotate_image(image, markers)
    else:
        annotated_image = image

    upload_to_logseq(text, image, annotated_image)

# Execute script
if __name__ == "__main__":
    main()
 ```


//= List of Figures
//#outline(
//  title: none,
//  target: figure.where(kind: image),
//)

//= List of Tables
//#outline(
//  title: none,
//  target: figure.where(kind: table),
///)

=== Workshop Documentation

#figure(
[
#image("/assets/images/inküle/P04.jpg", width: 80%)
#set align(left)
_Note._
To cut with the CNC machine, some paper templates were prepared to enable free-hand drawing that could later be scanned in using a function called shaper trace. The participant group decided they wanted a set of rings cut from a single plate and tried out various analogue and digital methods to achieve the best shape.  \
Image Credits: Beril Ece Güler / InKüLe
],
caption: [
	Participants improvising tools not provided
],
placement: none,
)<fig:P04>


#figure(
[
#image("../assets/images/archive_uploads/snap_2025-02-27_17-18-37-171.png", width: 80%)
#set align(left)
_Note._
The cut out rings visible in @fig:P04 were then sanded down.  \
#link("https://archive.petau.net/#/page/Upload-2025-02-27_17%3A18%3A45")[Archive Location]
],
caption: [
	Sanding Plastic
],
placement: none,
)<fig:snap_2025-02-27_17-18-37-171>


#figure(
[
#image("../assets/images/archive_uploads/snap_2025-02-27_17-59-06-370.png", width: 80%)
#set align(left)
_Note._
The rings from @fig:snap_2025-02-27_17-18-37-171 were then assembled in a 3D-structure using strings to form a sculpture.  \
#link("https://archive.petau.net/#/page/Upload-2025-02-27_17%3A59%3A12")[Archive Location]
],
caption: [
	Sanding Plastic
],
placement: none,
)<fig:snap_2025-02-27_17-59-06-370>


#figure(
[
#image("/assets/images/inküle/P07.jpg", width: 80%)
#set align(left)
_Note._
Experientially, Participant groups developed their own strategies with set goals: here, it was tested how using a non-pressurized mold can be used for shaping purposes. When to use heat protection and when to rely on sensory accuracy was in their discretion.
 \
Image Credits: Beril Ece Güler / InKüLe
],
caption: [
	The thermoforming group collaborating in experimental setups
],
placement: none,
)<fig:P07>


#figure(
[
#image("/assets/images/inküle/p26.jpg", width: 80%)
#set align(left)
_Note._
Image Credits: Beril Ece Güler / InKüLe
],
caption: [
	Implicit zoning through a prepared table configuration
],
placement: none,
)<fig:p26>


#figure(
[
#image("/assets/images/inküle/p20.jpg", width: 80%)
#set align(left)
_Note._
An important learning that often cannot be transported through explanations: creative productive problems often have a host of solutions, and it is easy to fall into the _"Tool Trap"_, where the availability of a tool dictates the solution.
Sometimes a hole saw produces circles more efficiently than a CNC. \
Image Credits: Beril Ece Güler / InKüLe
],
caption: [
	Hole-saw as a satisfying tool for plastics
],
placement: none,
)<fig:p20>

#figure(
[
#image("/assets/images/inküle/p21.jpg", width: 80%)
#set align(left)
_Note._
The Participants used paper cups to aid in sizing their plates and could gather first-hand experience on the heat-fusing process evident in the color swirls \
Image Credits: Beril Ece Güler / InKüLe
],
caption: [
	First Contact: Making little colorful plates used as Identification markers
],
placement: none,
)<fig:p21>


#figure(
[
#image("/assets/images/inküle/p17.jpg", width: 80%)
#set align(left)
_Note._
A Pyramid served as the first test in scoping whether sewing Plastics is a feasible option for flexible hinges. Combining different materials and properties in a reversible way is a skill the industry lacks. Many recycling steps can majorly benefit from adjustments made in the design phase. Think of the multilayered Tetra Pak used in packaging, versus the first yoghurt packages where the paper can be stripped tool-free. \
Image Credits: Beril Ece Güler / InKüLe
],
caption: [
	Plates connected with Fishing Line (Nylon) to form 3D Structures
],
placement: none,
)<fig:p17>



== The Exposé of Workshop 1

#quote(attribution: link("https://www.udk-berlin.de/universitaet/online-lehre-an-der-universitaet-der-kuenste-berlin/inkuele/immaterialities-reshaping-plastic/")[InKüLe Immaterialities Reshaping Plastic Call], quotes: true, [This hands-on workshop invites participants to actively address plastic pollution by transforming waste into durable, meaningful objects. Unlike traditional industrial recycling, which often prioritizes economic over ecological concerns, this workshop empowers individuals to reclaim and re-purpose plastic in a way that fosters creativity, sustainability, and personal agency.
The workshop unfolds in two sessions. 
In the first, participants will sort, wash, and shred plastic waste using a Precious Plastic Shredder, creating small flakes. 
These flakes will then be heated in a panini press, transforming them into a malleable plastic mass, which will be molded using a DIY plastic sheet press. 
The resulting sheets will be finished with woodworking tools, and participants can add personal engravings with a CNC machine, allowing for unique, patterned designs.
The final products, shaped through a combination of heat, pressure, and craftsmanship, will reflect the individual designs and creativity of each participant. 
Whether through engraving or coloring, participants will gain hands-on experience with the potential of up-cycling plastic waste into functional, aesthetic objects.
This workshop offers a tangible way to engage with the global issue of plastic pollution, encouraging participants to reconsider the life cycle of everyday materials. 
It is a way of reformulating transient objects into durable/lasting objects, an alchemical formula for design.])

=== Full transcript of participant feedback Workshop 1 <feedback_transcript>

Prompted Questions:
- give feedback on the workshop and its structure.
- has your perception towards plastic changed in any way?
- what are your main takeaways?

---

Plastic and oil are like big enemies when you talk about pollution. But now we can easily see that new things can be made out of old things, which is really nice. I think we played around with so many things, and it was great to experiment with everything, even though there wasn't one final product in the end.

I think that was really good because, at least for me, in the beginning, I was thinking about which product to make. It was nice that we had research groups, so we weren’t focusing on the final product but more on the process—on finding something out. That was really nice because it led to more experiments. It was more about discovering new things instead of just trying to achieve something.

I love plastic now after the workshop.

I showed this already, but this one I did with a welding iron was actually very easy. It’s made of 3D-printed plates, which are very easily connectable and pretty stable. I just touched it with the iron on the side where the pieces meet for a few seconds, and it became very strong. It’s a bit like glue, actually, so that was very interesting.

PLA is really nice to work with. It was interesting to see. If there were more tools—like that Trichter thing—I think I would like to experiment more with it. But yeah, I forgot the name again... Spritzguss! Ah, Injection Molding.

I got some of the materials from a place in Moabit. I don’t have Instagram, but maybe you can see it here. It’s a community workshop that anyone can visit, and they have way cooler tools than I do. They have, for example, an injection molding machine, which is basically a stamp that presses down with a huge amount of force. You put plastic in, it melts, and comes out of a nozzle into a hollow aluminum block. They can make beams, which is something I can’t do yet.

If you got motivated, feel free to check them out. I discovered them two weeks ago, and especially the beam press transformed my options. I’m really thinking of doing more with beams because they are structural—you can make furniture, outdoor sculptures, really strong and stable stuff—and they’re super fast to produce. The place is called Wertstatt Moabit.

They work on a donation basis, so you just go there. If Moabit is far for you, there’s also the Precious Plastic network. Maybe you’ve heard of them? They’re internationally quite big, and they have a map with workspaces, machine builders, community points, and collection points. If you have a lot of nice trash or need some, this is a great resource to check out.

I’ve been experimenting with spheres for years, sometimes big, sometimes small. I love how they are such a cool 3D object that you can make out of 2D rings. I was inspired by everyone here because I was working with plastic for the first time. It takes time to bring ideas to life, especially when they’re objects, and I really appreciated how many people helped me along the way—explaining how to use the drill, the printer, and how to assemble it. It was a real group effort, and I loved that.

I also really enjoyed the documentation moments. When you're deep in the making process, you forget to reflect on the material. The documentation process gives you a little time to do that.

Plastic is fun to work with, but I also feel unsure about it. On one hand, it’s empowering—we can make things out of waste—but on the other, are we just producing more plastic in the end? We didn’t really solve the problem; plastic isn’t digestible. Are we encouraging more plastic production? That’s a question I’ve been thinking about.

Initially, I wanted a final product to come out of this workshop. I thought it needed to be functional to have value, and I spent months stuck on what that product could be. But eventually, I realized that anything we do here affirms the system we're in. The plastic isn’t going away—it’s not shrinking—so we might as well use it.

It’s like the leather jacket debate. If they already exist, is it okay to wear them? Or does that just make wearing leather cool again? The same goes for 3D printing. We use a lot of plastic, and even if we think we can always remake things, is that really sustainable? There’s no clear answer, but it’s something to consider.

I also liked that there was no pressure to create one specific product. Instead, people explored different research topics, which was really fun. Maybe we struggle to come up with a product because we already have so many. Maybe we don’t need to make more. There’s so much plastic and so many products already that it’s hard to justify adding another one.

It was also eye-opening to realize that recycling costs—energy, money, material loss. Some plastic gets mixed with wood and becomes unusable. If it’s too thick, you have to discard some. You always lose something in the process.

I really liked how open the workshop was. We had so much time to just experiment with different plastics. For me, it was about understanding plastic better—how malleable or not it is. I had many plans, but none of them turned out as expected.

I tried molding plastic onto a bottle in the oven, but it just sagged on both sides. But that’s okay—it was great to just play around with all the tools and machines and see what happens.

I was trying to make a phone stand, mostly to explore the materials. This one is the toxic one—it should be known forever as "the toxic one." It’s really strong, almost like acrylic. I was working with the theme of connections, and I wanted to make something functional. I just need to drill one last hole, and it’s done!

I first tried using a thinner piece, but it bent too much, so it didn’t work. PLA is better for this.

I liked that the workshop was two days. The first day was for exploring, and by the second day, I had a clearer idea of what I wanted to make. The documentation part was also great.

I also just printed something random to impress myself—to see what happens. Plastic is always here; in the future, it’ll still be here. Modern fossils.

I was thinking about making small plastic pieces into jewelry, like connecting different shapes. Have you seen that arm piece with multiple plates?

I like this one—it has a nice texture. If you scratch off the wood chips, you can throw it back in. If you really want to help, pull off the tape, too.

Thanks for all the input!

If there’s nothing else to share, I’d say we can officially wrap up. If you want to stick around and finish your last steps, feel free—I'm still here for a bit. If you’d like to help clean up, that’s also appreciated.

This is part of a series, so there will be more workshops. The same channels apply. Next time, I’ll try to adapt this workshop for a school, and maybe iteration three will be back here again.

Thank you all!



