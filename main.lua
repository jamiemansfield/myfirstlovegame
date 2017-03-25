function love.load()
    loadState("splash")
end

--- Loads the given state.
-- States are defined by lua files of the same name, under the states
-- directory.
-- @param name The name of the state
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
