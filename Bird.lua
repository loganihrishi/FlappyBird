-- Bird.lua

Bird = {}

function Bird:new() 
    local obj = {
        x = 50, -- starting X coordinate 
        y = 450, -- starting Y coordinate
        width = 40, -- Width of the bird for collision 
        height = 25, -- Height of the bird for collision 
        dy = 0, -- vertical speed 
        gravity = 9.8, -- gravity that pulls the bird down 
        jumpSpeed = -5, -- jump speed 
        isGravity = false,  -- by default gravity should not be activated=
        image = love.graphics.newImage("assets/flappy_bird_icon.jpeg") -- the path to the image 
    }

    setmetatable(obj, self)
    self.__index =self 
    return obj
end 

function Bird:update(dt)
    -- Apply the gravity to vertical speed over time 
    if self.isGravity then
        self.dy = self.dy+self.gravity*dt
    end 
    -- Update bird's Y coordinate based on vertical speed 
    self.y = self.y + self.dy
end 

function Bird:activateGravity()
    self.isGravity = true
end 

function Bird:jump()
    -- make the bird jump by setting a new vercial speed 
    self.dy=self.jumpSpeed
end 

function Bird:render()
    -- render the bird with image 
    love.graphics.draw(self.image, self.x, self.y)
end 

