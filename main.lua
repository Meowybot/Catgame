state = require("lib/stateswitcher") --load for switching state

function love.load()
    state.switch("levels/level01") --this level will be loaded first for testing purposes
end

function love.update(dt) --no update, that will be handled in other states
end

function love.draw() --same reason as update
end