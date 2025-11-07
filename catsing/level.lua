local level = {}
level.mdata = {}
level.mdata.bpm = 120
level.mdata.spb = 4
level.mdata.bpsec = level.mdata.bpm / 60
level.mdata.secpb = 1 / level.mdata.bpsec
level.mdata.secps = level.mdata.secpb / level.mdata.spb
level.mdata.name = "Tutorial"
level.mdata.id = "00"
level.mdata.curstep = 0
level.stats = {}
level.stats.miss = 0
level.stats.hp = 100
level.stats.missing = false

function level.mdata.setup(name, id, bpm, spb)
    level.mdata.bpm = bpm or 120
    level.mdata.spb = spb or 4
    level.mdata.bpsec = level.mdata.bpm / 60
    level.mdata.secpb = 1 / level.mdata.bpsec
    level.mdata.secps = level.mdata.secpb / level.mdata.spb
    level.mdata.name = name or "Tutorial"
    level.mdata.id = id or "00"
    level.mdata.curstep = 0
end

local target_x = 0
local initial_spawn_offset_x = 800
local total_time_to_target = 4
local speed_per_second = (initial_spawn_offset_x - target_x) / total_time_to_target

level.notes = {}
level.notes.list = {}
level.notes.funcs = {}
level.notes.funcs.__index = level.notes.funcs

function level.notes.add(number, step)
    local newnote = {}
    newnote.y = 20
    local time_to_hit = step * level.mdata.secps
    newnote.x = initial_spawn_offset_x + (time_to_hit * speed_per_second)
    newnote.r = 25
    newnote.stop = false
    setmetatable(newnote, level.notes.funcs)
    level.notes.list[number] = newnote
end

function level.notes.funcs:draw()
    love.graphics.circle("fill", self.x, self.y, self.r)
end

function level.notes.funcs:update(dt)
    self.x = self.x - (dt * speed_per_second)
    if not self.stop and self.x < -27 then
        self.stop = true
        level.stats.hp = level.stats.hp - 10
        if level.stats.hp < 1 then
            state.switch("states/gameover.lua")
        end
        level.stats.miss = level.stats.miss + 1
        level.stats.missing = true
    end
end

function level.notes.funcs:onClick()
    if self.x < 27 and not self.stop then
        self.stop = true
        level.stats.hp = level.stats.hp + 10
        if level.stats.hp > 100 then
            level.stats.hp = 100
        end
        level.stats.missing = false
    end
end


level.data = {}
level.data.v = love.graphics.newVideo("video/tutorial.ogv")
level.data.vm = love.graphics.newVideo("video/tutorialm.ogv")
level.data.m = love.audio.newSource("audio/tutorial.ogg", "stream")
level.data.mv = love.audio.newSource("audio/tutorialv.ogg", "stream")

function level.onClick()
    for _, note in pairs(level.notes.list) do
        note:onClick()
    end
end

function level.load()
    level.data.m:play()
    level.data.mv:play()
    level.data.v:play()
    level.data.vm:play()
end

function level.update(dt)
    for _, note in pairs(level.notes.list) do
        note:update(dt)
    end
    if level.stats.missing then
        level.data.mv:setVolume(0)
    else
        level.data.mv:setVolume(1)
    end
end

function level.draw()
    love.graphics.draw(level.data.v)
    if level.stats.missing then
        love.graphics.draw(level.data.vm)
    end
    for _, note in pairs(level.notes.list) do
        note:draw()
    end
end

return level