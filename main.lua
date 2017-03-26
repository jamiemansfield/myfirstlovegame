function love.load()
    registerMusic("waysons_eternal-minds")
    registerMusic("halvorsen_wouldnt-change-it")
    
    registerState("splash")
    registerState("game")
    registerState("win")
    registerState("lose")

    enterState("splash")

    startMusic()
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
    -- this is very important!
    -- ensures that the win and lose state works properly
    love.graphics.reset()
    state = name
    states[name].enter()
end

local music = {}
local currentlyPlaying = 1

function registerMusic(name)
    music[tablelength(music) + 1] =  love.audio.newSource("res/".. name.. ".mp3")
end

function startMusic()
    currentlyPlaying = math.random(tablelength(music))
    music[currentlyPlaying]:play()
end

function love.update()
    states[state].update()

    if music[currentlyPlaying]:isStopped() then
        local lastPlayed = currentlyPlaying
        while currentlyPlaying == lastPlayed do
            currentlyPlaying = math.random(tablelength(music))
        end
        music[currentlyPlaying]:play()
    end
end

function love.draw()
    states[state].draw()
end

function love.keypressed(key)
    states[state].keypressed(key)
end

-- Thanks to http://stackoverflow.com/a/2705804/3341246
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function randomRange(min, max)
    return math.random(max - min) + min
end
