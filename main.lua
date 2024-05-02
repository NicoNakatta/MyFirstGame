function love.load()
    anim8 = require 'library/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")

    player = {}
    player.x = 400
    player.y = 300
    player.speed = 7
    player.status = 1

    -- Load sprites
    player.spriteSheet = love.graphics.newImage('assets/characters/main character/walk and idle.png')
    player.grid = anim8.newGrid(24, 24, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
    -- Cat Costume Sprites
    player.spriteSheet2 = love.graphics.newImage('assets/characters/main character/cat kigurumi walk and idle.png')
    player.grid2 = anim8.newGrid(24, 24, player.spriteSheet2:getWidth(), player.spriteSheet:getHeight())
    -- Create animation
    player.animation = {}
    -- Body
    player.animation.leftIdle = anim8.newAnimation(player.grid('1-2', 1), 0.25)
    player.animation.RightIdle = anim8.newAnimation(player.grid('3-4', 1), 0.25)
    player.animation.leftWalk = anim8.newAnimation(player.grid('1-8', 2), 0.1)
    player.animation.RightWalk = anim8.newAnimation(player.grid('1-8', 3), 0.1)
    player.anim = player.animation.leftWalk
    -- Costume
    player.animation.leftIdle2 = anim8.newAnimation(player.grid2('1-2', 1), 0.25)
    player.animation.RightIdle2 = anim8.newAnimation(player.grid2('3-4', 1), 0.25)
    player.animation.leftWalk2 = anim8.newAnimation(player.grid2('1-8', 2), 0.1)
    player.animation.RightWalk2 = anim8.newAnimation(player.grid2('1-8', 3), 0.1)
    player.anim2 = player.animation.leftWalk2

    -- Walk and Idle Status
    function idle(status)
        if status == 1 then
            player.anim = player.animation.RightIdle
            player.anim2 = player.animation.RightIdle
        else
            player.anim = player.animation.leftIdle
            player.anim2 = player.animation.leftIdle
        end
    end
    function walk(status)
        if status == 1 then
            player.anim = player.animation.RightWalk
            player.anim2 = player.animation.RightWalk
        else
            player.anim = player.animation.leftWalk
            player.anim2 = player.animation.leftWalk
        end
    end

    -- Movement
    function movement()
        -- Normalize Diagonal
        d = {x=0, y=0}
        if love.keyboard.isDown("w") then d.y = d.y - 1 end
        if love.keyboard.isDown("s") then d.y = d.y + 1 end
        if love.keyboard.isDown("d") then d.x = d.x + 1 end
        if love.keyboard.isDown("a") then d.x = d.x - 1 end
    
        length = math.sqrt(d.x^2 + d.y^2)
        if length > 0 then
            d.x = d.x/length
            d.y = d.y/length
        end

        if love.keyboard.isDown("d") then
            player.x = player.x + (player.speed * d.x)
            player.anim = player.animation.RightWalk
            player.anim = player.animation.RightWalk2
            player.status = 1
        end
        if love.keyboard.isDown("a") then
            player.x = player.x - (player.speed * -d.x)
            player.anim = player.animation.leftWalk
            player.anim = player.animation.leftWalk2
            player.status = 2
        end
        if love.keyboard.isDown("w") then
            player.y = player.y - (player.speed * -d.y)
            walk(player.status)
        end
        if love.keyboard.isDown("s") then
            player.y = player.y + (player.speed * d.y)
            walk(player.status)
        end
    end

end

-- Increase the size of the rectangle every frame.
function love.update(dt)
    idle(player.status)
    movement()
    player.anim:update(dt)
end

-- Draw a coloured rectangle.
function love.draw()
    -- In versions prior to 11.0, color component values are (0, 102, 102)
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 5)
    player.anim:draw(player.spriteSheet2, player.x, player.y, nil, 5)
end
