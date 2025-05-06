
local player_image
local asteroid_spawn
local ast_spawn_intreval

local game_state

function love.load()
    love.graphics.newFont(14)
    load_resources()
    load_requirements()
    tick = require "tick"

    load_game_scene()
    love.graphics.newFont(30)
    collectgarbage("collect")
    game_state = ""
end

function love.update(dt)

    --if(collectgarbage("count") > 500)then
        --while collectgarbage("count") >500 do
        --collectgarbage("collect")
        --end
    --end


    tick.update(dt)
    asteroids:upadte(dt)
    asteroids:remove_dead()
    player:update(dt, asteroids)
    bullets:update(dt, asteroids)
    bullets:remove_dead()
    health_bar:update(dt, player.health)

    if(asteroid_spawn)then
        asteroids:addAst(love.math.random(math.max(0,player.x-300), math.min(player.x+300, love.graphics.getWidth()-70)),0, 500,0.01)
        ast_spawned = true
        asteroid_spawn = false

        tick.delay(function ()
            asteroid_spawn = true
        end,ast_spawn_intreval)
    end
    


end

function love.draw()

    bullets:draw()
    asteroids:draw()
    player:draw()
    health_bar:draw()
    love.graphics.setNewFont(30)
    love.graphics.print("health: "..player.health, 5, 30)
    love.graphics.print("score: "..player.score, 5, 60)
    love.graphics.print("garbage: "..collectgarbage("count"), 5, 90)

    

end

function load_requirements()
    require "utils"
    require "bullet"
    require "player"
    require "asteroid"
    require "health_bar"
    
    
end

function load_resources()
    player_image = love.graphics.newImage("resources/playerShip.png")
end

function load_game_scene()
    player:new(love.graphics.getWidth()/2+player_image:getWidth()/2, love.graphics.getHeight()-player_image:getHeight(), 440)
    health_bar:new(player.health, player.health, 100,20, "green", 5, 10)
    asteroid_spawn = true
    ast_spawn_intreval = 2
end





