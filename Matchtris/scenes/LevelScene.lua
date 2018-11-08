LevelScene = Object:extend()

function LevelScene:new()
  
  self.lObjects = {}
  
  -- GAME OBJECTS
  
  self.levelManager = GameObject({LevelManager()},Transform())
  self.barManager = GameObject({BarScript()},Transform(), SpriteRenderer(barPath))
  
  -- UI
  
  self.playerScore = Text(w/2,h/2,0,0,500,"center")
  
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  
  table.insert (self.lObjects, self.levelManager)
  table.insert (self.lObjects, self.playerScore)
  
end

function LevelScene:update(dt)
  
  for _,v in pairs(self.lObjects) do
    v:update(dt)
  end
  
end


function LevelScene:draw()
    
  for _,v in pairs(self.lObjects) do
    v:draw()
  end
  
end

    
