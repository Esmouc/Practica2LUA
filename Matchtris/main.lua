GameStates = {gameplay = 0, splash = 1, menu = 2, End = 3, ranking = 4, pause = 5}

playerScore = 0

function love.load(arg)
  
  if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
   
  math.randomseed(os.time())
   
  --LIBRARIES
  Object = require "lib/object"
  require "lib/vector"
  require "lib/Utils"
  
  -- SCENES
  require "scenes/LevelScene"
  require "scenes/EndScene"
  require "scenes/MenuScene"
  require "scenes/RankingScene"
  require "scenes/SplashScene"
  require "scenes/PauseScene"
  -- MAIN CLASSES
  require "lib/unity/GameObject"
  require "lib/unity/SpriteRenderer"
  require "lib/unity/Transform"
  
  -- UI
  require "scripts/UI/Text"
  require "scripts/UI/Button"
  
  -- COMPONENTS
  require "scripts/Components/LevelManager"
  require "scripts/Components/BarScript"
  require "scripts/Components/PieceScript"
  require "scripts/Components/TetrominoScript"
  require "scripts/Components/PowerUpManager"
  
  -- GAME DATA
  require "data"
  
  -- LOAD FONTS
  
  -- LOAD SCENES
  
  changeState(GameStates.splash)

  -- SETTING GAME STATE
  
end

function love.update(dt)
  
  currentScene:update(dt)

end

function love.draw()
 
  currentScene:draw()
  
end

function changeState(newState)
  
  if newState == GameStates.gameplay then
    gameState = GameStates.gameplay
    if gameScene ~= nil then
      currentScene = gameScene
    else
      currentScene = LevelScene()
    end
  end
  if newState == GameStates.splash then
    gameState = GameStates.splash
    currentScene = SplashScene()
  end
  if newState == GameStates.menu then
    gameState = GameStates.menu
    currentScene = MenuScene()
  end
  if newState == GameStates.End then
    gameState = GameStates.End
    currentScene = EndScene()
  end
  if newState == GameStates.ranking then
    gameState = GameStates.ranking
    currentScene = RankingScene()
  end
  if newState == GameStates.pause then
    gameState = GameStates.pause
    gameScene = currentScene
    currentScene = PauseScene()
  end
  

  currentScene:Load()
  
end

function love.keypressed(key)
   currentScene:keypressed(key)
end
