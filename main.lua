-- -- main.lua 
-- require "config"

-- function love.draw()
--     love.graphics.print("Hello, LÖVE!", Config.WIDTH, Config.HEIGHT)
-- end

-- main.lua

-- Require the Bird class
require "Bird"

-- Create a bird object
local bird

function love.load()
    bird = Bird:new()  -- Initialize the bird
end

function love.update(dt)
    bird:update(dt)  -- Update the bird's position and apply gravity

    -- Make the bird jump if the spacebar is pressed
    if love.keyboard.isDown("space") then
        bird:jump()  -- Make the bird jump
    end
end

function love.draw()
    bird:render()  -- Draw the bird on the screen
end
