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
  self.powerUpManager = GameObject({PowerUpManager(1)},Transform(w/2, h/2-self.background.spriteRenderer.origin.y+5), SpriteRenderer(powerBarPath[1]))
  
  -- UI
  
  self.playerScore = Text(0,0,0,4,350,"right",smallfont)
    
  
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  
  table.insert (self.lObjects, self.background)
  table.insert (self.lObjects, self.foreGround)
  table.insert (self.lObjects, self.levelManager)
  table.insert (self.lObjects, self.playerScore)
  
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

function LevelScene:keypressed(key)
  self.levelManager:GetComponent(LevelManager):keypressed(key)
end

    
