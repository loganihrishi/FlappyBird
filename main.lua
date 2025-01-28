require "Bird"
require "Pipe"
require "PipePair"

local bird
local pipePairs = {}  -- List to store pipe pairs
local backgroundMusic = love.audio.newSource("assets/background_music.mp3", "stream")
local background

function love.load()
    bird = Bird:new()

   local initialX = love.graphics.getWidth() + 100 -- Starting X position 
   local horizontalGap = 350 -- Change the gap as needed 

   for i=1,3 do
    -- bottom pipe height 
        local bottomPipeHeight = math.random(200, 230)
   -- Fixed bottom pipe Y-coordinate
        local bottomPipeY = love.graphics.getHeight() - bottomPipeHeight-- This ensures the bottom pipe's bottom edge is at the bottom of the screen
    -- Randomly generate a gap value (the space between the pipes)
        local gap = math.random(140, 180)  -- Gap between top and bottom pipes (randomized)

    -- Create the bottom pipe with the fixed y-coordinate
        local bottomPipe = Pipe:new(initialX + (i - 1) * horizontalGap, bottomPipeY, 60, bottomPipeHeight)

    -- Initialize first pair of pipes
        table.insert(pipePairs, PipePair:new(bottomPipe, gap))  -- Add first pipe pair
   end 

   -- Adding the background music 
--    backgroundMusic:setLooping(true)
--    backgroundMusic:play() 
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
            -- TODO: Fix this one 
            print("Collision Detected, fuck you")
            -- Handle collision (e.g., game over or restart)
        end
    end

    -- Add new pipes if needed (e.g., when the last pipe pair moves off screen)
    -- Add new pipes if needed (e.g., when the last pipe pair moves off screen)
    while #pipePairs < 5 do  -- Ensure there are always at least 5 pipe pairs
        -- Calculate the x position for the new pipe pair based on the last pipe pair
        local lastPipePairX = pipePairs[#pipePairs].bottom.x
        local horizontalGap = 250  -- Same horizontal gap as in love.load()

        -- Bottom pipe height
        local bottomPipeHeight = math.random(200, 230)
        local bottomPipeY = love.graphics.getHeight() - bottomPipeHeight

        -- Random gap between top and bottom pipes
        local gap = math.random(100, 120)

    -- Create a new bottom pipe
        local newBottomPipe = Pipe:new(lastPipePairX + horizontalGap, bottomPipeY, 60, bottomPipeHeight)

    -- Add a new pipe pair to the list
        table.insert(pipePairs, PipePair:new(newBottomPipe, gap))
    end

-- Remove the first pipe pair from the list if it moves off-screen
    if pipePairs[1].top:isOffScreen() then
        table.remove(pipePairs, 1)
    end

end

function love.keypressed(key)
    -- make the jump when the key is "space" key is pressed 
    if key == "space" then
        bird:jump() -- make the damn bird jump 
        bird:activateGravity() -- activate the gravity 
    end 
end 

function love.draw()
    -- changing the background 
    local screenWidth, screenHeight = love.graphics.getDimensions()

    background = love.graphics.newImage("assets/flappy_bird_bg.jpg")
    love.graphics.draw(background, 0, 0, 0, screenWidth/background:getWidth(), screenHeight/background:getHeight()) 

    -- Render the bird
    bird:render()

    -- Render all pipe pairs (both top and bottom pipes)
    for _, pipePair in ipairs(pipePairs) do
        pipePair:render()  -- Render each pipe pair (top and bottom pipes)
    end
end
