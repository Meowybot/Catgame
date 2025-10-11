function love.load()
    state = require("lib/stateswitcher")
    catsing = require("loadvars")
    state.switch("states/mainmenu")
end

function love.update(dt)
end

function love.draw()
end