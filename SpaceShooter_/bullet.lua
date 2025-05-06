require "utils"
bullets = {}

function bullets:addBullet(x,y, speed)
    bullet = {}
    bullet.x = x
    bullet.y = y
    bullet.texture = love.graphics.newImage("resources/bullet.png")
    bullet.width = bullet.texture:getWidth()
    bullet.height = bullet.texture:getHeight()
    bullet.dead = false
    bullet.speed = speed
    function bullet:checkCollisions(ast)
        local self_top = self.y
        local self_bottom = self.y+self.height
        local self_right = self.x + self.width
        local self_left = self.x

        local ast_top = ast.y
        local ast_bottom = ast.y+ast.height
        local ast_right = ast.x+ast.width
        local ast_left = ast.x

        if self_right > ast_left and self_left < ast_right and self_top < ast_bottom and self_bottom > ast_top then
            return true
        else
            return false
        end
    end

    function bullet:update(dt, asts)
        self.y = self.y-self.speed*dt
        --collectgarbage("stop")
        for i,v in ipairs(asts)do
            --if(utils:distance_to(self.x,self.y,v.x,v.y) < 50)then
            if(self:checkCollisions(v))then
                self.dead = true
                v.dead = true
                player.score = player.score + 1
                
            end
            --end
        end
        --collectgarbage("collect")
        --collectgarbage("restart")
        if(self.y+self.height < 0)then
            self.dead = true
        end
        
        
    end

    function bullet:draw()
        love.graphics.draw(self.texture, self.x, self.y)
    end

    table.insert(bullets, bullet)
end

function bullets:update(dt, ast_table)
    for i, v in ipairs(bullets) do
        v:update(dt, ast_table)
        if(v.dead)then
            table.remove(bullets, i)
            --collectgarbage("collect")
        end
    end
    
end


function bullets:draw()
    for _,v in ipairs(bullets)do
        v:draw()
    end
end

function bullets:remove_dead()
    if(bullets ~= nil) then
        for i, v in ipairs(bullets) do
            if(v.dead)then
                table.remove(bullets, i)
            end
        end
    end
end