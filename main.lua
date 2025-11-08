state = require("lib/stateswitcher")

function love.load()
    love.window.setTitle("CatSing! by CS!T")
    state.switch("states/mainmenu")
end

function love.update(dt)
end

function love.draw()
end