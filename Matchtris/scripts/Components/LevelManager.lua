LevelManager = Object:extend()

LevelState = {Tetromino = 0, Stack = 1, Match = 2, TimeStop = 3, Worm = 4}

function LevelManager:new()
  self.grid = {{}}
  self.time = fallTime
  self.scrollTime = scrollTime
  self.downtimer = 0
  self.scrolltimer = 0
  self.wormCount = 0
  self.lastwormdir = 1
  self.downdivide = 1
  self.arrowPressed = false
  self.tetromino = nil
  self.pause = false
  self:InitGrid()
end

function LevelManager:update(dt, gameobject)
  
  if self.pause == false then
    
    if self.levelState == LevelState.Tetromino then
      
      if self.time <= 0.05 then
        self.time = 0.05
      else
        self.time = self.time - dt*0.002
      end
        
      self.downtimer = self.downtimer + dt
      
      if self.downtimer >= self.time/self.downdivide then
        --self:PrintGrid()
        self:MovePieceDown()
        self.downtimer = 0
      end
      
      if love.keyboard.isDown ("right") then
        if self.scrolltimer >= self.scrollTime then
          self:MovePieceRight()
          self.scrolltimer = 0
          self.scrollTime = scrollTime
        else
          self.scrolltimer = self.scrolltimer + dt
        end
      end
      
      if love.keyboard.isDown ("left") then
        if self.scrolltimer >= self.scrollTime then
          self:MovePieceLeft()
          self.scrollTime = scrollTime
          self.scrolltimer = 0
        else
          self.scrolltimer = self.scrolltimer + dt
        end
      end
      
      if love.keyboard.isDown ("down") then
        self.downdivide = 20
      else
        self.downdivide = 1
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
      
    elseif self.levelState == LevelState.TimeStop then
      
      if love.keyboard.isDown ("up") then
        if self.scrolltimer >= self.scrollTime then
          self.tetromino:MovePieceUp()
          self.scrolltimer = 0
          self.scrollTime = scrollTime
        else
          self.scrolltimer = self.scrolltimer + dt
        end
      end
      
       if love.keyboard.isDown ("right") then
        if self.scrolltimer >= self.scrollTime then
          self.tetromino:MovePieceRight()
          self.scrolltimer = 0
          self.scrollTime = scrollTime
        else
          self.scrolltimer = self.scrolltimer + dt
        end
      end
      
      if love.keyboard.isDown ("left") then
        if self.scrolltimer >= self.scrollTime then
          self.tetromino:MovePieceLeft()
          self.scrolltimer = 0
        else
          self.scrolltimer = self.scrolltimer + dt
        end
      end
      
      if love.keyboard.isDown ("down") then
        if self.scrolltimer >= self.scrollTime then
          self.tetromino:MovePieceDown()
          self.scrollTime = scrollTime
          self.scrolltimer = 0
        else
          self.scrolltimer = self.scrolltimer + dt
        end
      end
      
    elseif self.levelState == LevelState.Worm then

      if self.scrolltimer >= self.scrollTime then
        local rand = math.random (1,2)
        
        if rand == 1 then
          self.tetromino:MovePieceDown()
          self.lastwormdir = 1
        end
        if rand == 2 then
          if self.lastwormdir == 1 then
            rand = math.random (1,2)
            if rand == 1  then
              self.tetromino:MovePieceRight()
              self.lastwormdir = 2
            elseif rand == 2 then
              self.tetromino:MovePieceLeft()
              self.lastwormdir = 3
            end
          elseif self.lastwormdir == 2 then
            self.tetromino:MovePieceRight()
          else
            self.tetromino:MovePieceLeft()
          end
        end
      
        self:UpdateTimeStopPieces()
        self.scrollTime = scrollTime
        self.scrolltimer = 0
        self.wormCount = self.wormCount + 1
      else
        self.scrolltimer = self.scrolltimer + dt
      end
      
      if self.wormCount == 8 then
        self.levelState = LevelState.Tetromino
        self.wormCount = 0
        self:StackTetromino()
        currentScene.powerUpManager:GetComponent(PowerUpManager).wait = false
      end
    end
  end
end

function LevelManager:keypressed(key)
    if self.pause == false then
  if self.levelState == LevelState.Tetromino then
    
    if key == "right"then
      self:MovePieceRight()
      self.scrollTime = scrollTime * 10
      self.scrolltimer = 0
    end
    
    if key == "left" then
      self:MovePieceLeft()
      self.scrollTime = scrollTime * 10
      self.scrolltimer = 0
    end
    
    if key == "up" then
      self:RotatePiece()
    end
    
  end
  
  if self.levelState == LevelState.TimeStop then
    
    if key == "space" then
      timeStop:play()
      music:play()
      self.levelState = LevelState.Tetromino
      currentScene.powerUpManager:GetComponent(PowerUpManager).wait = false
      self:UpdateTimeStopPieces()
    end
    
  end
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
          currentScene.powerUpManager:GetComponent(PowerUpManager):Change(ps.color,currentScene.powerUpManager)
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
  auxScore = math.floor (auxScore * multiplier)
  playerScore = playerScore + auxScore
  currentScene.playerScore.value = playerScore
end

function LevelManager:RotatePiece()
  if self.tetromino ~= nil then
    self.tetromino:Rotate()
    rotateSound:stop()
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
  io.write("*********************************************")
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

function LevelManager:UpdateTimeStopPieces()
  
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
        if ps.gridCol >= 1 and ps.gridCol <= gridCols and ps.gridRow >= 1 and ps.gridRow <= gridRows+2 then
          if self.grid[ps.gridRow][ps.gridCol] ~= nil then 
            self.grid[ps.gridRow][ps.gridCol]:destroy()
          end
          self.grid[ps.gridRow][ps.gridCol] = self.tetromino.grid[r][c]
        end
      end
    end
  end

end

function LevelManager:EraseTetromino()
  
  for r=gridRows+2,1,-1 do
    for c=gridCols,1,-1 do
      if self.grid[r][c] ~= nil then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        if ps.stacked == false then
          self.grid[r][c]:destroy()
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
                music:stop()
                changeState(GameStates.ranking)
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
    if self.tetromino.powerUp then
      piece = self.tetromino.grid[1][1]:GetComponent(PieceScript)
      currentScene.powerUpManager:GetComponent(PowerUpManager):Activate(piece.color, piece.gridRow, piece.gridCol)
    else
      self:StackTetromino()
    end
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