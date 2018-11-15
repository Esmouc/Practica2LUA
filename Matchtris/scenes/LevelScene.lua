LevelScene = Object:extend()

function LevelScene:new()
  self.lObjects = {}
end

function LevelScene:Load()
  
  self.lObjects = {}

  -- GAME OBJECTS

  self.background = GameObject({},Transform(w/2,h/2), SpriteRenderer(bgPath))
  self.foreGround = GameObject({},Transform(w/2,h/2), SpriteRenderer(fgPath))
  self.levelManager = GameObject({LevelManager()},Transform())
  self.powerUpManager = GameObject({PowerUpManager(1)},Transform(w/2, h/2-self.background.spriteRenderer.origin.y-4), SpriteRenderer(powerBarPath[1]))
  self.pressSpace = GameObject({},Transform(w/4.3,h/16), SpriteRenderer(spacePath))
 
  --MENU PAUSA
  self.exit = Button(self.Exit, 75, h/2.3 + 100, font, "Exit")
  self.volverB = Button(self.Resume, 75, h/2.3 - 100, font, "Resume")
  self.menuB = Button(self.Menu, 75, h/2.3, font, "Menu")
  
  -- UI
  
  self.playerScore = Text(0,0,0,4,350,"right",smallfont)
  
  -- MUSICA
  
   music = love.audio.newSource(songSelect, "static")
   music:setLooping(true)
   music:setVolume(0.3)
   music:play()
  
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  
  table.insert (self.lObjects, self.background)
  table.insert (self.lObjects, self.foreGround)
  table.insert (self.lObjects, self.levelManager)
  table.insert (self.lObjects, self.playerScore)
  --table.insert (self.lObjects, self.pressSpace)
  
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
  
  if available == false then self.pressSpace:draw() end
  
end

function LevelScene:Pause()

  table.insert (self.lObjects, self.exit)
  table.insert (self.lObjects, self.volverB)
  table.insert (self.lObjects, self.menuB)
  print "PAUSED"
end

function LevelScene:Resume()
  
  currentScene.exit:destroy()
  currentScene.volverB:destroy()
  currentScene.menuB:destroy()
  music:play()
  currentScene.levelManager:GetComponent(LevelManager).pause = false
  currentScene.powerUpManager:GetComponent(PowerUpManager).wait = false
  
end

function LevelScene:keypressed(key)
  
  local lvManager = self.levelManager:GetComponent(LevelManager)
  lvManager:keypressed(key)
 
  if key == "escape" and lvManager.pause == false then
    music:stop()
    self:Pause()
    lvManager.pause = true
    self.powerUpManager:GetComponent(PowerUpManager).wait = true
  end
  
end

function LevelScene:Exit()
  os.exit()
end

function LevelScene:Menu()
  changeState(GameStates.menu)
end

    
