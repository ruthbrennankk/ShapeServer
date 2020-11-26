{-# LANGUAGE OverloadedStrings #-}

module Main where

-- Shapes Imports
import Shapes
import Render (render,renderC,defaultWindow,samples,myWindow)
-- Scotty and Blaze imports
import Data.Text.Lazy
import Web.Scotty
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html.Renderer.Text as R

{-
generateDrawing :: Double -> (Transform,Shape)
generateDrawing p = (scale (point p p), square)

generateSquaresList :: Double -> Double -> Int -> Drawing
generateSquaresList p1 p2 n = let list = samples p1 p2 n in 
                                 map generateDrawing list --[0.25, 0.5, 0.75]

squaresList = generateSquaresList 0.0 1.0 10
-}

-- exampleDrawing =  [ (scale (point 0.1 0.1) <+> translate (point 10 10), circle), (scale (point 0.1 0.1) <+> translate (point 45 45), square), (scale (point 0.1 0.1) <+> translate (point 10 45), circle) ]
-- polygonDrawing = [ (identity, polygon [(point 1 1),(point 1 3),(point 2 4), (point 3 3), (point 3 1), (point 1 1)]), (scale (point 0.1 0.1) <+> translate (point 10 45), circle), (scale (point 0.1 0.1) <+> translate (point 45 10), circle)]
-- rotateSquare = [(scale (point 0.5 0.5) <+> translate (point 2.5 2.5) <+> rotate 45.0, square)]
-- rotatePolygon = [ (scale (point 0.5 0.5) <+> translate (point 5 5) <+> rotate 180.0 , polygon [(point 1 1),(point 1 3),(point 2 4), (point 3 3), (point 3 1), (point 1 1)]), (scale (point 0.1 0.1) <+> translate (point 45 10), circle)]

exampleDrawing =  [ (scale (point 0.1 0.1) <+> translate (point 10 10), circle), (scale (point 0.1 0.1) <+> translate (point 45 45), square), (scale (point 0.1 0.1) <+> translate (point 10 10), circle) ]


cusWindow = myWindow 0.0 0.0 5 5 500 500

{-
main = do
        render "src/images/z_zoutput.png" cusWindow exampleDrawing
        -- render "z_zoutput.png" cusWindow squaresList
-}

main = do
    putStrLn "Starting Server..."
    renderAllTheShapes
    renderJustCircles
    renderDodecagon
    renderOverlap
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
                      H.p "All the shapes is a drawing of a Square, a Rectangle, an Ellipse, a Pentagon and a Circle, all in different colours"
                      H.h5 "Just Circles"
                      H.a "To the circles!" H.! A.href "http://localhost:3000/justcircles"
                      H.p "Just circles has a drawing that contains 4 circles but only 3 can be seen becuase two were placed in the same spot and one covered the other. My program selects the first shape in the drawing to draw and if there should be another in that spot that is later in the list it is ignored"
                      H.h5 "Dodecagon!"
                      H.a "To the dodecagon!" H.! A.href "http://localhost:3000/dodecagon"
                      H.p "TODO All the shapes is a drawing of a Square, a Rectangle, an Ellipse, a Pentagon and a Circle, all in different colours"
                      H.h5 "Overlap!"
                      H.a "To the overlap!" H.! A.href "http://localhost:3000/overlap"
                      H.p "TODO All the shapes is a drawing of a Square, a Rectangle, an Ellipse, a Pentagon and a Circle, all in different colours"

        get "/alltheshapes" $ do
             html $ R.renderHtml $ pageSetup "All the Shapes!" "http://localhost:8080/images/allTheShapes.png" "TODO render src/allTheShapes.png cusWindow exampleDrawing"
                      
        get "/justcircles" $ do
             html $ R.renderHtml $ pageSetup "Just Circles!" "http://localhost:8080/images/justCircles.png" "TODO render src/z_zoutput.png cusWindow exampleDrawing"
                             
        get "/dodecagon" $ do
             html $ R.renderHtml $ pageSetup "Dodecagon!" "http://localhost:8080/images/dodecagon.png" "TODO render src/z_zoutput.png cusWindow exampleDrawing"
             
        get "/overlap" $ do
             html $ R.renderHtml $ pageSetup "Overlap!" "http://localhost:8080/images/overlap.png" "TODO render src/z_zoutput.png cusWindow exampleDrawing"

pageSetup :: Text -> Text -> Text -> H.Html
pageSetup h s code = do
                      H.h1 ( H.toHtml h )
                      H.img H.! A.src (H.toValue s)
                      H.p ( H.toHtml code )
                      toMain
                            
toMain :: H.Html
toMain = H.a "To the landing page!" H.! A.href "http://localhost:3000"

renderAllTheShapes :: IO ()
renderAllTheShapes = do 
    renderC "src/images/allTheShapes.png" cusWindow allShapesDrawing [1,2,3,4,5]
      where allShapesDrawing = [(scale (point 0.25 0.25) <+> translate (point 3 5), polygon [(point 1 1),(point 1 3),(point 2 4), (point 3 3), (point 3 1), (point 1 1)]), (scale (point 0.1 0.1) <+> translate (point 10 45), square), (scale (point 0.25 0.25) <+> translate (point 10 15), circle), (scale (point 0.5 0.1) <+> translate (point 4.3 5), circle), (scale (point 0.4 0.1) <+> translate (point 10 25), square)]

renderJustCircles :: IO ()
renderJustCircles = do 
    renderC "src/images/justCircles.png" cusWindow justCirclesDrawing [1,2,3,4,5]
      where justCirclesDrawing = [(scale (point 0.1 0.1) <+> translate (point 10 10), circle), (scale (point 0.1 0.1) <+> translate (point 45 45), circle), (scale (point 0.1 0.1) <+> translate (point 10 45), circle), (scale (point 0.1 0.1) <+> translate (point 10 45), circle)]

renderDodecagon :: IO ()
renderDodecagon = do 
    renderC "src/images/dodecagon.png" cusWindow dodecagonDrawing [2,1,3,4,5]
      where dodecagonDrawing = [(scale (point 0.25 0.25) <+> translate (point 3 6), polygon [(point 0 5),(point 1 6),(point 3 7), (point 5 7), (point 7 6), (point 8 4), (point 7 1), (point 5 1),(point 5 3), (point 4 4), (point 3 1), (point 1 2), (point 1 4), (point 0 5)])]

renderOverlap :: IO ()
renderOverlap = do 
    renderC "src/images/overlap.png" cusWindow overlapDrawing [5,4,3,2,1]
      where overlapDrawing = [(scale (point 0.75 0.75) <+> translate (point 3 5) <+> rotate 180.0 , polygon [(point 1 1),(point 1 3),(point 2 4), (point 3 3), (point 3 1), (point 1 1)]), (scale (point 0.5 0.5) <+> translate (point 1.9 3), square), (scale (point 0.6 0.6) <+> translate (point 3 2), circle), (scale (point 0.8 0.4) <+> translate (point 3 5), circle), (scale (point 0.4 0.1) <+> translate (point 7 25), square)]

