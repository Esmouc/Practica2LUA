RankingScene = Object:extend()

function RankingScene:new()
  self.lObjects = {}
end

function RankingScene:Load()
  self.lObjects = {}
  
  self.scoreIndex = -1
  self.inputLetters = 0
  
  -- GAME OBJECTS
  self.submit = Button(self.Submit, 75, h/2 +170, font, "Submit")
  self.lbText = Text(w/2,50,-300,0,600,"center", font,"LEADERBOARD")
  -- NUMBERS
  self.one = Text(70,120,0,0,100,"left", smallfont,"1.")
  self.two = Text(70,150,0,0,100,"left", smallfont,"2.")
  self.three = Text(70,180,0,0,100,"left", smallfont,"3.")
  self.four = Text(70,210,0,0,100,"left", smallfont,"4.")
  self.five = Text(70,240,0,0,100,"left", smallfont,"5.")
  self.six = Text(70,270,0,0,100,"left", smallfont,"6.")
  self.seven = Text(70,300,0,0,100,"left", smallfont,"7.")
  self.eight = Text(70,330,0,0,100,"left", smallfont,"8.")
  self.nine = Text(70,360,0,0,100,"left", smallfont,"9.")
  self.ten = Text(70,390,0,0,100,"left", smallfont,"10.")
  
  --NAMES
  
  self.scoreNames = {}
  
  table.insert(self.scoreNames,Text(120,120,0,0,100,"left", smallfont,"AAA"))
  table.insert(self.scoreNames,Text(120,150,0,0,100,"left", smallfont,"AAA"))
  table.insert(self.scoreNames,Text(120,180,0,0,100,"left", smallfont,"AAA"))
  table.insert(self.scoreNames,Text(120,210,0,0,100,"left", smallfont,"AAA"))
  table.insert(self.scoreNames,Text(120,240,0,0,100,"left", smallfont,"AAA"))
  table.insert(self.scoreNames,Text(120,270,0,0,100,"left", smallfont,"AAA"))
  table.insert(self.scoreNames,Text(120,300,0,0,100,"left", smallfont,"AAA"))
  table.insert(self.scoreNames,Text(120,330,0,0,100,"left", smallfont,"AAA"))
  table.insert(self.scoreNames,Text(120,360,0,0,100,"left", smallfont,"AAA"))
  table.insert(self.scoreNames,Text(120,390,0,0,100,"left", smallfont,"AAA"))
  
  -- SCORE
  
  self.scoreValues = {}
  
  table.insert(self.scoreValues,Text(220,120,0,0,100,"left", smallfont,"100000"))
  table.insert(self.scoreValues,Text(220,150,0,0,100,"left", smallfont,"100000"))
  table.insert(self.scoreValues,Text(220,180,0,0,100,"left", smallfont,"100000"))
  table.insert(self.scoreValues,Text(220,210,0,0,100,"left", smallfont,"100000"))
  table.insert(self.scoreValues,Text(220,240,0,0,100,"left", smallfont,"100000"))
  table.insert(self.scoreValues,Text(220,270,0,0,100,"left", smallfont,"100000"))
  table.insert(self.scoreValues,Text(220,300,0,0,100,"left", smallfont,"100000"))
  table.insert(self.scoreValues,Text(220,330,0,0,100,"left", smallfont,"100000"))
  table.insert(self.scoreValues,Text(220,360,0,0,100,"left", smallfont,"100000"))
  table.insert(self.scoreValues,Text(220,390,0,0,100,"left", smallfont,"100000"))
  
  -- SCORE
  
  self.writeText = Text(50,450,0,0,300,"center", smallfont,"Write your initials.")
  
  self.background = GameObject({},Transform(w/2,h/2), SpriteRenderer(pausePath))

  -- INSERTAMOS LOS OBJETOS A LA ESCENA
  table.insert (self.lObjects, self.background)
  table.insert (self.lObjects, self.one)
  table.insert (self.lObjects, self.two)
  table.insert (self.lObjects, self.three)
  table.insert (self.lObjects, self.four)
  table.insert (self.lObjects, self.five)
  table.insert (self.lObjects, self.six)
  table.insert (self.lObjects, self.seven)
  table.insert (self.lObjects, self.eight)
  table.insert (self.lObjects, self.nine)
  table.insert (self.lObjects, self.ten)
  
  for i,_ in ipairs (self.scoreNames) do
    table.insert(self.lObjects, self.scoreNames[i])
  end
  
  for i,_ in ipairs (self.scoreValues) do
    table.insert(self.lObjects, self.scoreValues[i])
  end
  

  table.insert (self.lObjects, self.writeText)
  table.insert (self.lObjects, self.lbText)
  table.insert (self.lObjects, self.submit)
  
  self:Fill()
  
end

function RankingScene:update(dt)
  for _,v in pairs(self.lObjects) do
    v:update(dt)
  end
end
function RankingScene:draw()
  for _,v in pairs(self.lObjects) do
    v:draw()
  end
end

function RankingScene:Fill()
  
  contents, size = love.filesystem.read(rankingNFileName)
  
  if contents == nil then
    self:Initialize()
  end
  
  local i = 1
  
  for line in love.filesystem.lines(rankingNFileName) do
    self.scoreNames[i].value = line
    i = i + 1
  end
  
  i = 1
  
  for line in love.filesystem.lines(rankingSFileName) do
    self.scoreValues[i].value = line
    i = i + 1
  end
  
  self:InsertNewScore()
  
end

function RankingScene:InsertNewScore()
  
  for i,_ in ipairs(self.scoreValues) do
    if playerScore > tonumber(self.scoreValues[i].value) then
      for r = 10, i+1, -1 do
        self.scoreValues[r].value = self.scoreValues[r-1].value
        self.scoreNames[r].value = self.scoreNames[r-1].value
      end
      self.scoreValues[i].value = playerScore
      self.scoreNames[i].value = ""
      self.scoreIndex = i
      break
    end
  end
  
end

function RankingScene:Initialize()
  
  local data = "LRS\n"
  data = data.."DDS\n"
  data = data.."AAR\n"
  data = data.."PPC\n"
  data = data.."PSC\n"
  data = data.."VOX\n"
  data = data.."GOD\n"
  data = data.."LPD\n"
  data = data.."LSD\n"
  data = data.."CAT"
  
  success, message = love.filesystem.write(rankingNFileName, data)
  
  data = "150000\n"
  data = data.."130000\n"
  data = data.."100000\n"
  data = data.."90000\n"
  data = data.."70000\n"
  data = data.."60000\n"
  data = data.."40000\n"
  data = data.."30000\n"
  data = data.."20000\n"
  data = data.."10000"
  
  success, message = love.filesystem.write(rankingSFileName, data)
  
end

function RankingScene:Submit()
  
  local data = ""
  
  for _,v in ipairs(currentScene.scoreValues) do
    data = data..v.value.."\n"
  end
  
  success, message = love.filesystem.write(rankingSFileName, data)
  
  data = ""
   
  for _,v in ipairs(currentScene.scoreNames) do
    data = data..v.value.."\n"
  end
  
   success, message = love.filesystem.write(rankingNFileName, data)
  
  changeState(GameStates.menu)
  
end

function RankingScene:keypressed(key)

end

function RankingScene:textinput(t)
  if self.scoreIndex ~= -1 then
    if self.inputLetters < 3 then
      self.scoreNames[self.scoreIndex].value = self.scoreNames[self.scoreIndex].value..t
      self.inputLetters = self.inputLetters + 1
    end
  end
end
