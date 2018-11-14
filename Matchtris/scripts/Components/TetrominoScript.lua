TetrominoScript = Object:extend()

function TetrominoScript:new(random, tetrominoType, powerUp)
  
  if random then
    self.tetrominoType = math.random(1,7)
  else
    self.tetrominoType = tetrominoType
  end
  
  self.grid = {}
  self.powerUp = false or powerUp
  
  self:InitGrid()
  self:CreateTetromino()
  self:InstantiateTetromino()
  
end

function TetrominoScript:update(dt, gameobject)

end

function TetrominoScript:InitGrid()
 for x,v in ipairs(tGrids[self.tetrominoType]) do
    t = {}
    for y,r in ipairs(v) do
      table.insert(t, r)
    end
    table.insert(self.grid, t)
  end
end

function TetrominoScript:CreateTetromino()
  local usedPieces = {}
  for r,v in ipairs(self.grid) do
    for c,t in ipairs(v) do
      if t == 1 then
        rand = math.random(1,6)
        while TableContains (usedPieces,rand) do
          rand = math.random(1,6)
        end
        self.grid[r][c] = GameObject({PieceScript(rand)},Transform(w/2,h/2),SpriteRenderer(piecesPaths[rand]))
        table.insert(usedPieces,rand)
      end
    end
  end
end

function TetrominoScript:InstantiateTetromino()
  for r,v in ipairs(self.grid) do
    for c,t in ipairs(v) do
      if t ~= 0 then
        table.insert(currentScene.lObjects, self.grid[r][c])
        currentScene.foreGround:destroy()
        currentScene.playerScore:destroy()
        currentScene.foreGround:destroy()
        currentScene.powerUpManager:destroy()
        table.insert(currentScene.lObjects, currentScene.foreGround)
        table.insert(currentScene.lObjects, currentScene.playerScore)
        table.insert(currentScene.lObjects, currentScene.powerUpManager)
        ps = self.grid[r][c]:GetComponent(PieceScript)
        ps.gridRow = r
        ps.gridCol = c + gridCols/2 - 1
        self.grid[r][c].transform.position.y = (h/2 - currentScene.background.spriteRenderer.origin.y-1.5*pixelHeight) + (r-1) * pixelHeight
        self.grid[r][c].transform.position.x = w/2 - pixelWidth * 0.5 + (c-1) * pixelWidth
      end
    end
  end
  currentScene.levelManager:GetComponent(LevelManager):AddTetromino(self)
end

function TetrominoScript:MovePieceUp()
  for r,v in ipairs(self.grid) do
    for c,t in ipairs(v) do
      if t ~= 0 then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        ps.gridRow = ps.gridRow - 1
        self.grid[r][c].transform.position.y = self.grid[r][c].transform.position.y - pixelHeight
      end
    end
  end
end
function TetrominoScript:MovePieceDown()
  for r,v in ipairs(self.grid) do
    for c,t in ipairs(v) do
      if t ~= 0 then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        ps.gridRow = ps.gridRow + 1
        self.grid[r][c].transform.position.y = self.grid[r][c].transform.position.y + pixelHeight
      end
    end
  end
end

function TetrominoScript:MovePieceLeft()
  for r,v in ipairs(self.grid) do
    for c,t in ipairs(v) do
      if t ~= 0 then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        ps.gridCol = ps.gridCol - 1
        self.grid[r][c].transform.position.x = self.grid[r][c].transform.position.x - pixelWidth
      end
    end
  end
end

function TetrominoScript:MovePieceRight()
  for r,v in ipairs(self.grid) do
    for c,t in ipairs(v) do
      if t ~= 0 then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        ps.gridCol = ps.gridCol + 1
        self.grid[r][c].transform.position.x = self.grid[r][c].transform.position.x + pixelWidth
      end
    end
  end
end

function TetrominoScript:Rotate()
  
  local row, col = 0,0
  
  for r,v in ipairs(self.grid) do
    row = row + 1
    for c,t in ipairs(v) do
      col = col + 1
    end
  end
  
  col = col/row
  
  local initRow, initCol
  
  for c = 1, col, 1 do
    if self.grid[1][c] ~= 0 then
      ps = self.grid[1][c]:GetComponent(PieceScript)
      initRow, initCol = ps.gridRow, ps.gridCol+1-c
      break
    end
  end

  local newGrid = {}
  
  for c = 1, col, 1 do
    t = {}
    for r = row, 1, -1 do
      table.insert (t, self.grid[r][c])
    end
    table.insert (newGrid, t)
  end
  
  self.grid = newGrid
  
  for r,v in ipairs(self.grid) do
    for c,t in ipairs(v) do
      if t ~= 0 then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        ps.gridRow = initRow + r
        ps.gridCol = initCol + c - 1
        self.grid[r][c].transform.position.y = (h/2 - currentScene.background.spriteRenderer.origin.y-1.5*pixelHeight) + (r-1+initRow) * pixelHeight
        self.grid[r][c].transform.position.x = (w/2 - currentScene.background.spriteRenderer.origin.x - pixelWidth * 0.5) + (c-1+initCol) * pixelWidth 
      end
    end
  end
  
end

function TetrominoScript:GetOrigin()
  
  for r,v in ipairs(self.grid) do
    for c,_ in ipairs(v) do
      if self.grid[r][c] ~= 0 then
        ps = self.grid[r][c]:GetComponent(PieceScript)
        return ps.gridRow, ps.gridCol+1-c
      end
    end
  end
  
  return 0,0
  
end

