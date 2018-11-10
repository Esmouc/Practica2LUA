LevelManager = Object:extend()

function LevelManager:new()
  self.grid = {{}}
  self.time = fallTime
  self.scrollTime = scrollTime
  self.downtimer = 0
  self.scrolltimer = 0
  self.arrowPressed = false
  self.tetromino = nil
  self:InitGrid()
end

function LevelManager:update(dt, gameobject)
  
  if self.tetromino ~= nil then
  
    self.downtimer = self.downtimer + dt
    
    if self.downtimer >= self.time then
      self:MovePieceDown()
      self.downtimer = 0
    end
    
    if love.keyboard.isDown ("right") then
      if arrowPressed == false then
        self:MovePieceRight()
      elseif self.scrolltimer >= self.scrollTime then
        self:MovePieceRight()
        self.scrolltimer = 0
      else
        self.scrolltimer = self.scrolltimer + dt
      end
      arrowPressed = true
    elseif love.keyboard.isDown ("left") then
      if arrowPressed == false then
        self:MovePieceLeft()
      elseif self.scrolltimer >= self.scrollTime then
        self:MovePieceLeft()
        self.scrolltimer = 0
      else
        self.scrolltimer = self.scrolltimer + dt
      end
      arrowPressed = true
    else
      self.scrolltimer = 0
      arrowPressed = false
    end
    
    if love.keyboard.isDown ("down") then
      self.time = fallTime/10
    else
      self.time = fallTime
    end
  
  end
  
end

function LevelManager:MovePieceDown()
  if self:CheckBottomCollision() then
  self.tetromino:MovePieceDown()
  self:UpdateGridPieces()
  end
end

function LevelManager:MovePieceLeft()
  if self:CheckLeftCollision() then
  self.tetromino:MovePieceLeft()
  self:UpdateGridPieces()
  end
end

function LevelManager:MovePieceRight()
  if self:CheckRightCollision() then
    self.tetromino:MovePieceRight()
    self:UpdateGridPieces()
  end
end

function LevelManager:InitGrid()
  for r=1,gridRows+2,1 do
    local t = {}
    for c=1,gridCols,1 do
      table.insert(t,nil)
    end  
    table.insert(self.grid,t)
  end
end

function LevelManager:AddTetromino(tetromino)
  self.tetromino = tetromino
  for r,v in ipairs(self.tetromino.grid) do
    for c,t in ipairs(v) do
      if t ~= 0 then
        ps = self.tetromino.grid[r][c]:GetComponent(PieceScript)
        self.grid[ps.gridRow][ps.gridCol] = self.tetromino.grid[r][c]
      end
    end
  end
end

function LevelManager:UpdateGridPieces()
  for r=1,gridRows+2,1 do
    for c=1,gridCols,1 do
      if self.grid[r][c] ~= nil then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        if ps.gridCol ~= c or ps.gridRow ~= r then
          self.grid[ps.gridRow][ps.gridCol] = self.grid[r][c]
          self.grid[r][c] = nil
        end
      end
    end  
  end
end

function LevelManager:CheckLeftCollision()
  if self.tetromino ~= nil then
    for r,v in ipairs(self.tetromino.grid) do
      for c,t in ipairs(v) do
        if t ~= 0 then
          ps = self.tetromino.grid[r][c]:GetComponent(PieceScript)
          if ps.gridCol == 1 then
            return false
          end
        end
      end
    end
  end
  return true
end

function LevelManager:CheckRightCollision()
  if self.tetromino ~= nil then
    for r,v in ipairs(self.tetromino.grid) do
      for c,t in ipairs(v) do
        if t ~= 0 then
          ps = self.tetromino.grid[r][c]:GetComponent(PieceScript)
          if ps.gridCol == gridCols then
            return false
          end
        end
      end
    end
  end
  return true
end

function LevelManager:CheckBottomCollision()
  if self.tetromino ~= nil then
    for r,v in ipairs(self.tetromino.grid) do
      for c,t in ipairs(v) do
        if t ~= 0 then
          ps = self.tetromino.grid[r][c]:GetComponent(PieceScript)
          if ps.gridRow == gridRows + 2 then
            self.tetromino = nil
            currentScene.tetromino:destroy()
            self:TetrominoSpawn()
            return false
          end
        end
      end
    end
  end
  return true
end

function LevelManager:TetrominoSpawn()
  currentScene.tetromino = GameObject({TetrominoScript(true)},Transform())
  table.insert (currentScene.lObjects, currentScene.tetromino)
end