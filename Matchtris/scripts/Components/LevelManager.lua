LevelManager = Object:extend()

function LevelManager:new()
  self.grid = {{}}
  self.time = fallTime
  self.timer = 0
  self.tetromino = nil
  self:InitGrid()
end

function LevelManager:update(dt, gameobject)
  
  if self.tetromino ~= nil then
  
    self.timer = self.timer + dt
    
    if self.timer >= self.time then
      self.tetromino:MovePieceDown()
      self.timer = 0
    end
  end
  
end

function LevelManager:InitGrid()
  for r=1,gridRows,1 do
    local t = {}
    for c=1,gridCols,1 do
      table.insert(t,nil)
    end  
  end
end

function LevelManager:AddTetromino(tetromino)
  self.tetromino = tetromino
end