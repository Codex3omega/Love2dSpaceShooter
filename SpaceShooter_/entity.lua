local Entity = Object:extend()

function Entity:new(x, y, has_texture, texturePath)
    self.x = x
    self.y = y
    
    if has_texture then
        self.texture = love.graphics.newImage(texturePath)
        self.width = self.texture:getWidth()
        self.height = self.texture:getHeight()
    end


end

return Entity