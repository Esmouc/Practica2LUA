TetrominoScript = Object:extend()

function TetrominoScript:new(random, tetrominoType)
  
  if random then
    self.tetrominoType = math.random(1,7)
  else
    self.tetrominoType = tetrominoType
  end
  
  self.grid = tGrids[self.tetrominoType]  
  
  self:CreateTetromino()
  self:InstantiateTetromino()
  
end

function TetrominoScript:update(dt, gameobject)

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
  currentScene.levelManager:GetComponent(LevelManager):AddTetromino(self)
  for r,v in ipairs(self.grid) do
    for c,t in ipairs(v) do
      if t ~= 0 then
        table.insert(currentScene.lObjects, self.grid[r][c])
        ps = self.grid[r][c]:GetComponent(PieceScript)
        ps.gridRow = r
        ps.gridCol = c + gridCols/2 - 1
        self.grid[r][c].transform.position.y = ps.gridRow * pixelHeight
        self.grid[r][c].transform.position.x = ps.gridCol * pixelWidth
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
        self.grid[r][c].transform.position.y = ps.gridRow * pixelHeight
      end
    end
  end
end
