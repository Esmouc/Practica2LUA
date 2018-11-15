w = love.graphics.getWidth()
h = love.graphics.getHeight()

-- DATA
fallTime = 1.0
scrollTime = 0.05
powerUpCooldown = 5
rankingNFileName = "RankingNames.txt"
rankingSFileName = "RankingScores.txt"

-- GRID

gridCols = 10
gridRows = 20
pixelWidth = 30
pixelHeight = 30

-- COLORS
colors = {WHITE = {1,1,1,1}, GREY = {0.831, 0.831, 0.831, 1}, DARKGREY = {0.521, 0.521, 0.521,1}, BLACK = {0,0,0,1}, BLUE = {0.180,0.631,0.960,1}, RED = {1,0,0,1}}

-- FONTS
font = love.graphics.newFont("font/Square.ttf",40)
smallfont = love.graphics.newFont("font/Square.ttf",30)

--TEXTURES
barPath = "sprites/backgrounds/matchtrisBar.png"
bgPath = 0
matchbgPath="sprites/backgrounds/matchtrisBGBACK.png"
miaubgPath = "sprites/backgrounds/miautrisBGBACK.png"
fgPath = 0
bgnormal = "sprites/backgrounds/matchtrisBG.png"
bgMiautris = "sprites/backgrounds/miautrisBG.png"
menuPath = "sprites/backgrounds/matchtrisBGMENU.png"
splashPath = "sprites/backgrounds/maiutrisSPLASH.png"
botonesPath = {exit = "sprites/botones/exit.png" , mexit="sprites/botones/menuexit.png", menumeowtris ="sprites/botones/menumeowtris.png", play="sprites/botones/menuplay.png", ranking ="sprites/botones/menuranking.png", resume ="sprites/botones/resume.png"}

pausePath = "sprites/backgrounds/matchtrisBGPAUSE.png"
-- SOUNDS

matchtrisSong = "sounds/matchtrisong.wav"
miautrisSong = "sounds/meowtris.mp3"

rotateSound = love.audio.newSource("sounds/rotarpieza.wav", "static")
matchSound = love.audio.newSource("sounds/match.wav", "static")
clackSound = love.audio.newSource("sounds/clack.wav", "static")

timeStop = love.audio.newSource("sounds/timestop.mp3", "static")
timeStart = love.audio.newSource("sounds/timestart.wav", "static")
projo = love.audio.newSource("sounds/projo.ogg", "static")
pazul = love.audio.newSource("sounds/pazul.ogg", "static")
pnaranja = love.audio.newSource("sounds/pnaranja.ogg", "static")
plila = love.audio.newSource("sounds/plila.ogg", "static")
pverde = love.audio.newSource("sounds/pverde.ogg", "static")


-- PIECES

piecesPaths = {}
normalPiecesPaths = {"sprites/piezas/amarilla.png","sprites/piezas/azul.png","sprites/piezas/lila.png","sprites/piezas/naranja.png", "sprites/piezas/roja.png","sprites/piezas/verde.png"}
miauPiecesPaths = {"sprites/piezas/gatitoamarillo.png","sprites/piezas/gatitoazul.png","sprites/piezas/gatitolila.png","sprites/piezas/gatitonaranja.png", "sprites/piezas/gatitorojo.png","sprites/piezas/gatitoverde.png"}

powerPiecesPaths = {}
normalPowerPiecesPaths = {"sprites/piezas/amarillaplus.png","sprites/piezas/azulplus.png","sprites/piezas/lilaplus.png","sprites/piezas/naranjaplus.png", "sprites/piezas/rojaplus.png","sprites/piezas/verdeplus.png"}
miauPowerPiecesPaths = {"sprites/piezas/gatitoamarilloplus.png","sprites/piezas/gatitoazulplus.png","sprites/piezas/gatitolilaplus.png","sprites/piezas/gatitonaranjaplus.png", "sprites/piezas/gatitorojoplus.png","sprites/piezas/gatitoverdeplus.png"}

powerBarPath = {"sprites/powerups/barraamarilla.png","sprites/powerups/barraazul.png","sprites/powerups/barralila.png","sprites/powerups/barranaranja.png", "sprites/powerups/barraroja.png","sprites/powerups/barraverde.png"}

--TETROMINOS GRIDS

tGrids = {{{0,1,0},{1,1,1}},{{1,1,1,1}},{{1,0,0},{1,1,1}},{{0,0,1},{1,1,1}},{{1,1},{1,1}},{{0,1,1},{1,1,0}},{{1,1,0},{0,1,1}},{{1}}} 
