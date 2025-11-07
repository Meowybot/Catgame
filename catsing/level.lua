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
    setmetatable(newnote, level.notes.funcs)
    level.notes.list[number] = newnote
end

function level.notes.funcs:update(dt)
    self.x = self.x - (dt * speed_per_second)
end

level.data = {}
level.data.v = love.graphics.newVideo("video/tutorial.ogv")
level.data.vm = love.graphics.newVideo("video/tutorialm.ogv")
level.data.m = love.audio.newSource("audio/tutorial.ogg", "stream")
level.data.mv = love.audio.newSource("audio/tutorialv.ogg", "stream")