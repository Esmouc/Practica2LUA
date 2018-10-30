Button = Object:extend()

function Button:new(callback, x,y, newFont, value, textColor, rectColor,rectWidth, rectHeight)
  self.fillText = Text(x,y,0,22,200,"center",newFont,value, textColor or colors.BLACK)
  self.x = x
  self.y = y
  self.rectWidth = rectWidth or 200
  self.rectHeight = rectHeight or 70
  self.rectColor = rectColor or colors.WHITE
  self.currentColor = self.rectColor
  self.isClicked = false
  self.callback = callback
end

function Button:update(dt)
  if self:mouseIsOver(love.mouse.getPosition()) then
    if love.mouse.isDown(1) then
      self.currentColor = colors.DARKGREY
      self.isClicked = true
    elseif self.isClicked then
      self.callback()
    else
      self.currentColor = colors.GREY
    end
  else
    self.currentColor = self.rectColor
    self.isClicked = false
  end
end

function Button:draw()
  love.graphics.setColor(self.currentColor)
  love.graphics.rectangle("fill",self.x, self.y, self.rectWidth, self.rectHeight)
  love.graphics.setColor(colors.WHITE)
  self.fillText:draw()
end

function Button:mouseIsOver(mouseX,mouseY)
  if mouseX > self.x and mouseX < self.x + self.rectWidth and mouseY < self.y + self.rectHeight and mouseY > self.y then
    return true
  end
  return false
end
