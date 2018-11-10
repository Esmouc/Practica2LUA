SplashScene = Object:extend()

function SplashScene:new()
  self.lObjects = {}
end

function SplashScene:Load()
  self.lObjects = {}
  self.go = false
  self.c = 0
  -- GAME OBJECTS
  
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  
end

function SplashScene:update(dt)
  if self.c >= 5 then
    self.go = true
  else
    self.c= self.c + dt
  end
  
end
function SplashScene:draw()
end
