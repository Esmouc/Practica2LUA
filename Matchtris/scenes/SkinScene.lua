SkinScene = Object:extend()

function SkinScene:new()
  self.lObjects = {}
end

function SkinScene:Load()
  self.lObjects = {}
  self.play = false
  self.ranking = false
  
  -- GAME OBJECTS

  self.skinText = Text(50,h/1.9-75,0,0,300,"center", smallfont,"Choose your skin:")
  self.playB = Button(self.Play, 75, h/1.9-25, font, "Matchtris")
  self.playMB = Button(self.PlayMiau, 75, h/1.9+75, font, "Meowtris")

  self.background = GameObject({},Transform(w/2,h/2), SpriteRenderer(menuPath))
  
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  table.insert (self.lObjects, self.background)
  table.insert (self.lObjects, self.playB)
  table.insert (self.lObjects, self.playMB)
  table.insert (self.lObjects, self.skinText)

end

function SkinScene:update(dt)
  for _,v in pairs(self.lObjects) do
    v:update(dt)
  end
end
function SkinScene:draw()
  for _,v in pairs(self.lObjects) do
    v:draw()
  end
end

function SkinScene:Play()
  piecesPaths = normalPiecesPaths
  fgPath = bgnormal
  bgPath = matchbgPath
  powerPiecesPaths = normalPowerPiecesPaths
  songSelect = matchtrisSong
  changeState(GameStates.gameplay)
end
function SkinScene:PlayMiau()
  piecesPaths = miauPiecesPaths
  fgPath = bgMiautris
  bgPath = miaubgPath
  powerPiecesPaths = miauPowerPiecesPaths
  songSelect = miautrisSong
  changeState(GameStates.gameplay)
end

function SkinScene:keypressed(key)

end
