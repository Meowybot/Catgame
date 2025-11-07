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
level.stats.score = 0

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
    newnote.missed = false
    setmetatable(newnote, level.notes.funcs)
    level.notes.list[number] = newnote
end

function level.notes.funcs:update(dt)
    self.x = self.x - (dt * speed_per_second)
    if not self.missed and self.x < 27 then
        self.missed = true
        level.stats.hp = level.stats.hp - 10
        level.stats.miss = level.stats.miss + 1
    end
end

level.data = {}
level.data.v = love.graphics.newVideo("video/tutorial.ogv")
level.data.vm = love.graphics.newVideo("video/tutorialm.ogv")
level.data.m = love.audio.newSource("audio/tutorial.ogg", "stream")
level.data.mv = love.audio.newSource("audio/tutorialv.ogg", "stream")

function level.onClick()
end