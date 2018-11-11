SplashScene = Object:extend()

function SplashScene:new()
  self.lObjects = {}
end

function SplashScene:Load()
  self.lObjects = {}
  self.c = 0
  -- GAME OBJECTS
  self.background = GameObject({},Transform(w/2,h/2), SpriteRenderer(menuPath))
  
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  table.insert (self.lObjects, self.background)
  
end

function SplashScene:update(dt)
  
  if self.c >= 1.0 then
    changeState(GameStates.menu)
  else
    self.c= self.c + dt
  end
  
   for _,v in pairs(self.lObjects) do
    v:update(dt)
  end
  
end
function SplashScene:draw()
  
  for _,v in pairs(self.lObjects) do
    v:draw()
  end
  
end
