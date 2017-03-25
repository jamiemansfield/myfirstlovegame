function state.load()
    splashImage = love.graphics.newImage("res/splash.png")
    startTime = os.time()
    print(startTime)
end

function state.update()
    if startTime + 3 < os.time() then
        loadState("game")
    end
end

function state.draw()
    love.graphics.draw(splashImage, 0, 0)
end
