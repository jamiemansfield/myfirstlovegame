local state = {}

function state.load()
    loseImage = love.graphics.newImage("res/gameover.png")
end

function state.update()
end

function state.draw()
    love.graphics.draw(loseImage)
end

return state