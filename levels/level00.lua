level = require("catsing/level")

function love.load()
    level.update, level.draw = level.load(
        "Tutorial",
        "00",
        120,
        nil,
        nil,
        nil,
        nil,
        nil,
        7,
        9,
        16,
        17,
        19,
        27
    )
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