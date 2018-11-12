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
smallfont = love.graphics.newFont("font/D-DIN-Bold.otf",40)

--TEXTURES
barPath = "sprites/backgrounds/matchtrisBar.png"
bgPath = 0
matchbgPath="sprites/backgrounds/matchtrisBGBACK.png"
miaubgPath = "sprites/backgrounds/miautrisBGBACK.png"
fgPath = 0
bgnormal = "sprites/backgrounds/matchtrisBG.png"
bgMiautris = "sprites/backgrounds/miautrisBG.png"
menuPath = "sprites/backgrounds/matchtrisBGMENU.png"
botonesPath = {exit = "sprites/botones/exit.png" , mexit="sprites/botones/menuexit.png", menumeowtris ="sprites/botones/menumeowtris.png", play="sprites/botones/menuplay.png", ranking ="sprites/botones/menuranking.png", resume ="sprites/botones/resume.png"}

-- PIECES

piecesPaths = {}
normalPiecesPaths = {"sprites/piezas/amarilla.png","sprites/piezas/azul.png","sprites/piezas/lila.png","sprites/piezas/naranja.png", "sprites/piezas/roja.png","sprites/piezas/verde.png"}
miauPiecesPaths = {"sprites/piezas/gatitoamarillo.png","sprites/piezas/gatitoazul.png","sprites/piezas/gatitolila.png","sprites/piezas/gatitonaranja.png", "sprites/piezas/gatitorojo.png","sprites/piezas/gatitoverde.png"}


--TETROMINOS GRIDS

tGrids = {{{0,1,0},{1,1,1}},{{1,1,1,1}},{{1,0,0},{1,1,1}},{{0,0,1},{1,1,1}},{{1,1},{1,1}},{{0,1,1},{1,1,0}},{{1,1,0},{0,1,1}}} 
