RankingScene = Object:extend()

function RankingScene:new()
  self.lObjects = {}
end

function RankingScene:Load()
  self.lObjects = {}
  -- GAME OBJECTS
  self.submit = Button(self.Submit, w/2, h * (2/3), font, "Submit")
  self.lbText = Text(w/2,50,-300,0,600,"center", font,"LEADERBOARD")
  self.one = Text(50,100,0,0,100,"left", smallfont,"1.")
  self.two = Text(50,140,0,0,100,"left", smallfont,"2.")
  self.three = Text(50,180,0,0,100,"left", smallfont,"3.")
  self.four = Text(50,220,0,0,100,"left", smallfont,"4.")
  self.five = Text(50,260,0,0,100,"left", smallfont,"5.")
  self.six = Text(50,300,0,0,100,"left", smallfont,"6.")
  self.seven = Text(50,340,0,0,100,"left", smallfont,"7.")
  self.eight = Text(50,380,0,0,100,"left", smallfont,"8.")
  self.nine = Text(50,420,0,0,100,"left", smallfont,"9.")
  self.ten = Text(50,460,0,0,100,"left", smallfont,"10.")
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
  table.insert (self.lObjects, self.lbText)
  table.insert (self.lObjects, self.submit)
  
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

function RankingScene:Submit()
  changeState(GameStates.menu)
end

function RankingScene:keypressed(key)

end
