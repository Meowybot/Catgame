function love.load()
    state = require("lib/stateswitcher")
    catsing = require("newloadvars")
    state.switch("states/mainmenu")
    --switches to mm state
end

function love.update(dt)
end

function love.draw()
end