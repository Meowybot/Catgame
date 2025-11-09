level = require("catsing/level")

function love.load()
    level.mdata.setup("Tutorial", "00", 120)
    level.notes.add(1, 4)
    level.notes.add(2, 8)
    level.notes.add(3, 50)
    
    level.load_resources(
        "video/placeholder.ogv",
        "video/placeholder.ogv",
        "audio/placeholder.ogg",
        "audio/placeholderm.ogg",
        "audio/placeholderv.ogg"
    )

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