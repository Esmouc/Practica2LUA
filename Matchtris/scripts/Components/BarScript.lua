BarScript = Object:extend()

function BarScript:new()
  self.streak = 0
  self.max = 5
  self.height = 700 --altura de la barra
end
function BarScript:update(dt)
  
end
function BarScript:Change(Mtch, gameobject)
  if Mtch then
    self.streak = self.streak + 1
  else
    self.streak = self.streak -1
  end
  if self.streak == self.max then
    --score + 5000
    self.streak = 0
  end
  gameobject.transform.scale = Vector.new(1, self.height/(self.max - self.streak + 1))
end

