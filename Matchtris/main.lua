GameStates = {gameplay = 0, splash = 1, menu = 2, skins = 3, ranking = 4}
SkinSelected = {Normal = 0, Cats = 1}

skinSelected = SkinSelected.Normal
playerScore = 0
gameScene = 0

function love.load(arg)
  
  --if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
   
  math.randomseed(os.time())
   
  --LIBRARIES
  Object = require "lib/object"
  require "lib/vector"
  require "lib/Utils"
  
  -- SCENES
  require "scenes/LevelScene"
  require "scenes/SkinScene"
  require "scenes/MenuScene"
  require "scenes/RankingScene"
  require "scenes/SplashScene"

  -- MAIN CLASSES
  require "lib/unity/GameObject"
  require "lib/unity/SpriteRenderer"
  require "lib/unity/Transform"
  
  -- UI
  require "scripts/UI/Text"
  require "scripts/UI/Button"
  
  -- COMPONENTS
  require "scripts/Components/LevelManager"
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
    if gameScene ~= 0 then
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
  if newState == GameStates.skins then
    gameState = GameStates.skins
    currentScene = SkinScene()
  end
  if newState == GameStates.ranking then
    gameState = GameStates.ranking
    currentScene = RankingScene()
  end
  

  currentScene:Load()
  
end

function love.keypressed(key)
   currentScene:keypressed(key)
end

function love.textinput(t)
  if gameState == GameStates.ranking then
    currentScene:textinput(t)
  end
end
