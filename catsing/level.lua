local level = {} --level table
level.mdata = {} --metadata
level.mdata.bpm = 120
level.mdata.bpsec = level.mdata.bpm / 60
level.mdata.secpb = 1 / level.mdata.bpsec
level.mdata.name = "Tutorial"
level.mdata.id = "00"
level.mdata.curstep = 0
level.stats = {} --player stats
level.stats.miss = 0
level.stats.hp = 100
level.stats.missing = false
level.endstep = 400 --other variables for level
level.delta = 0
level.fulldelta = 0

level.notes = {} --notes table
level.notes.list = {} --list of notes
level.notes.funcs = {} --note functions
level.notes.funcs.__index = level.notes.funcs --funni index

function level.notes.add(number, beat) --guess what it does
    local newnote = {} --local note table
    newnote.y = 20 --fixed var
    newnote.spawnx = 20 * beat --fixed var
    newnote.x = newnote.spawnx --dynamic var
    newnote.r = 10 --fixed var
    newnote.stop = false --detects if the note has been hit or missed
    setmetatable(newnote, level.notes.funcs) --sets the metatable
    level.notes.list[number] = newnote --adds the note to the list
end

function level.notes.funcs:draw()
    if not self.stop then
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle("fill", self.x, self.y, self.r)
    end
end

function level.notes.funcs:update(dt)
    self.x = self.spawnx - (level.mdata.curstep * 20)
    if not self.stop and self.x < -19 then
        self.stop = true
        level.stats.hp = level.stats.hp - 10
        if level.stats.hp < 1 then
            level.unload("states/gameover;" .. level.mdata.id)
        end
        level.stats.miss = level.stats.miss + 1
        level.stats.missing = true --it basically checks for misses and also moves note
    end
end

function level.notes.funcs:onClick()
    if self.x < 19 and not self.stop then
        self.stop = true
        level.stats.hp = level.stats.hp + 10
        if level.stats.hp > 100 then
            level.stats.hp = 100
        end
        level.stats.missing = false
    end
end

function level.onClick() --called when the player clicks
    for _, note in pairs(level.notes.list) do
        note:onClick()
    end
end

function level.update(dt)
    level.delta = level.delta + dt
    while level.delta >= level.mdata.secpb do
        level.delta = level.delta - level.mdata.secpb
        level.mdata.curstep = level.mdata.curstep + 1
        if level.mdata.curstep > level.endstep then
            level.unload("states/mainmenu") --check for endstep
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

function level.load(name, id, bpm, vid, vidm, mus, musm, musv, estep, ...)
    --merge most of the code here...
    --setup
    level.mdata.bpm = bpm or 120
    level.mdata.bpsec = level.mdata.bpm / 60
    level.mdata.secpb = 1 / level.mdata.bpsec
    level.mdata.name = name or "Tutorial"
    level.mdata.id = id or "00"
    level.mdata.curstep = 0
    level.stats = {}
    level.stats.miss = 0
    level.stats.hp = 100
    level.stats.missing = false
    level.endstep = estep or 400
    level.delta = 0
    level.fulldelta = 0
    --load video and audio
    level.data = {}
    level.data.vS = love.video.newVideoStream(vid or "video/placeholder.ogv")
    level.data.vmS = love.video.newVideoStream(vidm or "video/placeholder.ogv")
    level.data.v = love.graphics.newVideo(level.data.vS)
    level.data.vm = love.graphics.newVideo(level.data.vmS)
    level.data.m = love.audio.newSource(mus or "audio/placeholder.ogg", "stream")
    level.data.mv = love.audio.newSource(musv or "audio/placeholderv.ogg", "stream")
    level.data.mm = love.audio.newSource(musm or "audio/placeholderm.ogg", "stream")
    --create notes
    local nocrea = {...}
    for i, beatnote in ipairs(nocrea) do
        level.notes.add(i, beatnote)
    end
    --original load
    level.data.m:seek(0)
    level.data.mv:seek(0)
    level.data.mm:seek(0)
    level.data.vS:seek(0)
    level.data.vmS:seek(0)
    level.data.v:seek(0)
    level.data.vm:seek(0)
    love.audio.play(level.data.m)
    love.audio.play(level.data.mm)
    love.audio.play(level.data.mv)
    level.data.vS:play()
    level.data.vmS:play()
    level.data.mm:setVolume(0)
end

function level.unload(statoswi)
    love.draw = function() end
    love.update = function(dt) end
    love.mousepressed = function(x, y, button) end
    love.keypressed = function(key) end
    state.switch(statoswi)
end

return level --return level