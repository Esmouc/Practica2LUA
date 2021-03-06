GameObject = Object:extend()

function GameObject:new(components, transform, spriteRenderer)
    self.transform = transform or Transform()
    self.spriteRenderer = spriteRenderer or nil
    self.components = components
end

function GameObject:update(dt)
  for i,v in pairs(self.components) do
    v:update(dt,self)
  end
end

function GameObject:draw()
  if self.spriteRenderer ~= nil then
    self.spriteRenderer:draw(self)
  end
end

function GameObject:destroy()
  for i,v in ipairs(currentScene.lObjects) do
    if v == self then
      table.remove(currentScene.lObjects, i)
    end
  end
end

function GameObject:GetComponent(componentType)
  for i,v in ipairs (self.components) do
    if v:is(componentType) then
      return self.components[i]
    end
  end
  return nil
end
