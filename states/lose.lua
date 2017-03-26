local state = {}

function state.enter()
    loseImage = love.graphics.newImage("res/gameover.png")
end

function state.update()
end

function state.draw()
    love.graphics.draw(loseImage)
end

function state.keypressed(key)
    if key == "space" then
        enterState("game")
    end
end

return state
