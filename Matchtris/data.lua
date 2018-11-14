w = love.graphics.getWidth()
h = love.graphics.getHeight()

-- DATA
fallTime = 1.0
scrollTime = 0.1
powerUpCooldown = 60

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

-- SOUNDS

matchtrisSong = love.audio.newSource("sounds/matchtrisong.wav", "static")
matchtrisSong:setLooping(true)
matchtrisSong:setVolume(0.3)

meowSong = love.audio.newSource("sounds/meowtris.mp3", "static")
meowSong:setLooping(true)
meowSong:setVolume(0.2)

rotateSound = love.audio.newSource("sounds/rotarpieza.wav", "static")
matchSound = love.audio.newSource("sounds/match.wav", "static")
clackSound = love.audio.newSource("sounds/clack.wav", "static")

-- PIECES

piecesPaths = {}
normalPiecesPaths = {"sprites/piezas/amarilla.png","sprites/piezas/azul.png","sprites/piezas/lila.png","sprites/piezas/naranja.png", "sprites/piezas/roja.png","sprites/piezas/verde.png"}
miauPiecesPaths = {"sprites/piezas/gatitoamarillo.png","sprites/piezas/gatitoazul.png","sprites/piezas/gatitolila.png","sprites/piezas/gatitonaranja.png", "sprites/piezas/gatitorojo.png","sprites/piezas/gatitoverde.png"}

powerPiecesPaths = {}
normalPowerPiecesPaths = {"sprites/piezas/amarillaplus.png","sprites/piezas/azulplus.png","sprites/piezas/lilaplus.png","sprites/piezas/naranjaplus.png", "sprites/piezas/rojaplus.png","sprites/piezas/verdeplus.png"}
miauPowerPiecesPaths = {"sprites/piezas/gatitoamarilloplus.png","sprites/piezas/gatitoazulplus.png","sprites/piezas/gatitolilaplus.png","sprites/piezas/gatitonaranjaplus.png", "sprites/piezas/gatitorojoplus.png","sprites/piezas/gatitoverdeplus.png"}

powerBarPath = {"sprites/powerups/barraamarilla.png","sprites/powerups/barraazul.png","sprites/powerups/barralila.png","sprites/powerups/barranaranja.png", "sprites/powerups/barraroja.png","sprites/powerups/barraverde.png"}

--TETROMINOS GRIDS

tGrids = {{{0,1,0},{1,1,1}},{{1,1,1,1}},{{1,0,0},{1,1,1}},{{0,0,1},{1,1,1}},{{1,1},{1,1}},{{0,1,1},{1,1,0}},{{1,1,0},{0,1,1}}} 
