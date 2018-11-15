PowerUpManager = Object:extend()

function PowerUpManager:new(color)
  self.color = color or nil
  self.MaxCooldown = powerUpCooldown
  self.cooldown = 0
  self.wait = false
  available = true
end
function PowerUpManager:update(dt,gameobject)
  if self.wait == false then
  if self.cooldown >= self.MaxCooldown then
    if available == true then pbarra:play() available = false end
    gameobject.transform.scale.x = 1.0
    if love.keyboard.isDown("space") then--Si le da a tecla sustituir  la pieza actual por esta
      if self.color == 1 then
        self:StopTime()
        self.wait = true
      else
        
        local levelManager = currentScene.levelManager:GetComponent(LevelManager)
        local gridX, gridY = levelManager.tetromino:GetOrigin() 
        
        levelManager:EraseTetromino()
        
        currentScene.tetromino = GameObject({TetrominoScript(false,8,true)},Transform())
        table.insert (currentScene.lObjects, currentScene.tetromino)
        
        levelManager.tetromino.grid[1][1].transform.position.y = (h/2 - currentScene.background.spriteRenderer.origin.y-1.5*pixelHeight) + gridX * pixelHeight
        levelManager.tetromino.grid[1][1].transform.position.x = (w/2 - currentScene.background.spriteRenderer.origin.x - pixelWidth * 0.5) + gridY * pixelWidth
        
        local pieceScript = levelManager.tetromino.grid[1][1]:GetComponent(PieceScript)
        
        pieceScript.color = self.color
        pieceScript.multiplier = 1.5
        pieceScript.gridRow, pieceScript.gridCol = gridX+1, gridY
        levelManager.tetromino.grid[1][1].spriteRenderer:changeImage(powerPiecesPaths[self.color])

        levelManager:UpdateTetrominoPieces()
        
      end
      available = true
      self.cooldown = 0
    end
  else
    gameobject.transform.scale.y = 0.6
    gameobject.transform.scale.x = self.cooldown/self.MaxCooldown
    self.cooldown = self.cooldown + dt
  end
  end
end

function PowerUpManager:Change(c, gameobject)
  gameobject.spriteRenderer:changeImage(powerBarPath[c])
  self.color = c
end

function PowerUpManager:Activate(color, gridRow, gridCol)
  if color == 2 then
    self:RandomizeC(gridRow, gridCol)
  end
  if color == 3 then
    self:Mark(gridRow)
  end
  if color == 4 then
    self:Worm()
  end
  if color == 5 then
    self:Demolish(gridRow, gridCol)
  end
  if color == 6 then
    self:DestroyLine(gridRow)
  end
end

function PowerUpManager:Demolish(gridRow, gridCol)--ROJO
  local levelManager = currentScene.levelManager:GetComponent(LevelManager)
  local t = {}
  for r = gridRow -1, gridRow +1,1 do
    for c = gridCol -1, gridCol+1,1 do
      if r >= 1 and r <= gridRows +2 and c >= 1 and c <= gridCols then
        if levelManager.grid[r][c] ~= nil then
          table.insert(t,levelManager.grid[r][c]:GetComponent(PieceScript))
        end
      end
    end
  end
  projo:play()
  levelManager:CalculatePoints(t)
  levelManager:StackTetromino()
end

function PowerUpManager:RandomizeC(gridRow, gridCol)--AZUL
  local levelManager = currentScene.levelManager:GetComponent(LevelManager)
  for r = gridRow -2, gridRow +2,1 do
    for c = gridCol -2, gridCol+2,1 do
      if r >= 1 and r <= gridRows +2 and c >= 1 and c <= gridCols then
        if levelManager.grid[r][c] ~= nil then
          local rand = math.random(1,6)
          levelManager.grid[r][c]:GetComponent(PieceScript).color = rand
          levelManager.grid[r][c].spriteRenderer:changeImage(piecesPaths[rand])
        end
      end
    end
  end
  pazul:play()
  levelManager:StackTetromino()
end

function PowerUpManager:StopTime()--AMARILLO
  timeStop:play()
  music:stop()
  local levelManager = currentScene.levelManager:GetComponent(LevelManager)
  levelManager.levelState = LevelState.TimeStop
end

function PowerUpManager:DestroyLine(gridRow)--VERDE
  local levelManager = currentScene.levelManager:GetComponent(LevelManager)
  local t = {}
  for c = 1, gridCols,1 do
      if levelManager.grid[gridRow][c] ~= nil then
        table.insert(t,levelManager.grid[gridRow][c]:GetComponent(PieceScript))
      end
  end
  pverde:play()
  levelManager:CalculatePoints(t)
  levelManager:StackTetromino()
end

function PowerUpManager:Worm()--NARANJA
  local levelManager = currentScene.levelManager:GetComponent(LevelManager)
  levelManager.levelState = LevelState.Worm
  pnaranja:play()
  self.wait = true
end

function PowerUpManager:Mark(gridRow)--PURPURA(que lila no se usa en inglés) (jaja vale)
  local levelManager = currentScene.levelManager:GetComponent(LevelManager)
  for c = 1, gridCols,1 do
    if levelManager.grid[gridRow][c] ~= nil then
      ps = levelManager.grid[gridRow][c]:GetComponent(PieceScript)
      ps.multiplier = 1.5
      levelManager.grid[gridRow][c].spriteRenderer:changeImage(powerPiecesPaths[ps.color])
    end
  end
  plila:play()
  levelManager:StackTetromino()
end


