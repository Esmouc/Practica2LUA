LevelScene = Object:extend()

function LevelScene:new()
  self.lObjects = {}
end

function LevelScene:Load()
  self.lObjects = {}
  -- GAME OBJECTS

  self.barManager = GameObject({BarScript()},Transform(), SpriteRenderer(barPath))
  self.background = GameObject({},Transform(w/2,h/2), SpriteRenderer(bgPath))
  self.foreGround = GameObject({},Transform(w/2,h/2), SpriteRenderer(fgPath))
  self.levelManager = GameObject({LevelManager()},Transform())
  
  -- UI
  
  self.playerScore = Text(w/2,h/2,0,0,500,"center")
  
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  
  table.insert (self.lObjects, self.background)
  table.insert (self.lObjects, self.playerScore)
  table.insert (self.lObjects, self.foreGround)
  table.insert (self.lObjects, self.levelManager)
  
  self.levelManager:GetComponent(LevelManager):TetrominoSpawn()
  
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

    
