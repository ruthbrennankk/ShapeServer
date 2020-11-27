
### Solution Details

1. Suitable eDSL
I choose to extend the Shape language detailed in class

    * Provide basic shapes
        All of the shapes are created using the shape data type. 
        * Circle/Ellipse - Circle and Ellipse can both be created using the Circle instance of Shape. A circle is an ellipse scaled with the same number for x and y.
        * Square/Rectangle - These are both created using the Square instance of Shape. Rectangle is a square scaled with different values of x and y.
        * Polygon - Polygon is an instance of shape that also has an array of points attached to it. 
        Rendering the shapes involved checking if a point was inside a drawing. To add the polygon functionality to the existing functionality for square and circle, I had the following considerations.
        The problem was to determine if a point (px, py) was inside or outside of a 2D polygon. I considered a polygon to be made up of N vertices (xi, yi) where 0 <= i <= N. The last vertex (xN, yN) is assumed to be the same as the first vertex, ie the polygon is closed.
        To determine if the point is inside or outside I counted the number of times a ray that emanates horizontally from the point (px, py) intersects the line segements that make up the polygon. If the number of intersections is even then the point is outside the polygon, if it is odd then the point is inside.
        The function that implements this functionality in my code is countEdges and it is in the Shapes module.
        
    * Provide set of basic transformations
        To achieve this I maintained the transform function and data type as adapting Shape to contain Polygon enabled these to still work for all types of Shapes.
        The only change to this was to merge consecutive translations into one translation. Because translate (point 10 10) <+> translate (point 5 7) is the same as translate (point 15 17). This meant that composition of two translations does not require one translation to be applied to the other and can be optimised to instead be one translation that takes the sum of the xs and the sum of the ys as a vector to be a parameter.
        Unideally this approach to optimisation requires all translations to be given consecutively.
    
    * Provide a way to specify colour for each shape & provide a way to mask images so that when one is overlaid with another the user can specify which one is seen
        Both of these are implemented in the same function. I adapted the given render function to fit the new project requirements. This adaptation is called RenderC. 
        This function takes a filepath, a drawing, a window and an array of integers. The array of integers is a list of colour codes.
        ```
      Colour Options with Codes (RGB)
        1. Pink - 255 51 249
        2. Blue - 51 113 255
        3. Orange - 255 190 51
        4. Purple - 165 51 255
        5. Yellow - 255 255 51
      ```
      The first element in the array would correspond to the colour of the first shape to be drawn, the second code to the second shape to be drawn. If too many codes are passed to the function the extra are ignored. If too few codes are passed then the shapes that do not have colours specified are coloured white.
      Also if a colour code is invalid then the shape will be white. This is useful because the order the shapes are listed in the drawing is important for overlaying images. So if you have three shapes and you want the first to be pink, the second to be white and the third to be yellow you would pass the array [1,0,5]
      The user specifies the shape they want to be overlaid to all the other shapes first in the list of shapes in a drawing. For example:
      ```
      If we have the drawing  = [(scale (point 0.1 0.1) <+> translate (point 10 45), square), (scale (point 0.25 0.25) <+> translate (point 10 15), circle), (scale (point 0.4 0.1) <+> translate (point 10 25), square), (scale (point 0.25 0.25), polygon [(point 1 1),(point 1 3),(point 2 4), (point 3 3), (point 3 1), (point 1 1)])]
      Then the square sits over the circle which sits over the pentagon.
      ```
      This was achieved using a function that checked which shape a point was inside in a drawing called insideShape. Inside shape loops through the shapes in a drawing starting with the first shape and checks using insides if the point is contained in the shape. As soon as it finds a shape it retuns the index of that shape which corresponds to it's colour code so then that pixel is coloured corresponding to that colour code.

2. As a UI provide a Scotty application which can render some (hard-coded) sample images that demonstrate the result. The images should be returned as PNG graphics rendered using JuicyPixels. You should include the text of the DSL program that produced the image in the web page, so that the user of the web app can see how the image was produced (the idea is that a future improvement could be to allow the user to edit this text and re-render it.
    I used scotty and blaze to render a few pages corresponding to various examples that I think highlight the main aspects of my attempt at the assignment.
    
    * All the Shapes - This is a rendering of a pentagon, square, rectangle, circle and ellipse to demonstrate the ability of the project to render all of the shapes specified.
    * Just Circles - Just circles served to highlight that the first shape specifed is the one shown in the rendering if two shaped are in the same location and also what happens when there are not enough colour codes all of the shapes.
    * Dodecagon - This is a rendering of a dodecagon to show that my polygon shape can take a long list of points and still render the shape.
    * Overlap - This was to show that shapes can be rendered overlapping on each other.
    * Translate - This demonstrates multiple translations applied to the same shape.
    
    All of these image locations and descriptions are hardcoded (in Main.hs).
    For clarity I set up the application to function like a website. There is a landing page with all of the availible rendering descriptions with a hyperlink that takes you to a page that has the image, code and a title. 

    One major blocker was the displaying of the rendered images, that were housed locally, on the web application. Chrome gave me an error "cannot access local resource" -- (Cannot open local file - Chrome: Not allowed to load local resource). 
    I don't think this was a problem with my application, I think it was a setting on either my computer or chrome account. Despite my best efforts, I wasn't able to find and change this setting so I patched the problem instead.
    I used a http-server to host the src folder (which contained the images) on port 8080 and referenced that location in my html code in order to retrieve the images.
    This enabled me to access the image rendered in the same run as the current server and made displaying the images very quick. 
    
    The setup and running of the server was a simple three step process : 
    
        1) INSTALLATION : Open terminal and type
        npm install -g http-server
    
        2) RUNNING : Go to the root folder that you want to serve you files and type:
        http-server ./
    
        3) REFERENCING : Read the output of the terminal
        Example: url('http://localhost:8080/foo.png');
        
    This means that when running the project this server also has to be running for images to be accessed. I made a demo of how it runs on my machine linked [here](https://youtu.be/qQLF3WZzKBk).

##### Reflection

Did you find the design choices you had to make challenging? At any point did you have to revise your language design? 
I enjoyed the challenge of rendering a polygon. I stayed true to the Shape data type as is and doing so meant that I needed to create a function that checked if a point was inside the polygon.
Initally to check if a point was inside a polygon I computed the sum of the angles made between the test point and each 
pair or points making up the polygon. If this sum was 2*pi then the point was inside or if it was 0 then the point was outside. 
I revised this method in favour of the ray method as this was unnessesarily long given that I had to calculate each angle.

How might they have changed if the final rendering target was instead an SVG produced by Blaze?
Since Blaze SVG is a scalable vector graphics and html combination library, I wouldn't have needed to use and extend the Shape eDSL as I would have been able to generate for example rectangles using a simpler function : 
svgDoc :: S.Svg
svgDoc = S.docTypeSvg ! A.version "1.1" ! A.width "150" ! A.height "100" ! A.viewbox "0 0 3 2" $ do
    S.rect ! A.width "1" ! A.height "2" ! A.fill "#008d46"
    S.rect ! A.width "1" ! A.height "2" ! A.fill "#ffffff"
    S.rect ! A.width "1" ! A.height "2" ! A.fill "#d2232c"

