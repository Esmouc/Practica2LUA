PieceScript = Object:extend()

function PieceScript:new(color)
  self.color = color
  self.multiplier = 1.0
  self.gridRow = 0
  self.gridCol = 0
  self.stacked = false
  self.moving = false
end

function PieceScript:update(dt, gameobject)
  
end

function PieceScript:MoveDown()
  if self.stacked == true then
    if self.gridRow ~= gridRows + 2 then
      print "HOI"
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



