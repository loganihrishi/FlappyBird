-- Bird.lua

Bird = {}

function Bird:new() 
    local obj = {
        x = 50, -- starting X coordinate 
        y = 300, -- starting Y coordinate
        width = 40, -- Width of the bird for collision 
        height = 25, -- Height of the bird for collision 
        dy = 0, -- vertical speed 
        gravity = 9.8, -- gravity that pulls the bird down 
        jumpSpeed = -5-- jump speed 
    }

    setmetatable(obj, self)
    self.__index =self 
    return obj
end 

function Bird:update(dt)
    -- Apply the gravity to vertical speed over time 
    self.dy = self.dy+self.gravity*dt
    -- Update bird's Y coordinate based on vertical speed 
    self.y = self.y + self.dy
end 

function Bird:jump()
    -- make the bird jump by setting a new vercial speed 
    self.dy=self.jumpSpeed
end 

function Bird:render()
    -- render the bird as a rectangle, TODO: change it later to an image to make it visually appealing 
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end 

