RankingScene = Object:extend()

function RankingScene:new()
  self.lObjects = {}
end

function RankingScene:Load()
  self.lObjects = {}
  -- GAME OBJECTS
  self.exit = Button(self.Exit, w/2, h * (2/3), font, "Exit")
  self.backB = Button(self.Back, w/2, h/3, font, "Back")
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  table.insert (self.lObjects, self.exit)
  table.insert (self.lObjects, self.backB)
end

function RankingScene:update(dt)
  for _,v in pairs(self.lObjects) do
    v:update(dt)
  end
end
function RankingScene:draw()
  for _,v in pairs(self.lObjects) do
    v:draw()
  end
end
function RankingScene:Exit()
  os.exit()
end
function RankingScene:Back()
  changeState(GameStates.menu)
end
