-- Pipe.lua

Pipe = {}

function Pipe:new(x, y, width, height, gap, speed)
    local obj = {
        x = x,          -- X-coordinate of the pipe (moving left)
        y = y,          -- Y-coordinate of the top pipe
        width = width,  -- Width of the pipe
        height = height, -- Height of the top pipe
        gap = gap,      -- Vertical gap between top and bottom pipe
        speed = speed   -- Speed at which the pipe moves left
    }

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Pipe:update(dt)
    self.x = self.x - self.speed * dt  -- Move the pipe leftward

    -- Optionally recycle the pipe if it moves off the screen
    if self.x + self.width < 0 then
        self.x = love.graphics.getWidth()  -- Reset to the right side of the screen
        self.y = math.random(100, love.graphics.getHeight() - 200)  -- Random height for new pipe
    end
end

function Pipe:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Pipe:isOffScreen()
    return self.x + self.width < 0  -- Check if the pipe is off-screen
end

function Pipe:checkCollision(bird) 
    return false -- Check if the bird collides with pipe 
end
