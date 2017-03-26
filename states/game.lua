local state = {}

function state.load()
    player = {}
    player.x = 100
    player.y = 100
    player.size = 25
    player.speed = 3

    colours = {
        {r = 255, g = 245, b = 157}, -- yellow 200
        {r = 255, g = 138, b = 101}, -- deep orange 300
    }

    blobs = {}
    for i = 1,6 do
        blobs[i] = genBlob()
    end
    lastGen = os.time()

    -- blue 200
    love.graphics.setBackgroundColor(144, 202, 249)

    -- store start time
    startTime = os.time()
end

function state.update()
    -- y movement
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        player.y = player.y - player.speed
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        player.y = player.y + player.speed
    end

    -- x movement
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        player.x = player.x - player.speed
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        player.x = player.x + player.speed
    end

    -- generate new blob every 4 seconds
    if lastGen + 4 < os.time() then
        blobs[tablelength(blobs) + 1] = genBlob()
        lastGen = os.time()
    end

    -- Check for collision
    for i, blob in ipairs(blobs) do
        if checkCollision(player, blob) then
            table.remove(blobs, i)
            player.size = player.size + 5
        end
    end

    -- Check if the player has won
    if getScore() >= 15 then
        enterState("win")
    end

    -- Check if the player has lost
    if getTimePassed() >= 50 then
        enterState("lose")
    end
end

function state.draw()
    love.graphics.print("Time passed: ".. getTimePassed().. "secs", 10, 10)
    love.graphics.print("Score: ".. getScore(), 10, 23)

    for i, blob in ipairs(blobs) do
        love.graphics.setColor(blob.colour.r, blob.colour.g, blob.colour.b)
        love.graphics.circle("fill", blob.x, blob.y, 15, 15)
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", player.x, player.y, player.size, player.size)
end

function getScore()
    return (player.size - 25) / 5
end

function getTimePassed()
    return os.time() - startTime
end

function genBlob()
    local blob = {}
    blob.x = math.random(love.graphics.getWidth() - 30) + 15
    blob.y = math.random(love.graphics.getHeight() - 30) + 15
    blob.colour = colours[math.random(tablelength(colours))]
    return blob
end

-- Based on code from http://sheepolution.com/learn/book/13
function checkCollision(player, blob)
    local playerLeft = player.x
    local playerRight = player.x + player.size
    local playerTop = player.y
    local playerBottom = player.y + player.size

    local blobLeft = blob.x
    local blobRight = blob.x + 15
    local blobTop = blob.y
    local blobBottom = blob.y + 15

    return playerRight > blobLeft and
           playerLeft < blobRight and
           playerBottom > blobTop and
           playerTop < blobBottom 
end

return state
