state = require("lib/stateswitcher")

function love.load()
    love.window.setTitle("CatSing! by CS!T")
    state.switch("levels/level00")
end

function love.update(dt)
end

function love.draw()
end