LevelManager = Object:extend()

local LevelState = {Tetromino = 0, Stack = 1, Match = 2, PowerUp = 3}

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
  
  if self.levelState == LevelState.Tetromino then
  
    self.downtimer = self.downtimer + dt
    
    if self.downtimer >= self.time then
      --self:PrintGrid()
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
    elseif love.keyboard.isDown ("up") then
      if arrowPressed == false then
        self:RotatePiece()
      end
      arrowPressed = true
    else
      arrowPressed = false
    end
    
    if love.keyboard.isDown ("down") then
      self.time = fallTime/20
    else
      self.time = fallTime
    end
  
  elseif self.levelState == LevelState.Stack then
  
    self.downtimer = self.downtimer + dt
    
    if self.downtimer >= fallTime/40 then
      
      self:MovePieces()
      self:UpdateGridPieces()
      
      if self:PiecesMoving() == false then
        self.levelState = LevelState.Match
      end
      
      self.downtimer = 0
      
    end
    
  elseif self.levelState == LevelState.Match then
    
    self:CheckMatches()
    
  elseif self.levelState == LevelState.PowerUp then
  
  end  

end

function LevelManager:CheckMatches()
  local match = false
  
  for r=1,gridRows+2,1 do
    for c=1,gridCols,1 do
      if self.grid[r][c] ~= nil then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        self:CheckPieceBrothers(ps)
      end
    end  
  end
  
  for r=1,gridRows+2,1 do
    for c=1,gridCols,1 do
      if self.grid[r][c] ~= nil then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        if ps:CountBrothers() >= 3 then
          self:CalculatePoints(ps.stackedBrothers)
          match = true
        end
      end
    end  
  end
  
  if match then self.levelState = LevelState.Stack else self:TetrominoSpawn() end
  if match then matchSound:play() end
  
end

function LevelManager:CalculatePoints(pieceArray)
  local count = 0 
  local auxScore = 0
  local multiplier = 1
  
  for _,v in ipairs(pieceArray) do
    count = count + 1
    auxScore = auxScore + 100 * v.multiplier
    if count > 3 then
      multiplier = multiplier * 1.5
    end
    self.grid[v.gridRow][v.gridCol]:destroy()
    self.grid[v.gridRow][v.gridCol] = nil
  end
  
  playerScore = playerScore + auxScore * multiplier
  currentScene.playerScore.value = playerScore
end

function LevelManager:RotatePiece()
  if self.tetromino ~= nil then
    self.tetromino:Rotate()
    rotateSound:play()
    self:UpdateTetrominoPieces()
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
    self:UpdateTetrominoPieces()
  end
end

function LevelManager:MovePieceLeft()
  if self.tetromino ~= nil then
    if self:CheckLeftCollision() then
      self.tetromino:MovePieceLeft()
      self:UpdateTetrominoPieces()
    end
  end
end

function LevelManager:MovePieceRight()
  if self.tetromino ~= nil then
    if self:CheckRightCollision() then
      self.tetromino:MovePieceRight()
      self:UpdateTetrominoPieces()
    end
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

end

function LevelManager:UpdateTetrominoPieces()
  
  for r=gridRows+2,1,-1 do
    for c=gridCols,1,-1 do
      if self.grid[r][c] ~= nil then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        if ps.stacked == false then
          self.grid[r][c] = nil
        end
      end
    end  
  end
  
  for r,v in ipairs(self.tetromino.grid) do
    for c,t in ipairs(v) do
      if t ~= 0 then
        ps = self.tetromino.grid[r][c]:GetComponent(PieceScript)
        self.grid[ps.gridRow][ps.gridCol] = self.tetromino.grid[r][c]
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
          elseif self.grid[ps.gridRow][ps.gridCol-1] ~= nil then
            if self.grid[ps.gridRow][ps.gridCol-1]:GetComponent(PieceScript).stacked == true then
              return false
            end
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
          elseif self.grid[ps.gridRow][ps.gridCol+1] ~= nil then
            if self.grid[ps.gridRow][ps.gridCol+1]:GetComponent(PieceScript).stacked == true then
              return false
            end
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
              if ps.gridRow == 2 then
                changeState(GameStates.End)
              else
                tetrominoStacked = true;
              end
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

function LevelManager:GetTetrominoCoord()
  for r=1,gridRows+2,1 do
    for c=1,gridCols,1 do
      if self.grid[r][c] ~= nil then
        if self.grid[r][c]:GetComponent(PieceScript).stacked == false then
          return r,c
        end
      end
    end
  end
end

function LevelManager:TetrominoSpawn()
  currentScene.tetromino = GameObject({TetrominoScript(true)},Transform())
  table.insert (currentScene.lObjects, currentScene.tetromino)
  self.levelState = LevelState.Tetromino
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
  self.levelState = LevelState.Stack
  clackSound:play()
  currentScene.tetromino:destroy()
end

function LevelManager:CheckPieceBrothers(ps)
  if ps.gridRow > 1 then
    if self.grid[ps.gridRow-1][ps.gridCol] ~= nil then
      brotherPs = self.grid[ps.gridRow-1][ps.gridCol]:GetComponent(PieceScript)
      if brotherPs.color == ps.color then
        ps:UpdateBrothers(brotherPs)
      end
    end
  end
  if ps.gridRow < gridRows+2 then
    if self.grid[ps.gridRow+1][ps.gridCol] ~= nil then
      brotherPs = self.grid[ps.gridRow+1][ps.gridCol]:GetComponent(PieceScript)
      if brotherPs.color == ps.color then
        ps:UpdateBrothers(brotherPs)
      end
    end
  end
  if ps.gridCol > 1 then
    if self.grid[ps.gridRow][ps.gridCol-1] ~= nil then
      brotherPs = self.grid[ps.gridRow][ps.gridCol-1]:GetComponent(PieceScript)
      if brotherPs.color == ps.color then
        ps:UpdateBrothers(brotherPs)
      end
    end
  end
  if ps.gridCol < gridCols then
    if self.grid[ps.gridRow][ps.gridCol+1] ~= nil then
      brotherPs = self.grid[ps.gridRow][ps.gridCol+1]:GetComponent(PieceScript)
      if brotherPs.color == ps.color then
        ps:UpdateBrothers(brotherPs)
      end
    end
  end
end