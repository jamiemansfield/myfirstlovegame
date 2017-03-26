local state = {}

function state.enter()
    player = {}
    player.x = 100
    player.y = 100
    player.area = 25^2
    player.speed = 3
    player.score = 0

    colours = {
        {r = 255, g = 245, b = 157}, -- yellow 200
        {r = 255, g = 138, b = 101}, -- deep orange 300
        {r = 255, g = 213, b = 79}, -- amber 300
    }

    blobs = {}
    for i = 1,6 do
        blobs[i] = genBlob()
    end

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

    -- first check the size of the last blob
    if lastBlob.size == "large" then
        -- generate new blob every 4 seconds
        if lastGen + 4 < os.time() then
            blobs[tablelength(blobs) + 1] = genBlob()
            lastGen = os.time()
        end
    else
        -- generate new blob every 2 seconds
        if lastGen + 2 < os.time() then
            blobs[tablelength(blobs) + 1] = genBlob()
            lastGen = os.time()
        end
    end

    -- Check for collision
    for i, blob in ipairs(blobs) do
        if checkCollision(player, blob) then
            player.area = player.area + blob.area
            if blob.size == "large" then
                player.score = player.score + 2
            elseif blob.size == "small" then
                player.score = player.score + 1
            end
            table.remove(blobs, i)
        end
    end

    -- Check if the player has won
    if player.score >= 15 then
        enterState("win")
    end

    -- Check if the player has lost
    if getTimePassed() >= 50 then
        enterState("lose")
    end
end

function state.draw()
    love.graphics.print("Time passed: ".. getTimePassed().. "secs", 10, 10)
    love.graphics.print("Score: ".. player.score, 10, 23)

    for i, blob in ipairs(blobs) do
        love.graphics.setColor(blob.colour.r, blob.colour.g, blob.colour.b)
        love.graphics.circle("fill", blob.x, blob.y, getSize(blob), getSize(blob))
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", player.x, player.y, getSize(player), getSize(player))
end

function getTimePassed()
    return os.time() - startTime
end

function getSize(ob)
    return math.sqrt(ob.area)
end

function genBlob()
    local blob = {}
    blob.x = randomRange(15, love.graphics.getWidth() - 15)
    blob.y = randomRange(15, love.graphics.getHeight() - 15)
    blob.area = 15^2
    blob.size = "small"
    if math.random(4) == 4 then
        blob.area = 30^2
        blob.size = "large"
    end
    blob.colour = colours[math.random(tablelength(colours))]

    lastGen = os.time()
    lastBlob = blob
    return blob
end

-- Based on code from http://sheepolution.com/learn/book/13
function checkCollision(player, blob)
    local playerLeft = player.x
    local playerRight = player.x + getSize(player)
    local playerTop = player.y
    local playerBottom = player.y + getSize(player)

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
