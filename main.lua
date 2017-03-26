function love.load()
    -- Music
    music = love.audio.newSource("res/waysons_eternal-minds.mp3")
    music:play()
    
    registerState("splash")
    registerState("game")
    registerState("win")
    registerState("lose")

    enterState("splash")
end

local states = {}
local state = "splash"

--- Registers the given state.
-- States are defined by lua files of the same name, under the states
-- directory.
-- @param name The name of the state
function registerState(name)
    states[name] = require("states/".. name)
end

--- Enters the given state.
-- The state must have already have been registered, using registerState!
-- @param name The name of the state
function enterState(name)
    love.graphics.reset()
    state = name
    states[name].load()
end

function love.update()
    states[state].update()
end

function love.draw()
    states[state].draw()
end

-- Thanks to http://stackoverflow.com/a/2705804/3341246
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
