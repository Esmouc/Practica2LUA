PowerUpScript = Object:extend()

function PowerUpScript:new()
  self.color = nil
  self.MaxCooldown = 60
  self.cooldown = 0
end
function PowerUpScript:update(dt)
  if self.cooldown == self.MaxCooldown then
    if love.keyboard.isDown("space") then--Si le da a tecla sustituir  la pieza actual por esta
      --Generar pieza power up de color X
      self.cooldown = 0
    end
  else
    self.cooldown = self.cooldown + dt
  end
end

function PowerUpScript:Change(c, gameobject)
  if c == color.red then
    self.color = color.red
    gameobject.SpriteRenderer.image = redPiece
    
  elseif c == color.blue then
    self.color = color.blue
    gameobject.SpriteRenderer.image = bluePiece
    
  elseif c == color.yellow then
    self.color = color.yellow
    gameobject.SpriteRenderer.image = yellowPiece
    
  elseif c == color.green then
    self.color = color.green
    gameobject.SpriteRenderer.image = greenPiece
    
  elseif c == color.orange then
    self.color = color.orange
    gameobject.SpriteRenderer.image = orangePiece
    
  elseif c == color.purple then
    self.color = color.purple
    gameobject.SpriteRenderer.image = purplePiece
  end
end

function PowerUpScript:Demolish()--ROJO
end
function PowerUpScript:RandomizeC()--AZUL
end
function PowerUpScript:DestroyLine()--AMARILLO
end
function PowerUpScript:Slow()--VERDE
end
function PowerUpScript:Worm()--NARANJA
end
function PowerUpScript:Mark()--PURPURA(que lila no se usa en inglés
end
