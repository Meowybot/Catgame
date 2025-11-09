level = require("catsing/level")

function love.load()
    level.update, level.draw = level.load()
end

function love.update(dt)
    level.update(dt)
end

function love.draw()
    level.draw()
end

function love.mousepressed(x, y, button)
    level.onClick()
end

function love.keypressed(key)
    if key == "space" then
        level.onClick()
    end
end