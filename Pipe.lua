-- Pipe.lua

Pipe = {}
local scaleFactor = 4
function Pipe:new(x, y, width, height)
    local obj = {
        x = x,          -- X-coordinate of the pipe (moving left)
        y = y,          -- Y-coordinate of the top pipe
        width = width,  -- Width of the pipe
        height = height, -- Height of the top pipe
        speed = 100, -- CHANGE IT AS NEEDED
        topImage =  love.graphics.newImage("assets/flappy_bird_top_pipe.png"),
        bottomImage = love.graphics.newImage("assets/flappy_bird_bottom_pipe.png")
    }

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Pipe:update(dt)
    self.x = self.x - self.speed * dt  -- Move the pipe leftward
end

function Pipe:render(isTop)

    -- Calculate scale for the width and height to match the collision box
    local scaleX = scaleFactor * self.width / self.topImage:getWidth()
    local scaleY = self.height / self.topImage:getHeight()

    if isTop then
        love.graphics.draw(self.topImage, self.x, self.y, 0, scaleX, scaleY)
    else 
        -- Adjust scaling for bottom pipe
        local bottomScaleY = self.height / self.bottomImage:getHeight()
        love.graphics.draw(self.bottomImage, self.x, self.y, 0, scaleX, bottomScaleY)        
    end
end

function Pipe:isOffScreen()
    return self.x + self.width < 0  -- Check if the pipe is off-screen
end

function Pipe:collidesWith(bird, isTop)
    -- Check for collision using rendered positions and dimensions
    return not (
        bird.x + bird.width < self.x or      -- Bird's right side is left of the pipe
        bird.x > self.x + self.width or      -- Bird's left side is right of the pipe
        bird.y + bird.height < self.y or     -- Bird's bottom is above the pipe
        bird.y > self.y + self.height        -- Bird's top is below the pipe
    )
end

