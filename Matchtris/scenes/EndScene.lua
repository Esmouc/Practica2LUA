EndScene = Object:extend()

function EndScene:new()
  self.lObjects = {}
end

function EndScene:Load()
  self.lObjects = {}
  self.reiniciar = false
  self.ranking = false
  -- GAME OBJECTS
  self.exit = Button(Exit(), w/2, h * (2/3), font, "Exit")
  self.reiniciarB = Button(Reiniciar(), w/2, h/3, font, "Reiniciar")
  self.rankingB = Button(Ranking(), w/2, h/2, font, "Ranking")
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  table.insert (self.lObjects, self.exit)
  table.insert (self.lObjects, self.reiniciarB)
  table.insert (self.lObjects, self.rankingB)
end

function EndScene:update(dt)
  for _,v in pairs(self.lObjects) do
    v:update(dt)
  end
end
function EndScene:draw()
  for _,v in pairs(self.lObjects) do
    v:draw()
  end
end
function EndScene:Exit()
  os.exit()
end
function EndScene:Reiniciar()
  self.reiniciar = true
end
function EndScene:Ranking()
  self.play = true
end
