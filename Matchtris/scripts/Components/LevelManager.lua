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
      self:PrintGrid()
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
  
  else
    self.downtimer = self.downtimer + dt
    
    if self.downtimer >= self.time/20 then
      
      self:MovePieces(0)
      self:UpdateGridPieces(0)
      
      if self:PiecesMoving() == false then
        self:TetrominoSpawn()
      end
      
      self.downtimer = 0
      
    end
    
  end
  
end

function LevelManager:MovePieces()
   for r=1,gridRows+2,1 do
    for c=1,gridCols,1 do
      if self.grid[r][c] ~= nil then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        if ps.stacked == true then
          ps:MoveDown()
        end
      end
    end  
  end
end

function LevelManager:PrintGrid()
  
  for r=1,gridRows+2,1 do
    local t = {}
    for c=1,gridCols,1 do
      if self.grid[r][c] ~= nil then
        io.write ("1 ")
      else
        io.write ("0 ")
      end
    end  
    io.write("\n")
  end
  
end

function LevelManager:PiecesMoving()
  
  for r=1,gridRows+2,1 do
    for c=1,gridCols,1 do
      if self.grid[r][c] ~= nil then
        if self.grid[r][c]:GetComponent(PieceScript).moving == true then
          return true
        end
      end
    end  
  end
  return false
end

function LevelManager:MovePieceDown()
  if self:CheckDownCollision() then
    self.tetromino:MovePieceDown()
    self:UpdateGridPieces(0)
  end
end

function LevelManager:MovePieceLeft()
  if self:CheckLeftCollision() then
    self.tetromino:MovePieceLeft()
    self:UpdateGridPieces(1)
  end
end

function LevelManager:MovePieceRight()
  if self:CheckRightCollision() then
    self.tetromino:MovePieceRight()
    self:UpdateGridPieces(0)
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

function LevelManager:UpdateGridPieces(direction)
  
  if direction == 0 then
  
    for r=gridRows+2,1,-1 do
      for c=gridCols,1,-1 do
        if self.grid[r][c] ~= nil then
          ps = self.grid[r][c]:GetComponent(PieceScript)
          if ps.gridCol ~= c or ps.gridRow ~= r then
            self.grid[ps.gridRow][ps.gridCol] = self.grid[r][c]
            self.grid[r][c] = nil
          end
        end
      end  
    end
    
  elseif direction == 1 then
     for r=gridRows+2,1,-1 do
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

function LevelManager:CheckDownCollision()
  
  local tetrominoStacked = false
  
  for r=gridRows+2,1,-1 do
    for c=gridCols,1,-1 do
      if self.grid[r][c] ~= nil then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        if ps.stacked == false then
          if ps.gridRow == gridRows + 2 then
            tetrominoStacked = true;
          elseif self.grid[ps.gridRow+1][ps.gridCol] ~= nil then
            if self.grid[ps.gridRow+1][ps.gridCol]:GetComponent(PieceScript).stacked == true then
              tetrominoStacked = true;
            end
          end
        end
      end
    end  
  end
  
  if tetrominoStacked == true then
    self:StackTetromino()
  end
  
  return not tetrominoStacked
  
end

function LevelManager:TetrominoSpawn()
  currentScene.tetromino = GameObject({TetrominoScript(true)},Transform())
  table.insert (currentScene.lObjects, currentScene.tetromino)
end

function LevelManager:StackTetromino()
  if self.tetromino ~= nil then
    for r,v in ipairs(self.tetromino.grid) do
      for c,t in ipairs(v) do
        if t ~= 0 then
          ps = self.tetromino.grid[r][c]:GetComponent(PieceScript)
          ps.stacked = true
        end
      end
    end
  end
  self.tetromino = nil
  currentScene.tetromino:destroy()
end