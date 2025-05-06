asteroids = {}

function asteroids:addAst(x,y,speed, rot_speed)
    ast = {}
    ast.x = x
    ast.y = y
    ast.texture = love.graphics.newImage("resources/meteor_medium.png")
    ast.width = ast.texture:getWidth()
    ast.height = ast.texture:getHeight()
    ast.speed = speed
    ast.rotation = 0
    ast.rot_speed = rot_speed
    ast.dead = false

    function ast:update(dt)

        self.y = self.y + self.speed*dt
        self.rotation = self.rotation + self.rot_speed
        if self.rotation >360 then
            self.rotation = 0
        end
        if self.y > love.graphics.getHeight() then
            self.dead = true
        end
        

    end
    function ast:draw()
        love.graphics.draw(self.texture, self.x,self.y,self.rotation, 1,1,self.width/2,self.height/2)
    end

    table.insert(asteroids, ast)

end


function asteroids:upadte(dt)
    --collectgarbage("stop")
    for i, v in ipairs(asteroids) do
        v:update(dt)
        if(v.dead)then
            table.remove(asteroids, i)
            
        end
    end
    --collectgarbage("collect")
    --collectgarbage("restart")
end

function asteroids:draw()
    for _, v in ipairs(asteroids) do
        v:draw()
    end    
end

function asteroids:remove_dead()
    if(asteroids ~= nil)then
        for i,v in ipairs(asteroids)do
            if(v.dead)then
                table.remove(asteroids, i)
            end
        end
    end
end
