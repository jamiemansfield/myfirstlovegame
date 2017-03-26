local state = {}

function state.enter()
    splashImage = love.graphics.newImage("res/splash.png")
    startTime = os.time()
end

function state.update()
    if startTime + 1 < os.time() then
        enterState("game")
    end
end

function state.draw()
    love.graphics.draw(splashImage)
end

return state
