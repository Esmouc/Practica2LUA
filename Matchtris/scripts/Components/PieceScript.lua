PieceScript = Object:extend()

function PieceScript:new(color)
  self.color = color
  self.multiplier = 1.0
  self.gridRow = 0
  self.gridCol = 0
  self.stacked = false
  self.moving = false
  self.stackedBrothers = {self}
end

function PieceScript:update(dt, gameobject)

end

function PieceScript:MoveDown()
  if self.stacked == true then
    if self.gridRow ~= gridRows + 2 then
      piece = currentScene.levelManager:GetComponent(LevelManager).grid[self.gridRow][self.gridCol]
      nextpiece = currentScene.levelManager:GetComponent(LevelManager).grid[self.gridRow+1][self.gridCol]
      if nextpiece ~= nil then
        if nextpiece:GetComponent(PieceScript).moving == true then
          self.moving = true
          self.gridRow = self.gridRow + 1
          piece.transform.position.y = piece.transform.position.y + pixelHeight
        else
          self.moving = false
        end
      else
        self.moving = true
        self.gridRow = self.gridRow + 1
        piece.transform.position.y = piece.transform.position.y + pixelHeight
      end
    else
      self.moving = false
    end
  end
end

function PieceScript:UpdateBrothers(ps)
  local alreadyBrother = false
  
  for _, v in ipairs(self.stackedBrothers) do
    if v == ps then alreadyBrother = true end
  end
  
  if alreadyBrother == false then
    table.insert(self.stackedBrothers,ps)
    for _, v in ipairs(self.stackedBrothers) do
      v.stackedBrothers = self.stackedBrothers
    end
  end
end

function PieceScript:CountBrothers()
  local count = 0
  
  for _, v in ipairs(self.stackedBrothers) do
    count = count + 1
  end
  
  return count
  
end



