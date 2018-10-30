LevelManager = Object:extend()

function LevelManager:new()

end

function LevelManager:update(dt, gameobject)
  
  levelScene.playerScore.value = levelScene.playerScore.value + 100
  
end