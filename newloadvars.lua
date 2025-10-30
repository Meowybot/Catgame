--========================================
-- CatSing! - loadvars.lua
-- Core variable setup, level logic, and object system
--========================================

catsing = {}

--========================
-- Level / Rhythm Data
--========================
catsing.level = {
    hp = 50,
    miss = 0,
    loaded = "level00",
    bpm = 120,
}

-- Beat timing calculations
catsing.level.bpsec  = catsing.level.bpm / 60              -- beats per second
catsing.level.secpb  = 1 / catsing.level.bpsec             -- seconds per beat
catsing.level.spb    = 4                                   -- steps per beat (subdivisions)
catsing.level.secps  = catsing.level.secpb / catsing.level.spb  -- seconds per step
catsing.level.beatcounter = 0
catsing.level.counter = 0

catsing.level.notecolor = { "white", "white" }
catsing.level.lastnotehit = { true, true }

--========================
-- Object System
--========================
catsing.objects = {}
catsing.objectfuncs = {}

--========================
-- Level Functions
--========================

-- Load a level's chart
function catsing.level.load(name)
    catsing.level.loaded = name or "level00"
    state.switch("assets/levels/" .. catsing.level.loaded .. "/chart")
end

-- Called every beat step
function catsing.level.onstep(step)
    -- Empty placeholder for level logic
    -- Override this per-level to trigger events
end

-- Called when events occur (e.g. section changes)
function catsing.level.onevent(name, type)
    -- Empty placeholder
end

-- Beat timing update (should run every frame)
function catsing.level.setsteps(dt)
    catsing.level.counter = catsing.level.counter + dt

    while catsing.level.counter >= catsing.level.secps do
        catsing.level.counter = catsing.level.counter - catsing.level.secps
        catsing.level.beatcounter = catsing.level.beatcounter + 1
        catsing.level.onstep(catsing.level.beatcounter)
        -- Note: lag spikes early in a song could cause skipped beats
    end
end

-- Returns current beat step
function catsing.level.getsteps()
    return catsing.level.beatcounter
end

-- Handles when a note lights up / player interacts
function catsing.level.lightnote(number, color)
    local wasHitBefore = catsing.level.lastnotehit[number]
    local isNoteActive = color ~= "white"

    catsing.level.notecolor[number] = color

    if isNoteActive then
        if wasHitBefore then
            catsing.level.hp = catsing.level.hp + 1
        else
            catsing.level.hp = catsing.level.hp - 1
            catsing.level.miss = catsing.level.miss + 1
        end
        catsing.level.lastnotehit[number] = true
    else
        catsing.level.lastnotehit[number] = false
    end

    -- TODO: Add visuals, animations, and sounds here
end

--========================
-- Object Creation & Handling
--========================

function catsing.createobj(name, imagename, xpos, ypos, scalex, scaley, visible, animstable)
    local createdobj = {
        image = love.graphics.newImage(imagename or "assets/img/placeholder.png"),
        x = xpos or 0,
        y = ypos or 0,
        scaleX = scalex or 1,
        scaleY = scaley or 1,
        visible = (visible == nil) and true or visible,
        anims = animstable or {},
        idleanim = nil,
        currentanim = nil,
        singanim = nil,
        missanim = nil
    }

    setmetatable(createdobj, { __index = catsing.objectfuncs })
    catsing.objects[name] = createdobj
    return createdobj
end

--========================
-- Object Methods
--========================

function catsing.objectfuncs:draw()
    if self.visible then
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

function catsing.objectfuncs:playanim(anim)
    -- Placeholder for animation handling
    -- e.g., self.currentanim = self.anims[anim]
end

function catsing.objectfuncs:setidle(anim)
    self.idleanim = self.anims[anim]
end

--========================
-- Default Background Object
--========================
catsing.objects.bg = {
    image = love.graphics.newImage('assets/img/placeholder.png'),
    x = 0,
    y = 0,
    scaleX = 1,
    scaleY = 1,
    visible = true
}
setmetatable(catsing.objects.bg, { __index = catsing.objectfuncs })

--========================
-- Return the catsing table
--========================
return catsing