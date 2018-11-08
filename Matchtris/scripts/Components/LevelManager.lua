LevelManager = Object:extend()

function LevelManager:new()
  self.grid = {{}}
  self:InitGrid()
end

function LevelManager:update(dt, gameobject)
  
  currentScene.playerScore.value = currentScene.playerScore.value + 100
  
end

function LevelManager:InitGrid()
  for r=1,gridRows,1 do
    local t = {}
    for c=1,gridCols,1 do
      table.insert(t,nil)
    end  
  end
end