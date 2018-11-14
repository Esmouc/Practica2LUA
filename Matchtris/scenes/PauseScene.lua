PauseScene = Object:extend()

function PauseScene:new()
  self.lObjects = {}
end

function PauseScene:Load()
  self.lObjects = {}
  -- GAME OBJECTS
  self.exit = Button(self.Exit, w/2, h * (2/3), font, "Exit")
  self.volverB = Button(self.Reiniciar, w/2, h/3, font, "Volver")
  self.menuB = Button(self.Ranking, w/2, h/2, font, "Menu")
  self.background = GameObject({},Transform(w/2,h/2), SpriteRenderer(pausePath))
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  table.insert (self.lObjects, self.background)
  table.insert (self.lObjects, self.exit)
  table.insert (self.lObjects, self.volverB)
  table.insert (self.lObjects, self.menuB)
  
end

function PauseScene:update(dt)
  for _,v in pairs(self.lObjects) do
    v:update(dt)
  end
end
function PauseScene:draw()
  for _,v in pairs(self.lObjects) do
    v:draw()
  end
end
function PauseScene:Exit()
  os.exit()
end
function PauseScene:Reiniciar()
  changeState(GameStates.gameplay)
  
end
function PauseScene:Ranking()
  changeState(GameStates.menu)
end

function PauseScene:keypressed(key)

end
