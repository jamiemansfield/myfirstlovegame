local state = {}

function state.enter()
    winImage = love.graphics.newImage("res/win.png")
end

function state.update()
end

function state.draw()
    love.graphics.draw(winImage)
end

function state.keypressed(key)
    if key == "space" then
        enterState("game")
    end
end

return state
