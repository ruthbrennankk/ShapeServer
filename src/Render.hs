module Render(Window,defaultWindow,myWindow,samples,render,renderC) where
import Codec.Picture
import Shapes

--  A window specifies what part of the world to render and at which
--  resolution.
--  Values are top left & bottom right corner to be rendered, 
--             and the size of the output device to render into
data Window = Window Point Point (Int,Int)

-- Default window renders a small region around the origin into
-- a 50x50 pixel image
defaultWindow :: Window
defaultWindow = Window (point (-1.5) (-1.5)) (point (1.5) (1.5)) (500,500)

-- Custom window renders a small region around the origin into
-- a 50x50 pixel image
myWindow :: Double -> Double -> Double -> Double -> Int -> Int -> Window
myWindow x1 y1 x2 y2 l1 l2 = Window (point x1 y1) (point x2 y2) (l1,l2)

-- Generate a list of evenly spaced samples between two values.
-- e.g. samples -1.5 +1.5 25 generates 25 samples evenly spaced
--      between the two bounds: [ -1.5, -1.375, -1.25 ... ]
samples :: Double -> Double -> Int -> [Double]
samples c0 c1 n = take n [ c0, c0 + (c1-c0) / (fromIntegral $ n-1) .. ]

-- Generate the matrix of points corresponding to the pixels of a window.
pixels :: Window -> [[Point]]
pixels (Window p0 p1 (w,h)) =
  [ [ point x y | x <- samples (getX p0) (getX p1) w ]
                | y <- reverse $ samples (getY p0) (getY p1) h
  ]

-- generate list of all screen coordinates in window
coords :: Window -> [[(Int,Int)]]
coords (Window _ _ (w,h)) = [ [(x,y) | x <- [0..w]] | y <- [0..h] ]


-- To make the renderer more efficient I'll write a coordinate-transformer
-- that way the O(n) lookup of locations will become an O(1) calculation of locations

-- Linearly scale a value from the range [a1,a2] to the range [b1,b2]
scaleValue :: Fractional a => (a,a) -> (a,a) -> a -> a
scaleValue (a1,a2) (b1,b2) v = b1 + (v - a1) * (b2-b1) / (a2-a1)

-- Convert a screen-space point into an image-space point
-- in a specific window
mapPoint :: Window -> (Int,Int) -> Point
mapPoint (Window p0 p1 (w,h)) (x,y) = point scaledX scaledY
  where
    scaledX = scaleValue (0,fromIntegral w) (getX p0, getX p1) (fromIntegral x)
    scaledY = scaleValue (0,fromIntegral h) (getY p0, getY p1) (fromIntegral y)


-- Render a drawing into an image, then save into a file
-- This version relates the Shape language coordinates to the pixel coordinates
-- using the scaleValue function which is much faster than the original lookup based code.

-- eg. render "z_output.png" defaultWindow exampleDrawing
render :: String -> Window -> Drawing -> IO ()
render path win sh = writePng path $ generateImage pixRenderer w h
    where
      Window _ _ (w,h) = win
      pixRenderer x y = PixelRGB8 c c c where c = (colorForImage $ mapPoint win (x,y))
                                            
      colorForImage :: Point -> Pixel8
      colorForImage p | p `inside` sh = 255
                      | otherwise     = 0

{-
  Colour Options with Codes (RGB)
  1. Pink - 255 51 249
  2. Blue - 51 113 255
  3. Orange - 255 190 51
  4. Purple - 165 51 255
  5. Yellow - 255 255 51
-}

-- eg. render "z_output.png" defaultWindow exampleDrawing
renderC :: String -> Window -> Drawing -> [Int] -> IO ()
renderC path win d c = writePng path $ generateImage pixRenderer w h
                                 
--renderC path win sh = writePng path $ generateImage pixRenderer w h
    where
      Window _ _ (w,h) = win
      pixRenderer x y = PixelRGB8 r g b where --c = (colorForImage $ mapPoint win (x,y))
                                            (r, g, b) = (colorForImage1 c $ mapPoint win (x,y))

      colorForImage1 :: [Int] -> Point -> (Pixel8, Pixel8, Pixel8)
      colorForImage1 c p | p `inside` d = 
                              case code of
                                          1 -> (255, 51, 249)
                                          2 -> (51, 113, 225)
                                          3 -> (255, 190, 51)
                                          4 -> (165, 51, 225)
                                          5 -> (255, 255, 51)  
                                          _  -> (255, 255, 255)                
                         | otherwise     = (0, 0, 0)
                         where code | i < length(c) && i > -1 = c !! i
                                    | otherwise = 0
                               i = (insideShape p d 0)
