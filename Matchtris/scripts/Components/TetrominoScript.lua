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
  for _,v in ipairs(self.grid) do
    for _,t in ipairs(v) do
      if t ~= 0 then
        table.insert(currentScene.lObjects, t)
      end
    end
  end
end
