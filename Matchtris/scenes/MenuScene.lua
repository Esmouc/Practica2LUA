MenuScene = Object:extend()

function MenuScene:new()
  self.lObjects = {}
end

function MenuScene:Load()
  self.lObjects = {}
  self.play = false
  self.ranking = false
  
  -- GAME OBJECTS
  self.exit = Button(self.Exit, 75, h/1.9 + 100, font, "Exit")
  self.playB = Button(self.Play, 75, h/1.9 - 100, font, "Matchtris")
  self.playMB = Button(self.PlayMiau, 75, h/1.9, font, "Meowtris")
  --self.rankingB = Button(self.Ranking, w/2, h/2, font, "Ranking")
  self.background = GameObject({},Transform(w/2,h/2), SpriteRenderer(menuPath))
  
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  table.insert (self.lObjects, self.background)
  table.insert (self.lObjects, self.exit)
  table.insert (self.lObjects, self.playB)
  table.insert (self.lObjects, self.playMB)
  --table.insert (self.lObjects, self.rankingB)
end

function MenuScene:update(dt)
  for _,v in pairs(self.lObjects) do
    v:update(dt)
  end
end
function MenuScene:draw()
  for _,v in pairs(self.lObjects) do
    v:draw()
  end
end
function MenuScene:Exit()
  os.exit()
end
function MenuScene:Play()
  piecesPaths = normalPiecesPaths
  fgPath = bgnormal
  bgPath = matchbgPath
  powerPiecesPaths = normalPowerPiecesPaths
  songSelect = matchtrisSong
  changeState(GameStates.gameplay)
end
function MenuScene:PlayMiau()
  piecesPaths = miauPiecesPaths
  fgPath = bgMiautris
  bgPath = miaubgPath
  powerPiecesPaths = miauPowerPiecesPaths
  songSelect = miautrisSong
  changeState(GameStates.gameplay)
end
function MenuScene:Ranking()
  changeState(GameStates.ranking)
end

function MenuScene:keypressed(key)

end
