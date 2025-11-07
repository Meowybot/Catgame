function love.load()
    love.window.setTitle("CatSing! by CS!T")
    state = require("lib/stateswitcher")
    state.switch("states/mainmenu")
end

function love.update(dt)
end

function love.draw()
end