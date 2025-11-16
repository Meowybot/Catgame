if not package.loaded[level] then
else
    package.loaded[level]=false
end

level = require("catsing/level")

level.load(
    "Programmin",
    "01",
    180,
    nil,
    nil,
    nil,
    nil,
    nil,
    19,
    21,
    22,
    23
)

function love.update(dt)
    level.delta = level.delta + dt
    while level.delta >= level.mdata.secpb do
        level.delta = level.delta - level.mdata.secpb
        level.mdata.curstep = level.mdata.curstep + 1
        if level.mdata.curstep > level.endstep then
            state.switch("states/mainmenu")
        end
    end
    level.fulldelta = level.fulldelta + dt
    for _, note in pairs(level.notes.list) do
        note:update(dt)
    end
    if level.stats.missing then
        level.data.mv:setVolume(0)
        level.data.mm:setVolume(1)
    else
        level.data.mv:setVolume(1)
        level.data.mm:setVolume(0)
    end
end

function love.draw()
    love.graphics.draw(level.data.v)
    if level.stats.missing then
        love.graphics.draw(level.data.vm)
    end
    for _, note in pairs(level.notes.list) do
        note:draw()
    end
end

function love.mousepressed(x, y, button)
    level.onClick()
end

function love.keypressed(key)
    if key == "space" then
        level.onClick()
    end
end