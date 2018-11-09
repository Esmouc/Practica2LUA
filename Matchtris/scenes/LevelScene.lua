LevelScene = Object:extend()

function LevelScene:new()
  
  self.lObjects = {}
  
end

function LevelScene:Load()
  
  self.lObjects = {}
  
  -- GAME OBJECTS
  
  self.levelManager = GameObject({LevelManager()},Transform())
  self.barManager = GameObject({BarScript()},Transform(), SpriteRenderer(barPath))
  self.background = GameObject({},Transform(w/2,h/2), SpriteRenderer(bgPath))
  self.foreGround = GameObject({},Transform(w/2,h/2), SpriteRenderer(fgPath))
  
  -- UI
  
  self.playerScore = Text(w/2,h/2,0,0,500,"center")
  
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  
  table.insert (self.lObjects, self.levelManager)
  table.insert (self.lObjects, self.background)
  table.insert (self.lObjects, self.playerScore)
  table.insert (self.lObjects, self.foreGround)
  
  self.tetromino = GameObject({TetrominoScript(true)},Transform())
  table.insert (self.lObjects, self.tetromino)
  
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

    
