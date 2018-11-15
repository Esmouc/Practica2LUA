PieceScript = Object:extend()

function PieceScript:new(color)
  self.color = color
  self.multiplier = 1.0
  self.gridRow = 0
  self.gridCol = 0
  self.stacked = false
  self.moving = false
  self.smiling = false
  self.fadeOut = false
  self.timer = 0
  self.stackedBrothers = {self}
end

function PieceScript:update(dt, gameobject)

  if skinSelected == SkinSelected.Cats and self.smiling == false then
    if math.random(0,100) == 0 then
      if self.multiplier == 1.0 then
        gameobject.spriteRenderer:changeImage(catSmilesPath[self.color])
      else
        gameobject.spriteRenderer:changeImage(catSmilesPowerPath[self.color])
      end
      self.smiling = true
    end
  end
  
  if self.smiling == true then
    self.timer = self.timer + dt
    if self.timer >= 0.7 then
      if self.multiplier == 1.0 then
        gameobject.spriteRenderer:changeImage(piecesPaths[self.color])
      else
        gameobject.spriteRenderer:changeImage(powerPiecesPaths[self.color])
      end
       self.smiling = false
       self.timer = 0
    end
  end
  
  if self.fadeOut == true then
    gameobject.transform.scale.x = gameobject.transform.scale.x - 2*dt
    gameobject.transform.scale.y = gameobject.transform.scale.y - 2*dt
    
    if gameobject.transform.scale.x <= 0 then
      gameobject:destroy()
      local levelManager = currentScene.levelManager:GetComponent(LevelManager)
      levelManager.grid[self.gridRow][self.gridCol] = nil
      if levelManager.levelState ~= LevelState.Stack and levelManager.pause == true then
        currentScene.levelManager:GetComponent(LevelManager):StackTetromino()
        currentScene.levelManager:GetComponent(LevelManager).pause = false
      end
    end
  end

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



