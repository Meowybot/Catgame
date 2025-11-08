function love.load()
    level = require("catsing/level")
    level.mdata.setup("Tutorial", "00", 120, 4)
    level.notes.add(1, 4)
    level.notes.add(2, 8)
    level.data.v = love.graphics.newVideo("video/tutorial.ogv")
    level.data.vm = love.graphics.newVideo("video/tutorialm.ogv")
    level.data.m = love.audio.newSource("audio/tutorial.ogg", "stream")
    level.data.mv = love.audio.newSource("audio/tutorialv.ogg", "stream")
    level.data.mm = love.audio.newSource("audio/tutorialm.ogg", "stream")
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