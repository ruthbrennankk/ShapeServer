module Examples (renderAllTheShapes,renderJustCircles,renderDodecagon,renderOverlap,renderDoubleTransform) where

-- Shapes Imports
import Shapes
import Render (render,renderC,defaultWindow,samples,myWindow)

cusWindow = myWindow 0.0 0.0 5 5 500 500

renderAllTheShapes :: IO ()
renderAllTheShapes = do
    renderC "src/images/allTheShapes.png" cusWindow allShapesDrawing [1,2,3,4,5]
      where allShapesDrawing = [(scale (point 0.25 0.25) <+> translate (point 3 5), polygon [(point 1 1),(point 1 3),(point 2 4), (point 3 3), (point 3 1), (point 1 1)]), (scale (point 0.1 0.1) <+> translate (point 10 45), square), (scale (point 0.25 0.25) <+> translate (point 10 15), circle), (scale (point 0.5 0.1) <+> translate (point 4.3 5), circle), (scale (point 0.4 0.1) <+> translate (point 10 25), square)]

renderJustCircles :: IO ()
renderJustCircles = do
    renderC "src/images/justCircles.png" cusWindow justCirclesDrawing [1,2]
      where justCirclesDrawing = [(scale (point 0.1 0.1) <+> translate (point 10 10), circle), (scale (point 0.1 0.1) <+> translate (point 45 45), circle), (scale (point 0.1 0.1) <+> translate (point 10 45), circle), (scale (point 0.1 0.1) <+> translate (point 10 45), circle)]

renderDodecagon :: IO ()
renderDodecagon = do
    renderC "src/images/dodecagon.png" cusWindow dodecagonDrawing [2,1,3,4,5]
      where dodecagonDrawing = [(scale (point 0.25 0.25) <+> translate (point 3 6), polygon [(point 0 5),(point 1 6),(point 3 7), (point 5 7), (point 7 6), (point 8 4), (point 7 1), (point 5 1),(point 5 3), (point 4 4), (point 3 1), (point 1 2), (point 1 4), (point 0 5)])]

renderOverlap :: IO ()
renderOverlap = do
    renderC "src/images/overlap.png" cusWindow overlapDrawing [5,4,3,2,1]
      where overlapDrawing = [(scale (point 0.75 0.75) <+> translate (point 3 5) <+> rotate 180.0 , polygon [(point 1 1),(point 1 3),(point 2 4), (point 3 3), (point 3 1), (point 1 1)]), (scale (point 0.5 0.5) <+> translate (point 1.9 3), square), (scale (point 0.6 0.6) <+> translate (point 3 2), circle), (scale (point 0.8 0.4) <+> translate (point 3 5), circle), (scale (point 0.4 0.1) <+> translate (point 7 25), square)]

renderDoubleTransform :: IO ()
renderDoubleTransform = do
    renderC "src/images/multiple_translate.png" cusWindow multipleTranslatesDrawing [2,4,1,3,5]
      where multipleTranslatesDrawing = [ (scale (point 0.1 0.1) <+> translate (point 10 10) <+> translate (point 5 7), square), (scale (point 0.1 0.1) <+> translate (point 45 45) <+> translate (point (-9) (-18)), square), (scale (point 0.1 0.1) <+> translate (point 4 8) <+> translate (point (5) (5)), square) ]
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
-- exampleDrawing =  [ (scale (point 0.1 0.1) <+> translate (point 10 10), circle), (scale (point 0.1 0.1) <+> translate (point 45 45), square), (scale (point 0.1 0.1) <+> translate (point 10 10), circle) ]

{-
main = do
        render "src/images/output.png" cusWindow exampleDrawing
        -- render "z_output.png" cusWindow squaresList
-}