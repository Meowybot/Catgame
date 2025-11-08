level = require("catsing/level")

function love.load()
    level.mdata.setup("Tutorial", "00", 120, 4)
    level.notes.add(1, 4)
    level.notes.add(2, 8)
    level.data.v = love.graphics.newVideo("video/placeholder.ogv")
    level.data.vm = love.graphics.newVideo("video/placeholder.ogv")
    level.data.m = love.audio.newSource("audio/placeholder.ogg", "stream")
    level.data.mv = love.audio.newSource("audio/placeholderv.ogg", "stream")
    level.data.mm = love.audio.newSource("audio/placeholderm.ogg", "stream")
    level.load()
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