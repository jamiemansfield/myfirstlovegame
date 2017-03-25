function love.load()
    loadState("splash")
end

function loadState(name)
    state = {}
    require("states/".. name)
    state.load()
end

function love.update()
    state.update()
end

function love.draw()
    state.draw()
end
