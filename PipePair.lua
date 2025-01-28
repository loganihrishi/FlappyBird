require "Pipe"
PipePair = {}

-- Takes a Pipe Object as an input and makes an object of type {top: , bottom:}
function PipePair:new(bottom, gap)
    -- 'bottom' is an existing Pipe object
    local bottomX = bottom.x
    local bottomY = bottom.y
    local bottomWidth = bottom.width
    local bottomHeight = bottom.height

    -- The top pipe should be positioned above the bottom pipe, with a gap in between
    local topY = 0  -- Calculate the y position of the top pipe
    local topHeight = love.graphics.getHeight() - (bottomHeight + gap)

    -- Create the top pipe based on the position of the bottom pipe and the gap
    local top = Pipe:new(bottomX, topY, bottomWidth, topHeight)

    -- Now the PipePair object contains both pipes
    local obj = {
        top = top,
        bottom = bottom,
        gap = gap
    }

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function PipePair:update(dt)
    self.bottom:update(dt)
    self.top:update(dt)
end 

function PipePair:render()
    self.bottom:render(false)
    self.top:render(true)
end 

function PipePair:checkCollision(bird)
    return self.bottom:collidesWith(bird) or self.top:collidesWith(bird)
end 




