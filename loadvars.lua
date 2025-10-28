catsing = {}
catsing.level = {}
catsing.level.hp = 50
catsing.level.miss = 0
catsing.level.loaded = "level00"
catsing.level.bpm = 120
catsing.level.bpsec = catsing.level.bpm / 60
catsing.level.secpb = 1 / catsing.level.bpsec
catsing.level.spb = 4
catsing.level.secps = catsing.level.secpb / catsing.level.spb
catsing.level.beatcounter = 0
catsing.level.counter = 0
catsing.level.notecolor = {}
catsing.level.notecolor[1] = "white"
catsing.level.lastnotehit = {}
catsing.level.lastnotehit[1] = true
catsing.objectfuncs = {}
catsing.objects = {}
catsing.objects.bg = {}
catsing.objects.bg.image = love.graphics.newImage('assets/img/placeholder.png')
--initial variables for levels

function catsing.level.load(name)
    catsing.level.loaded = name or "level00"
    state.switch("assets/levels/" .. catsing.level.loaded .. "/chart")
    --loads chart.lua from level folder
end

function catsing.level.onstep(step)
    --empty function for levels
end

function catsing.level.onevent(name, type)
    --empty function for levels
end

function catsing.level.setsteps(dt)
    catsing.level.counter = catsing.level.counter + dt
    while catsing.level.counter >= catsing.level.secps do
        catsing.level.counter = catsing.level.counter - catsing.level.secps
        catsing.level.beatcounter = catsing.level.beatcounter + 1
        catsing.level.onstep(catsing.level.beatcounter)
        -- lag spikes could cause game over on songs with notes close to the start
    end
end

function catsing.level.getsteps()
    return catsing.level.beatcounter
    --returns the current step
end

function catsing.level.lightnote(number, color)
    catsing.level.notecolor[number] = color
    if catsing.level.lastnotehit[number] then
        catsing.level.hp = catsing.level.hp + 1
        if color ~= "white" then
            catsing.level.lastnotehit[number] = true
        else
            catsing.level.lastnotehit[number] = false
        end
    else
        if color ~= "white" then
            catsing.level.lastnotehit[number] = true
        end
        catsing.level.hp = catsing.level.hp - 1
        catsing.level.miss = catsing.level.miss + 1
    end
    --TODO: add and call functions for actually lighting notes and adding anims and sound
end

function catsing.createobj(name, imagename, xpos, ypos, scalex, scaley, visible)
    local createdobj = {
        image = love.graphics.newImage(image) or love.graphics.newImage('assets/img/placeholder.png'),
        x = xpos or 0
        y = ypos or 0
        scaleX = scalex or 1
        scaleY = scaley or 1
        visible = visible or true
        anims = {}
        idleanim = nil
        currentanim = nil
        singanim = nil
        missanim = nil
    }
    
    setmetatable(createdobj, catsing.objectfuncs)
    catsing.objects[name] = createdobj
end

function catsing.objectfuncs:draw()
    if self.visible == true then
        love.graphics.draw(self.image, self.x, self.y, 0, self.scaleX, self.scaleY)
    end
end

function catsing.objectfuncs:setPosition(xpos, ypos)
    self.x = xpos
    self.y = ypos
end

function catsing.objectfuncs:setScale(scalex, scaley)
    self.scaleX = scalex
    self.scaleY = scaley
end

function catsing.objectfuncs:setVisibility(visible)
    self.visible = visible
end

function catsing.objectfuncs:playanim()
    --empty function for future use
end

function catsing.objectfuncs:setidle(anim)
    self.idleanim = self.anims[anim]
end

return catsing
--returns table