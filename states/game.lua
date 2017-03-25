function state.load()
    player = {}
    player.x = 100
    player.y = 100
    player.size = 25
    player.speed = 3

    blobs = {}
    for i = 0,6 do
        blobs[i] = {}
        blobs[i].x = math.random(love.graphics.getWidth() - 30) + 15
        blobs[i].y = math.random(love.graphics.getHeight() - 30) + 15
    end
    lastGen = os.time()

    love.graphics.setBackgroundColor(144, 202, 249)
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

    -- generate new blob every 9 seconds
    if lastGen + 9 < os.time() then
        blob = {}
        blob.x = math.random(love.graphics.getWidth() - 30) + 15
        blob.y = math.random(love.graphics.getHeight() - 30) + 15
        blobs[tablelength(blobs)] = blob
        lastGen = os.time()
    end
end

function state.draw()
    love.graphics.setColor(255, 255, 255)
    for i, blob in ipairs(blobs) do
        love.graphics.circle("fill", blob.x, blob.y, 15, 15)
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("fill", player.x, player.y, player.size, player.size)
end

-- Thanks to http://stackoverflow.com/a/2705804/3341246
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
