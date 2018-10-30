Transform = Object:extend()

function Transform:new(x,y,fx,fy,rot)
    self.position = Vector.new(x or 0, y or 0)
    self.scale = Vector.new(1,1)
    self.forward = Vector.new(fx or 1,fy or 0)
    self.rot = 0 or rot
end


