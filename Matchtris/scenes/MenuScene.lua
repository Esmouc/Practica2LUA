MenuScene = Object:extend()

function MenuScene:new()
  self.lObjects = {}
end

function MenuScene:Load()
  self.lObjects = {}
  self.play = false
  self.ranking = false
  -- GAME OBJECTS
  self.exit = Button(self:Exit(), w/2, h * (2/3), font, "Exit")
  self.playB = Button(self:Play(), w/2, h/3, font, "Play")
  self.rankingB = Button(self:Ranking(), w/2, h/2, font, "Ranking")
  self.background = GameObject({},Transform(w/2,h/2), SpriteRenderer(menuPath))
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  table.insert (self.lObjects, self.background)
  table.insert (self.lObjects, self.exit)
  table.insert (self.lObjects, self.playB)
  table.insert (self.lObjects, self.rankingB)
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
  self.play = true
end
function MenuScene:Ranking()
  self.play = true
end
