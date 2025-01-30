require "Bird"
require "Pipe"
require "PipePair"

local bird
local pipePairs = {}  -- List to store pipe pairs
local backgroundMusic = love.audio.newSource("assets/background_music.mp3", "stream")
local background

local score = 0 -- This keep track of the players score 
local gameState = "running" -- this keeps track of the game state

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
   backgroundMusic:setLooping(true)
   backgroundMusic:play() 
end

function love.update(dt)
    if gameState == "running" then 
        bird:update(dt)  -- Update the bird's position

        -- Update all pipe pairs
        for _, pipePair in ipairs(pipePairs) do
            pipePair:update(dt)
        end

    -- Check for collisions with each pipe pair
        for _, pipePair in ipairs(pipePairs) do
            if pipePair:checkCollision(bird) then
                -- TODO: Fix this one 
                gameState = "gameOver" -- change the game state if the collision is detected 
                break
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
            score = score + 1
        end
    end
end

function love.keypressed(key)
    -- make the jump when the key is "space" key is pressed 
    if gameState == "running" then 
        if key == "space" then
            bird:jump() -- make the damn bird jump 
            bird:activateGravity() -- activate the gravity 
        end 
    elseif gameState == "gameOver" then 
        -- Restart the game when "R" is pressed
        if key == "r" then 
            resetGame()
        end 
    end 
end 

function resetGame()
    bird = Bird:new()
    pipePairs = {}  -- Clear the pipe pairs
    gameState = "running"  -- Set the game state to "running"

    -- Initialize new pipes
    local initialX = love.graphics.getWidth() + 100 -- Starting X position 
    local horizontalGap = 350 -- Change the gap as needed 

    for i=1, 3 do
        local bottomPipeHeight = math.random(200, 230)
        local bottomPipeY = love.graphics.getHeight() - bottomPipeHeight
        local gap = math.random(140, 180)

        local bottomPipe = Pipe:new(initialX + (i - 1) * horizontalGap, bottomPipeY, 60, bottomPipeHeight)
        table.insert(pipePairs, PipePair:new(bottomPipe, gap))
    end
end


function love.draw()
    -- Draw the background
    local screenWidth, screenHeight = love.graphics.getDimensions()
    background = love.graphics.newImage("assets/flappy_bird_bg.jpg")
    love.graphics.draw(background, 0, 0, 0, screenWidth / background:getWidth(), screenHeight / background:getHeight())

    if gameState == "running" then
        -- Render the bird
        bird:render()

        -- Render all pipe pairs
        for _, pipePair in ipairs(pipePairs) do
            pipePair:render()
        end

        -- Display the score
        love.graphics.setFont(love.graphics.newFont(24)) -- Set font size
        love.graphics.print("Score: " .. score, 10, 10)
    elseif gameState == "gameOver" then
        -- Display the "Game Over" message and score
        love.graphics.setFont(love.graphics.newFont(48)) -- Large font for game over
        love.graphics.printf("Game Over", 0, screenHeight / 2 - 50, screenWidth, "center")

        -- Display the final score
        love.graphics.setFont(love.graphics.newFont(36))
        love.graphics.printf("Score: " .. score, 0, screenHeight / 2 + 20, screenWidth, "center")

        -- Display restart instructions
        love.graphics.setFont(love.graphics.newFont(24))
        love.graphics.printf("Press 'R' to Restart", 0, screenHeight / 2 + 80, screenWidth, "center")
    end
end
