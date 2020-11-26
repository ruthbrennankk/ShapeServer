# Shape Server

### Assignment Specification
In this project you will create a drawing eDSL (you can take your design from the Shape language we used in the lectures, or from the Pan language, or both). You will combine it with the two web eDSL languages we saw (Scotty and Blaze) to produce a web application capable of delivering images. The web app does not need to be interactive (that is, the images can be hard-coded in the app), the point is to create a DSL that could be used to specify images

You can use the JuicyPixels library to create the images (you will receive sample code for this. The library can serve as an almost drop-in replacement for the Ascii rendering layer in the example code, though there are also more efficient ways to make use of it).

This project is overall worth 25% (the second project will be worth 35%). The project is due in at midnight on Friday November 27th (that’s 5 weeks from the day of release). Any extensions must be agreed in advance, in writing.

The project tasks, in detail, are:

1. Design a suitable drawing eDSL (either by extending the the Shape, from scratch).
    * Provide at least the following basic shapes: Circle, Rectangle, Ellipse, Polygon (this last should be a closed convex polygon defined by a series of points).
    * Provide the following set of basic transformations: Scale, Rotate, Translate, and functions to combine them with shapes to produce drawings (note: you don’t have to preserve the design of the original Shape language where these are maintained as a simple list of tuples).
    * Provide a way to specify colour for each shape. This can be either a simple case with a single colour, or a function which can provide gradients.
    * Finally, provide a way to mask images so that when one is overlaid with another the user can specify which one is seen. This can either be a simple boolean mask that allows only one image to show through, or a more sophisticated blending function that specifies how much each image contributes to each pixel.
2. As a UI provide a Scotty application which can render some (hard-coded) sample images that demonstrate the result. The images should be returned as PNG graphics rendered using JuicyPixels. You should include the text of the DSL program that produced the image in the web page, so that the user of the web app can see how the image was produced (the idea is that a future improvement could be to allow the user to edit this text and re-render it.
3. Finally, implement at least one optimisation to the DSL program that is run before it is rendered. This could be ensuring that a shape that cannot be seen (because it is behind another shape that masks it off, for example) is removed from the drawing prior to rendering, or it could be that transformations are optimised (for example, multiple translations could be merged), or something else.

Submit
* Your final program as a stack project, including all the source files needed to build and run it.
* A short document (text or PDF) outlining the design choices you made, and indicating how many of the project deliverables were satisfactorily completed. Include also a short (about a paragraph) reflection on the process of designing the DSL; some questions you might address include: did you find the design choices you had to make challenging? At any point did you have to revise your language design? How well did your choices fit with the needs to the rendering library chosen, and how might they have changed if the final rendering target was instead an SVG produced by Blaze?

### Solution Details

1. Suitable eDSL
I choose to extend the Shape language detailed in class
    * Provide basic shapes
        * Circle - 
        * Rectangle - 
        * Ellipse - 
        * Polygon - 
