require "Bird"
require "Pipe"
require "PipePair"

local bird
local pipePairs = {}  -- List to store pipe pairs

function love.load()
    bird = Bird:new()

   -- bottom pipe height 
   local bottomPipeHeight = math.random(150, 200) -- change and see what works  
   -- Fixed bottom pipe Y-coordinate
   local bottomPipeY = love.graphics.getHeight() - bottomPipeHeight-- This ensures the bottom pipe's bottom edge is at the bottom of the screen
    -- Randomly generate a gap value (the space between the pipes)
    local gap = math.random(50, 100)  -- Gap between top and bottom pipes (randomized)

    -- Create the bottom pipe with the fixed y-coordinate
    local bottomPipe = Pipe:new(love.graphics.getWidth(), bottomPipeY, 60, bottomPipeHeight)

    -- Initialize first pair of pipes
    table.insert(pipePairs, PipePair:new(bottomPipe, 150))  -- Add first pipe pair
end

function love.update(dt)
    bird:update(dt)  -- Update the bird's position

    -- Update all pipe pairs
    for _, pipePair in ipairs(pipePairs) do
        pipePair:update(dt)
    end

    -- Check for collisions with each pipe pair
    for _, pipePair in ipairs(pipePairs) do
        if pipePair:checkCollision(bird) then
            print("Collision Detected!")
            -- Handle collision (e.g., game over or restart)
        end
    end

    -- Add new pipes if needed (e.g., when the last pipe pair moves off screen)
    if pipePairs[#pipePairs].top:isOffScreen() then
        -- Create a new pipe pair when the last one goes off-screen
        table.insert(pipePairs, PipePair:new(Pipe:new(love.graphics.getWidth(), math.random(100, love.graphics.getHeight() - 200), 60, 300), 150))
    end
end

function love.draw()
    -- Render the bird
    bird:render()

    -- Render all pipe pairs (both top and bottom pipes)
    for _, pipePair in ipairs(pipePairs) do
        pipePair:render()  -- Render each pipe pair (top and bottom pipes)
    end
end
