function state.load()
    player = {}
    player.x = 100
    player.y = 100
end

function state.update()
    -- y movement
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        player.y = player.y - 1
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        player.y = player.y + 1
    end

    -- x movement
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        player.x = player.x - 1
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        player.x = player.x + 1
    end
end

function state.draw()
    love.graphics.rectangle("fill", player.x, player.y, 25, 25)
end
