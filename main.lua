function love.load()
    state = require("lib/stateswitcher")
    catsing = require("loadvars")
    state.switch("states/mainmenu")
    --switches to mm
end

function love.update(dt)
end

function love.draw()
end