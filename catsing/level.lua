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
level.notes = {}
level.notes.list = {}
level.notes.funcs = {}

function level.notes.add(number, step)
    local newnote = {}
    newnote.y = 20
    newnote.x = step * 10
    newnote.r = 25
    setmetatable(newnote, level.notes.funcs)
    level.notes.list[number] = newnote
end

function level.notes.funcs:update(dt)
    self.x = self.x - (dt * 300)
end