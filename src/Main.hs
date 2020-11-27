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
                      H.h5 "Double Translate!"
                      H.a "To the Translates!" H.! A.href "http://localhost:3000/translate"
                      H.p "TODO All the shapes is a drawing of a Square, a Rectangle, an Ellipse, a Pentagon and a Circle, all in different colours"

        get "/alltheshapes" $ do
             html $ R.renderHtml $ pageSetup "All the Shapes!" "http://localhost:8080/images/allTheShapes.png" "TODO render src/allTheShapes.png cusWindow exampleDrawing"
                      
        get "/justcircles" $ do
             html $ R.renderHtml $ pageSetup "Just Circles!" "http://localhost:8080/images/justCircles.png" "TODO render src/z_zoutput.png cusWindow exampleDrawing"
                             
        get "/dodecagon" $ do
             html $ R.renderHtml $ pageSetup "Dodecagon!" "http://localhost:8080/images/dodecagon.png" "TODO render src/z_zoutput.png cusWindow exampleDrawing"
             
        get "/overlap" $ do
             html $ R.renderHtml $ pageSetup "Overlap!" "http://localhost:8080/images/overlap.png" "TODO render src/z_zoutput.png cusWindow exampleDrawing"

        get "/translate" $ do
             html $ R.renderHtml $ do pageSetup "Translations!" "http://localhost:8080/images/multiple_translates.png" "TODO render src/z_zoutput.png cusWindow exampleDrawing"
                                      H.h3 "For reference single translate looks the same"
                                      H.img H.! A.src "http://localhost:8080/images/single_translate.png"

pageSetup :: Text -> Text -> Text -> H.Html
pageSetup h s code = do
                      H.h1 ( H.toHtml h )
                      H.img H.! A.src (H.toValue s)
                      H.p ( H.toHtml code )
                      toMain
                            
toMain :: H.Html
toMain = H.a "To the landing page!" H.! A.href "http://localhost:3000"