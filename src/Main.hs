{-# LANGUAGE OverloadedStrings #-}

module Main where

-- Shapes Imports
import Shapes
import Render (render,renderC,defaultWindow,samples,myWindow)
import Examples (renderAllTheShapes,renderJustCircles,renderDodecagon,renderOverlap,renderDoubleTransform)
-- Scotty and Blaze imports
import Data.Text.Lazy
import Web.Scotty
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html.Renderer.Text as R


main = do
    putStrLn "Starting Server..."
    renderAllTheShapes
    renderJustCircles
    renderDodecagon
    renderOverlap
    renderDoubleTransform
    scotty 3000 $ do
        get "/" $ do
             html $ R.renderHtml $ do
                      H.h1 "Welcome to my landing page!"
                      H.h2 "Shape Server - Ruth Brennan - 17329846"
                      H.h1 ""
                      H.h3 "Instructions"
                      H.p "Use the url extensions below to access the pages with the detailed images and the text used to generate them"
                      H.h5 ""
                      H.h5 "All the shapes"
                      H.a "To the shapes!" H.! A.href "http://localhost:3000/alltheshapes"
                      H.p "This is a rendering of a pentagon, square, rectangle, circle and ellipse to demonstrate the ability of the project to render all of the shapes specified in various colours"
                      H.h5 "Just Circles"
                      H.a "To the circles!" H.! A.href "http://localhost:3000/justcircles"
                      H.p "Just circles serves to highlight that the first shape specifed is the one shown in the rendering if two shaped are in the same location and also what happens when there are not enough colour codes all of the shapes."
                      H.h5 "Dodecagon!"
                      H.a "To the dodecagon!" H.! A.href "http://localhost:3000/dodecagon"
                      H.p "This is a rendering of a dodecagon to show that my polygon shape can take a long list of points and still render the shape."
                      H.h5 "Overlap!"
                      H.a "To the overlap!" H.! A.href "http://localhost:3000/overlap"
                      H.p "This was to show that shapes can be rendered overlapping on each other."
                      H.h5 "Double Translate!"
                      H.a "To the Translates!" H.! A.href "http://localhost:3000/translate"
                      H.p "This demonstrates multiple translations applied to the same shape."

        get "/alltheshapes" $ do
             html $ R.renderHtml $ pageSetup "All the Shapes!" "http://localhost:8080/images/allTheShapes.png" "renderC src/images/allTheShapes.png cusWindow allShapesDrawing [1,2,3,4,5]" "allShapesDrawing = [(scale (point 0.25 0.25) <+> translate (point 3 5), polygon [(point 1 1),(point 1 3),(point 2 4), (point 3 3), (point 3 1), (point 1 1)]), (scale (point 0.1 0.1) <+> translate (point 10 45), square), (scale (point 0.25 0.25) <+> translate (point 10 15), circle), (scale (point 0.5 0.1) <+> translate (point 4.3 5), circle), (scale (point 0.4 0.1) <+> translate (point 10 25), square)]"
                      
        get "/justcircles" $ do
             html $ R.renderHtml $ pageSetup "Just Circles!" "http://localhost:8080/images/justCircles.png" "renderC src/images/justCircles.png cusWindow justCirclesDrawing [1,2]" "justCirclesDrawing = [(scale (point 0.1 0.1) <+> translate (point 10 10), circle), (scale (point 0.1 0.1) <+> translate (point 45 45), circle), (scale (point 0.1 0.1) <+> translate (point 10 45), circle), (scale (point 0.1 0.1) <+> translate (point 10 45), circle)]"
                             
        get "/dodecagon" $ do
             html $ R.renderHtml $ pageSetup "Dodecagon!" "http://localhost:8080/images/dodecagon.png" "renderC src/images/dodecagon.png cusWindow dodecagonDrawing [2,1,3,4,5]" "dodecagonDrawing = [(scale (point 0.25 0.25) <+> translate (point 3 6), polygon [(point 0 5),(point 1 6),(point 3 7), (point 5 7), (point 7 6), (point 8 4), (point 7 1), (point 5 1),(point 5 3), (point 4 4), (point 3 1), (point 1 2), (point 1 4), (point 0 5)])]"
             
        get "/overlap" $ do
             html $ R.renderHtml $ pageSetup "Overlap!" "http://localhost:8080/images/overlap.png" "renderC src/images/overlap.png cusWindow overlapDrawing [5,4,3,2,1]" "overlapDrawing = [(scale (point 0.75 0.75) <+> translate (point 3 5) <+> rotate 180.0 , polygon [(point 1 1),(point 1 3),(point 2 4), (point 3 3), (point 3 1), (point 1 1)]), (scale (point 0.5 0.5) <+> translate (point 1.9 3), square), (scale (point 0.6 0.6) <+> translate (point 3 2), circle), (scale (point 0.8 0.4) <+> translate (point 3 5), circle), (scale (point 0.4 0.1) <+> translate (point 7 25), square)]"

        get "/translate" $ do
             html $ R.renderHtml $ do pageSetup "Translations!" "http://localhost:8080/images/multiple_translate.png" "renderC src/images/multiple_translate.png cusWindow multipleTranslatesDrawing [2,4,1,3,5]" "multipleTranslatesDrawing = [ (translate (point 10 10) <+> translate (point 5 7) <+> scale (point 0.1 0.1), square), (translate (point 45 45) <+> translate (point (-9) (-18)) <+> scale (point 0.1 0.1), square), (translate (point 4 8) <+> translate (point (5) (5)) <+> scale (point 0.1 0.1), square) ]"

pageSetup :: Text -> Text -> Text -> Text -> H.Html
pageSetup h s code codeExtra = do
                      H.h1 ( H.toHtml h )
                      H.img H.! A.src (H.toValue s)
                      H.p ( H.toHtml code )
                      H.p ( H.toHtml codeExtra )
                      toMain
                            
toMain :: H.Html
toMain = H.a "To the landing page!" H.! A.href "http://localhost:3000"