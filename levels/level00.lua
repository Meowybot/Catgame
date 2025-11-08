level = require("catsing/level")

function love.load()
    level.mdata.setup("Tutorial", "00", 120, 4)
    level.notes.add(1, 4)
    level.notes.add(2, 8)
    level.notes.add(3, 50)
    level.data.v = love.graphics.newVideo("video/placeholder.ogv")
    level.data.vm = love.graphics.newVideo("video/placeholder.ogv")
    level.data.m = love.audio.newSource("audio/placeholder.ogg", "stream")
    level.data.mv = love.audio.newSource("audio/placeholderv.ogg", "stream")
    level.data.mm = love.audio.newSource("audio/placeholderm.ogg", "stream")
    level.data.m:rewind()
    level.data.mv:rewind()
    level.data.mm:rewind()
    level.data.v:rewind()
    level.data.vm:rewind()
    level.data.m:play()
    level.data.mv:play()
    level.data.mm:play()
    level.data.v:play()
    level.data.vm:play()
    level.data.mm:setVolume(0)
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