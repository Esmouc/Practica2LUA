SpriteRenderer = Object:extend()

function SpriteRenderer:new(image)
    self.image = love.graphics.newImage(image)
    self.origin = Vector.new(self.image:getWidth()/2 ,self.image:getHeight()/2)
end

function SpriteRenderer:draw(gameobject)
  xx = gameobject.transform.position.x
  ox = self.origin.x
  yy = gameobject.transform.position.y
  oy = self.origin.y
  sx = gameobject.transform.scale.x
  sy = gameobject.transform.scale.y
  rr = gameobject.transform.rot
  love.graphics.draw(self.image,xx,yy,rr,sx,sy,ox,oy,0,0)
end

function SpriteRenderer:changeImage(image)
  self.image = love.graphics.newImage(image)
  self.origin = Vector.new(self.image:getWidth()/2 ,self.image:getHeight()/2)
end
