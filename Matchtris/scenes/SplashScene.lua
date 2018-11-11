SplashScene = Object:extend()

function SplashScene:new()
  self.lObjects = {}
end

function SplashScene:Load()
  self.lObjects = {}
  self.c = 0
  -- GAME OBJECTS
  
  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  
end

function SplashScene:update(dt)
  if self.c >= 2.5 then
    changeState(GameStates.menu)
  else
    self.c= self.c + dt
  end
  
end
function SplashScene:draw()
end
