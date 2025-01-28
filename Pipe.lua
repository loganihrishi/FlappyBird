-- Pipe.lua

Pipe = {}

function Pipe:new(x, y, width, height)
    local obj = {
        x = x,          -- X-coordinate of the pipe (moving left)
        y = y,          -- Y-coordinate of the top pipe
        width = width,  -- Width of the pipe
        height = height, -- Height of the top pipe
        speed = 100 -- CHANGE IT AS NEEDED
    }

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Pipe:update(dt)
    self.x = self.x - self.speed * dt  -- Move the pipe leftward
end

function Pipe:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Pipe:isOffScreen()
    return self.x + self.width < 0  -- Check if the pipe is off-screen
end

-- TODO: Implement this 
function Pipe:collidesWith(bird)
    -- Basic collision detection (AABB - Axis-Aligned Bounding Box)
    return not (bird.x + bird.width < self.x or bird.x > self.x + self.width or
               bird.y + bird.height < self.y or bird.y > self.y + self.height)
end
