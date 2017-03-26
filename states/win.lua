function state.load()
    winImage = love.graphics.newImage("res/win.png")
end

function state.update()
end

function state.draw()
    love.graphics.draw(winImage, 0, 0)
end
