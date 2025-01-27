-- [[ This represents the bird class, the parameters are velocity, positon]]

Bird = {}

function Bird:new() 
    local obj = {
        x = 50, -- Initial x position
        y = 300, -- Initial y position 
        width = 38, -- Bird's width (for collision)
        height = 24, -- Bird's height (for collision)
        dy = 0, -- Vertical velocity
        gravity = 20, -- Gravity force
        jumpStringth = -5 -- Jump force
    }

    setmetable(obj, self) 
    self.__index = self
    return obj 
end 

function Bird:update(dt)
    self.dy = self.dy + self.gravity*dt 
    self.y = self.y + self.dy 
end 

function Bird:jump()
    self.dy=self.jumpStrength 
end 

function Bird:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end 