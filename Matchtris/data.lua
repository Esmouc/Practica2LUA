w = love.graphics.getWidth()
h = love.graphics.getHeight()

-- DATA
fallTime = 1.0
scrollTime = 0.1

-- GRID

gridCols = 10
gridRows = 20
pixelWidth = 30
pixelHeight = 30

-- COLORS
colors = {WHITE = {1,1,1,1}, GREY = {0.831, 0.831, 0.831, 1}, DARKGREY = {0.521, 0.521, 0.521,1}, BLACK = {0,0,0,1}, BLUE = {0.180,0.631,0.960,1}, RED = {1,0,0,1}}

-- FONTS
font = love.graphics.newFont("font/D-DIN-Bold.otf",50)

--TEXTURES
barPath = "sprites/backgrounds/matchtrisBar.png"
bgPath = "sprites/backgrounds/matchtrisBGBACK.png"
fgPath = "sprites/backgrounds/matchtrisBG.png"
bgMiautris = "sprites/backgrounds/miautrisBG.png"

-- PIECES

piecesPaths = {"sprites/piezas/amarilla.png","sprites/piezas/azul.png","sprites/piezas/lila.png","sprites/piezas/naranja.png", "sprites/piezas/roja.png","sprites/piezas/verde.png"}

--TETROMINOS GRIDS

tGrids = {{{0,1,0},{1,1,1}},{{1,1,1,1}},{{1,0,0},{1,1,1}},{{0,0,1},{1,1,1}},{{1,1},{1,1}},{{0,1,1},{1,1,0}},{{1,1,0},{0,1,1}}} 
