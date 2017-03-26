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

-- Thanks to http://stackoverflow.com/a/2705804/3341246
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
