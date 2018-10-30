Text = Object:extend()

function Text:new(x,y,xo,yo,limit,align, newFont, value, color)
  self.x = x
  self.y = y
  self.xo = xo
  self.yo = yo
  self.limit = limit
  self.align = align
  self.value = value or 0
  self.font = newFont or font
  self.color = color or colors.WHITE
end

function Text:update(dt)
  
end

function Text:draw()
  love.graphics.setFont(self.font)
  love.graphics.setColor(self.color)
  love.graphics.printf(self.value, self.x + self.xo , self.y + self.yo, self.limit, self.align)
  love.graphics.setColor(colors.WHITE)
end
