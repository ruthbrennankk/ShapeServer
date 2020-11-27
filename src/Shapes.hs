module Shapes(
  Shape, Point, Vector, Transform, Drawing,
  point, getX, getY,
  empty, circle, square, polygon,
  identity, translate, rotate, scale, (<+>),
  inside, insideShape, transform)  where

-- Utilities
data Vector = Vector Double Double
              deriving Show
vector = Vector

cross :: Vector -> Vector -> Double
cross (Vector a b) (Vector a' b') = a * a' + b * b'

mult :: Matrix -> Vector -> Vector
mult (Matrix r0 r1) v = Vector (cross r0 v) (cross r1 v)

invert :: Matrix -> Matrix
invert (Matrix (Vector a b) (Vector c d)) = matrix (d / k) (-b / k) (-c / k) (a / k)
  where k = a * d - b * c

-- 2x2 square matrices are all we need.
data Matrix = Matrix Vector Vector
              deriving Show

matrix :: Double -> Double -> Double -> Double -> Matrix
matrix a b c d = Matrix (Vector a b) (Vector c d)

getX (Vector x y) = x
getY (Vector x y) = y

-- Shapes

type Point  = Vector

point :: Double -> Double -> Point
point = vector

data Shape = Empty 
           | Circle 
           | Square
           | Polygon [Point]
             deriving Show

empty, circle, square :: Shape

empty = Empty
circle = Circle
square = Square
-- Consider a polygon made up of N vertices (xi,yi) where i ranges from 0 to N-1.
-- The last vertex (xN,yN) is assumed to be the same as the first vertex (x0,y0), that is, the polygon is closed.
polygon = Polygon

-- Transformations

data Transform = Identity
           | Translate Vector
           | Scale Vector
           | Compose Transform Transform
           | Rotate Matrix
             deriving Show

identity = Identity
translate = Translate -- where
scale = Scale -- how big
rotate angle = Rotate $ matrix (cos angle) (-sin angle) (sin angle) (cos angle)
t0 <+> t1 = Compose t0 t1

transform :: Transform -> Point -> Point
transform Identity                   x = id x
transform (Translate (Vector tx ty)) (Vector px py)  = Vector (px - tx) (py - ty)
transform (Scale (Vector tx ty))     (Vector px py)  = Vector (px / tx)  (py / ty)
transform (Rotate m)                 p = (invert m) `mult` p
transform (Compose (Translate (Vector x1 y1)) (Translate (Vector x2 y2)) )  p = transform (Translate (Vector (x1+x2) (y1+y2))) p
transform (Compose t1 t2)            p = transform t2 $ transform t1 p

-- Drawings

type Drawing = [(Transform,Shape)]

{-
doubleTranslate :: Drawing -> Drawing
doubleTranslate (t, sh) =
-}

-- interpretation function for drawings

inside :: Point -> Drawing -> Bool
inside p d = or $ map (inside1 p) d

-- insideSide point listOfShapes i 
-- insideShape p d 0

insideShape :: Point -> Drawing -> Int -> Int
insideShape _ [] _ = 0
insideShape p ((t,s):xs) i | insides (transform t p) s = i           
                           | otherwise     = insideShape p xs (i+1)

inside1 :: Point -> (Transform, Shape) -> Bool
inside1 p (t,s) = insides (transform t p) s

insides :: Point -> Shape -> Bool
p `insides` Empty = False
p `insides` Circle = distance p <= 1
p `insides` Square = maxnorm  p <= 1
p `insides` Polygon x = countEdges p x 0 == 1

distance :: Point -> Double
distance (Vector x y ) = sqrt ( x**2 + y**2 )

maxnorm :: Point -> Double
maxnorm (Vector x y ) = max (abs x) (abs y)

-- (point)   (points in polygon) (counter) 
countEdges :: Point -> [Point] -> Int -> Int
countEdges _ (x:[]) c = c `mod` 2
countEdges (Vector px py) ((Vector x1 y1):(Vector x2 y2):xs) counter
  | ( (py > (minP y1 y2)) && (py <= (maxP y1 y2)) && (px <= (maxP x1 x2)) && (y1 /= y2) && ( (x1 == x2) || px <= xinters ) ) = 
      countEdges (Vector px py) ((Vector x2 y2):xs) (counter+1)        
  | otherwise = countEdges (Vector px py) ((Vector x2 y2):xs) counter
  where xinters = ((py-y1)*(x2-x1))/(y2-y1) + x1
  
maxP :: Double -> Double -> Double
maxP a b | a > b = a
         | otherwise = b
         
minP :: Double -> Double -> Double
minP a b | a < b = a
         | otherwise = b

-- testShape = (scale (point 10 20), circle)
