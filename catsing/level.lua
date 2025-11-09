local level = {}
level.mdata = {}
level.mdata.bpm = 120
level.mdata.bpsec = level.mdata.bpm / 60
level.mdata.secpb = 1 / level.mdata.bpsec
level.mdata.name = "Tutorial"
level.mdata.id = "00"
level.mdata.curstep = 0
level.stats = {}
level.stats.miss = 0
level.stats.hp = 100
level.stats.missing = false
level.endstep = 100
level.delta = 0
level.fulldelta = 0

function level.mdata.setup(name, id, bpm)
    level.mdata.bpm = bpm or 120
    level.mdata.bpsec = level.mdata.bpm / 60
    level.mdata.secpb = 1 / level.mdata.bpsec
    level.mdata.name = name or "Tutorial"
    level.mdata.id = id or "00"
    level.mdata.curstep = 0
end

level.notes = {}
level.notes.list = {}
level.notes.funcs = {}
level.notes.funcs.__index = level.notes.funcs

function level.notes.add(number, beat)
    local newnote = {}
    newnote.y = 20
    newnote.spawnx = 20 * beat
    newnote.x = newnote.spawnx
    newnote.r = 15
    newnote.stop = false
    setmetatable(newnote, level.notes.funcs)
    level.notes.list[number] = newnote
end

function level.notes.funcs:draw()
    if not self.stop then
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle("fill", self.x, self.y, self.r)
    end
end

function level.notes.funcs:update(dt)
    self.x = self.spawnx - (level.mdata.curstep * 20)
    if not self.stop and self.x < -27 then
        self.stop = true
        level.stats.hp = level.stats.hp - 10
        if level.stats.hp < 1 then
            state.switch("states/gameover")
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
level.data.vS = love.video.newVideoStream("video/placeholder.ogv")
level.data.vmS = love.video.newVideoStream("video/placeholder.ogv")
level.data.v = love.graphics.newVideo(level.data.vS)
level.data.vm = love.graphics.newVideo(level.data.vmS)
level.data.m = love.audio.newSource("audio/placeholder.ogg", "stream")
level.data.mv = love.audio.newSource("audio/placeholderv.ogg", "stream")
level.data.mm = love.audio.newSource("audio/placeholderm.ogg", "stream")

function level.onClick()
    for _, note in pairs(level.notes.list) do
        note:onClick()
    end
end

function level.load()
    level.data.m:seek(0)
    level.data.mv:seek(0)
    level.data.mm:seek(0)
    level.data.vS:seek(0)
    level.data.vmS:seek(0)
    level.data.v:seek(0)
    level.data.vm:seek(0)
    love.audio.play(level.data.m, level.data.mm, level.data.mv)
    level.data.vS:play()
    level.data.vmS:play()
    level.data.v:play()
    level.data.vm:play()
    level.data.mm:setVolume(0)
end

function level.update(dt)
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