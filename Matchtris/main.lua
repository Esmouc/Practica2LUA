
GameStates = {gameplay = 0}

function love.load(arg)
  
   if arg[#arg] == "-debug" then require("mobdebug").start() end -- Enable the debugging with ZeroBrane Studio
   
   math.randomseed(os.time())
   
  --LIBRARIES
  Object = require "lib/object"
  require "lib/vector"
  require "lib/Utils"
  
  -- SCENES
  require "scenes/LevelScene"
  
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
  
  -- GAME DATA
  require "data"
  
  -- LOAD FONTS
  
  -- LOAD SCENES
  
  currentScene = LevelScene()
  currentScene:Load()

  -- SETTING GAME STATE
  gameState = GameStates.gameplay
  
end

function love.update(dt)
  
  currentScene:update(dt)

end

function love.draw()
 
  currentScene:draw()
  
end