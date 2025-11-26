--this is the base level where all level files come from, fork it to make new levels

if not package.loaded["catsing/level"] then
else
    package.loaded["catsing/level"]=false --delete reference to level to make sure
end

level = require("catsing/level")

level.load( --this makes all the level data
    "Programmin", --name
    "01", --id
    180, --bpm
    nil, --wait until i add it
    nil,
    nil,
    nil,
    nil,
    300, --endstep
    19, --from here, all values are note beats
    21,
    22,
    23
)

function love.update(dt) --update level state
    level.update(dt) --compressed to level.update
end

function love.draw()
    level.draw() --draws video and notes
end

function love.mousepressed(x, y, button)
    level.onClick() --when mouse is pressed, check for note clicks
end

function love.keypressed(key)
    if key == "space" then
        level.onClick() --also check for note clicks on spacebar
    end
end