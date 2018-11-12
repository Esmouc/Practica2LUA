PowerUpManager = Object:extend()

function PowerUpManager:new(color)
  self.color = color or nil
  self.MaxCooldown = powerUpCooldown
  self.cooldown = 0
end
function PowerUpManager:update(dt,gameobject)
  if self.cooldown >= self.MaxCooldown then
    gameobject.transform.scale.x = 1.0
    if love.keyboard.isDown("space") then--Si le da a tecla sustituir  la pieza actual por esta
      self.cooldown = 0
    end
  else
    gameobject.transform.scale.y = 0.5
    gameobject.transform.scale.x = self.cooldown/self.MaxCooldown
    self.cooldown = self.cooldown + dt
  end
end

function PowerUpManager:Change(c, gameobject)
  gameobject.SpriteRenderer:changeImage(powerPiecesPaths[c])
end

function PowerUpManager:Demolish()--ROJO
end
function PowerUpManager:RandomizeC()--AZUL
end
function PowerUpManager:DestroyLine()--AMARILLO
end
function PowerUpManager:Slow()--VERDE
end
function PowerUpManager:Worm()--NARANJA
end
function PowerUpManager:Mark()--PURPURA(que lila no se usa en inglés
end
