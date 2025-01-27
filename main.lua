-- main.lua

require "Bird"
require "Pipe"

local bird
local pipes = {}

function love.load()
    bird = Bird:new()  -- Create the bird
    -- Create the first pipe
    table.insert(pipes, Pipe:new(love.graphics.getWidth(), math.random(100, love.graphics.getHeight() - 200), 60, 300, 150, 100))
end

function love.update(dt)
    bird:update(dt)  -- Update the bird's position
end

function love.draw()
    bird:render()  -- Render the bird
end
